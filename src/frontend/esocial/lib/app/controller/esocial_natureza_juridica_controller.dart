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
import 'package:esocial/app/data/repository/esocial_natureza_juridica_repository.dart';
import 'package:esocial/app/page/shared_page/shared_page_imports.dart';
import 'package:esocial/app/page/shared_widget/message_dialog.dart';
import 'package:esocial/app/mixin/controller_base_mixin.dart';

class EsocialNaturezaJuridicaController extends GetxController with ControllerBaseMixin {
  final EsocialNaturezaJuridicaRepository esocialNaturezaJuridicaRepository;
  EsocialNaturezaJuridicaController({required this.esocialNaturezaJuridicaRepository});

  // general
  final _dbColumns = EsocialNaturezaJuridicaModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = EsocialNaturezaJuridicaModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = esocialNaturezaJuridicaGridColumns();
  
  var _esocialNaturezaJuridicaModelList = <EsocialNaturezaJuridicaModel>[];

  final _esocialNaturezaJuridicaModel = EsocialNaturezaJuridicaModel().obs;
  EsocialNaturezaJuridicaModel get esocialNaturezaJuridicaModel => _esocialNaturezaJuridicaModel.value;
  set esocialNaturezaJuridicaModel(value) => _esocialNaturezaJuridicaModel.value = value ?? EsocialNaturezaJuridicaModel();

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
    for (var esocialNaturezaJuridicaModel in _esocialNaturezaJuridicaModelList) {
      plutoRowList.add(_getPlutoRow(esocialNaturezaJuridicaModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(EsocialNaturezaJuridicaModel esocialNaturezaJuridicaModel) {
    return PlutoRow(
      cells: _getPlutoCells(esocialNaturezaJuridicaModel: esocialNaturezaJuridicaModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ EsocialNaturezaJuridicaModel? esocialNaturezaJuridicaModel}) {
    return {
			"id": PlutoCell(value: esocialNaturezaJuridicaModel?.id ?? 0),
			"grupo": PlutoCell(value: esocialNaturezaJuridicaModel?.grupo ?? 0),
			"codigo": PlutoCell(value: esocialNaturezaJuridicaModel?.codigo ?? ''),
			"descricao": PlutoCell(value: esocialNaturezaJuridicaModel?.descricao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _esocialNaturezaJuridicaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      esocialNaturezaJuridicaModel.plutoRowToObject(plutoRow);
    } else {
      esocialNaturezaJuridicaModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Natureza Jurídica]';
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
    await Get.find<EsocialNaturezaJuridicaController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await esocialNaturezaJuridicaRepository.getList(filter: filter).then( (data){ _esocialNaturezaJuridicaModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Natureza Jurídica',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			grupoController.text = currentRow.cells['grupo']?.value?.toString() ?? '';
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.esocialNaturezaJuridicaEditPage)!.then((value) {
        if (esocialNaturezaJuridicaModel.id == 0) {
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
    esocialNaturezaJuridicaModel = EsocialNaturezaJuridicaModel();
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
        if (await esocialNaturezaJuridicaRepository.delete(id: currentRow.cells['id']!.value)) {
          _esocialNaturezaJuridicaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final grupoController = TextEditingController();
	final codigoController = TextEditingController();
	final descricaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = esocialNaturezaJuridicaModel.id;
		plutoRow.cells['grupo']?.value = esocialNaturezaJuridicaModel.grupo;
		plutoRow.cells['codigo']?.value = esocialNaturezaJuridicaModel.codigo;
		plutoRow.cells['descricao']?.value = esocialNaturezaJuridicaModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await esocialNaturezaJuridicaRepository.save(esocialNaturezaJuridicaModel: esocialNaturezaJuridicaModel); 
        if (result != null) {
          esocialNaturezaJuridicaModel = result;
          if (_isInserting) {
            _esocialNaturezaJuridicaModelList.add(result);
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
		functionName = "esocial_natureza_juridica";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		grupoController.dispose();
		codigoController.dispose();
		descricaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}