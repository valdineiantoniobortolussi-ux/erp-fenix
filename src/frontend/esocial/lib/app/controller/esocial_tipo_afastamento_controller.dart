import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:esocial/app/infra/infra_imports.dart';
import 'package:esocial/app/controller/controller_imports.dart';
import 'package:esocial/app/data/model/model_imports.dart';
import 'package:esocial/app/page/grid_columns/grid_columns_imports.dart';

import 'package:esocial/app/routes/app_routes.dart';
import 'package:esocial/app/data/repository/esocial_tipo_afastamento_repository.dart';
import 'package:esocial/app/page/shared_page/shared_page_imports.dart';
import 'package:esocial/app/page/shared_widget/message_dialog.dart';
import 'package:esocial/app/mixin/controller_base_mixin.dart';

class EsocialTipoAfastamentoController extends GetxController with ControllerBaseMixin {
  final EsocialTipoAfastamentoRepository esocialTipoAfastamentoRepository;
  EsocialTipoAfastamentoController({required this.esocialTipoAfastamentoRepository});

  // general
  final _dbColumns = EsocialTipoAfastamentoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = EsocialTipoAfastamentoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = esocialTipoAfastamentoGridColumns();
  
  var _esocialTipoAfastamentoModelList = <EsocialTipoAfastamentoModel>[];

  final _esocialTipoAfastamentoModel = EsocialTipoAfastamentoModel().obs;
  EsocialTipoAfastamentoModel get esocialTipoAfastamentoModel => _esocialTipoAfastamentoModel.value;
  set esocialTipoAfastamentoModel(value) => _esocialTipoAfastamentoModel.value = value ?? EsocialTipoAfastamentoModel();

  final _filter = Filter().obs;
  Filter get filter => _filter.value;
  set filter(value) => _filter.value = value ?? Filter(); 

  var _isInserting = false;

  // list page
  late StreamSubscription _keyboardListener;
  get keyboardListener => _keyboardListener;
  set keyboardListener(value) => _keyboardListener = value;

  late PlutoGridStateManager _plutoGridStateManager;
  get plutoGridStateManager => _plutoGridStateManager;
  set plutoGridStateManager(value) => _plutoGridStateManager = value;

  final _plutoRow = PlutoRow(cells: {}).obs;
  get plutoRow => _plutoRow.value;
  set plutoRow(value) => _plutoRow.value = value;

  List<PlutoRow> plutoRows() {
    List<PlutoRow> plutoRowList = <PlutoRow>[];
    for (var esocialTipoAfastamentoModel in _esocialTipoAfastamentoModelList) {
      plutoRowList.add(_getPlutoRow(esocialTipoAfastamentoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(EsocialTipoAfastamentoModel esocialTipoAfastamentoModel) {
    return PlutoRow(
      cells: _getPlutoCells(esocialTipoAfastamentoModel: esocialTipoAfastamentoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ EsocialTipoAfastamentoModel? esocialTipoAfastamentoModel}) {
    return {
			"id": PlutoCell(value: esocialTipoAfastamentoModel?.id ?? 0),
			"codigo": PlutoCell(value: esocialTipoAfastamentoModel?.codigo ?? ''),
			"descricao": PlutoCell(value: esocialTipoAfastamentoModel?.descricao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _esocialTipoAfastamentoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      esocialTipoAfastamentoModel.plutoRowToObject(plutoRow);
    } else {
      esocialTipoAfastamentoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Tipo Afastamento]';
    filterController.standardFilter = true;
    filterController.aliasColumns = aliasColumns;
    filterController.dbColumns = dbColumns;
    filterController.filter.field = 'Id';

    filter = await Get.toNamed(Routes.filterPage);
    await loadData();
  }

  Future loadData() async {
    _plutoGridStateManager.setShowLoading(true);
    _plutoGridStateManager.removeAllRows();
    await Get.find<EsocialTipoAfastamentoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await esocialTipoAfastamentoRepository.getList(filter: filter).then( (data){ _esocialTipoAfastamentoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Tipo Afastamento',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.esocialTipoAfastamentoEditPage)!.then((value) {
        if (esocialTipoAfastamentoModel.id == 0) {
          _plutoGridStateManager.removeCurrentRow();
        }
      });
    } else {
      showInfoSnackBar(message: 'message_select_one_to_edited'.tr);
    }
  }

  void callEditPageToInsert() {
    _plutoGridStateManager.prependNewRows(); 
    final cell = _plutoGridStateManager.rows.first.cells.entries.elementAt(0).value;
    _plutoGridStateManager.setCurrentCell(cell, 0); 
    _isInserting = true;
    esocialTipoAfastamentoModel = EsocialTipoAfastamentoModel();
    callEditPage();   
  }

  void handleKeyboard(PlutoKeyManagerEvent event) {
    if (event.isKeyDownEvent && event.event.logicalKey.keyId == LogicalKeyboardKey.enter.keyId) {
      if (canUpdate) {
        callEditPage();
      } else {
        noPrivilegeMessage();
      }
    }
  }  

  Future delete() async {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
      showDeleteDialog(() async {
        if (await esocialTipoAfastamentoRepository.delete(id: currentRow.cells['id']!.value)) {
          _esocialTipoAfastamentoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
          _plutoGridStateManager.removeCurrentRow();
        } else {
          showErrorSnackBar(message: 'message_error_delete'.tr);
        }
      });
    } else {
      showInfoSnackBar(message: 'message_select_one_to_delete'.tr);
    }
  }


  // edit page
  final scrollController = ScrollController();
	final codigoController = TextEditingController();
	final descricaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = esocialTipoAfastamentoModel.id;
		plutoRow.cells['codigo']?.value = esocialTipoAfastamentoModel.codigo;
		plutoRow.cells['descricao']?.value = esocialTipoAfastamentoModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await esocialTipoAfastamentoRepository.save(esocialTipoAfastamentoModel: esocialTipoAfastamentoModel); 
        if (result != null) {
          esocialTipoAfastamentoModel = result;
          if (_isInserting) {
            _esocialTipoAfastamentoModelList.add(result);
            _isInserting = false;
          }
          objectToPlutoRow();
          Get.back();
        }
      } else {
        Get.back();
      }
    }
  }

  void preventDataLoss() {
    if (formWasChanged) {
      showQuestionDialog('message_data_loss'.tr, () => Get.back());
    } else {
      Get.back();
    }
  }  


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "esocial_tipo_afastamento";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codigoController.dispose();
		descricaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}