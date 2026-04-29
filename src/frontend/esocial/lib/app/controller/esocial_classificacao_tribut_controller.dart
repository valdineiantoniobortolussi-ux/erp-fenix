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
import 'package:esocial/app/data/repository/esocial_classificacao_tribut_repository.dart';
import 'package:esocial/app/page/shared_page/shared_page_imports.dart';
import 'package:esocial/app/page/shared_widget/message_dialog.dart';
import 'package:esocial/app/mixin/controller_base_mixin.dart';

class EsocialClassificacaoTributController extends GetxController with ControllerBaseMixin {
  final EsocialClassificacaoTributRepository esocialClassificacaoTributRepository;
  EsocialClassificacaoTributController({required this.esocialClassificacaoTributRepository});

  // general
  final _dbColumns = EsocialClassificacaoTributModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = EsocialClassificacaoTributModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = esocialClassificacaoTributGridColumns();
  
  var _esocialClassificacaoTributModelList = <EsocialClassificacaoTributModel>[];

  final _esocialClassificacaoTributModel = EsocialClassificacaoTributModel().obs;
  EsocialClassificacaoTributModel get esocialClassificacaoTributModel => _esocialClassificacaoTributModel.value;
  set esocialClassificacaoTributModel(value) => _esocialClassificacaoTributModel.value = value ?? EsocialClassificacaoTributModel();

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
    for (var esocialClassificacaoTributModel in _esocialClassificacaoTributModelList) {
      plutoRowList.add(_getPlutoRow(esocialClassificacaoTributModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(EsocialClassificacaoTributModel esocialClassificacaoTributModel) {
    return PlutoRow(
      cells: _getPlutoCells(esocialClassificacaoTributModel: esocialClassificacaoTributModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ EsocialClassificacaoTributModel? esocialClassificacaoTributModel}) {
    return {
			"id": PlutoCell(value: esocialClassificacaoTributModel?.id ?? 0),
			"codigo": PlutoCell(value: esocialClassificacaoTributModel?.codigo ?? ''),
			"descricao": PlutoCell(value: esocialClassificacaoTributModel?.descricao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _esocialClassificacaoTributModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      esocialClassificacaoTributModel.plutoRowToObject(plutoRow);
    } else {
      esocialClassificacaoTributModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Classificação Tributária]';
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
    await Get.find<EsocialClassificacaoTributController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await esocialClassificacaoTributRepository.getList(filter: filter).then( (data){ _esocialClassificacaoTributModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Classificação Tributária',
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
      Get.toNamed(Routes.esocialClassificacaoTributEditPage)!.then((value) {
        if (esocialClassificacaoTributModel.id == 0) {
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
    esocialClassificacaoTributModel = EsocialClassificacaoTributModel();
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
        if (await esocialClassificacaoTributRepository.delete(id: currentRow.cells['id']!.value)) {
          _esocialClassificacaoTributModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
		plutoRow.cells['id']?.value = esocialClassificacaoTributModel.id;
		plutoRow.cells['codigo']?.value = esocialClassificacaoTributModel.codigo;
		plutoRow.cells['descricao']?.value = esocialClassificacaoTributModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await esocialClassificacaoTributRepository.save(esocialClassificacaoTributModel: esocialClassificacaoTributModel); 
        if (result != null) {
          esocialClassificacaoTributModel = result;
          if (_isInserting) {
            _esocialClassificacaoTributModelList.add(result);
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
		functionName = "esocial_classificacao_tribut";
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