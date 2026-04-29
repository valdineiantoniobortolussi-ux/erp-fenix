import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/controller/controller_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/page/grid_columns/grid_columns_imports.dart';

import 'package:cte/app/routes/app_routes.dart';
import 'package:cte/app/data/repository/cte_documento_anterior_id_repository.dart';
import 'package:cte/app/page/shared_page/shared_page_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';
import 'package:cte/app/mixin/controller_base_mixin.dart';

class CteDocumentoAnteriorIdController extends GetxController with ControllerBaseMixin {
  final CteDocumentoAnteriorIdRepository cteDocumentoAnteriorIdRepository;
  CteDocumentoAnteriorIdController({required this.cteDocumentoAnteriorIdRepository});

  // general
  final _dbColumns = CteDocumentoAnteriorIdModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = CteDocumentoAnteriorIdModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = cteDocumentoAnteriorIdGridColumns();
  
  var _cteDocumentoAnteriorIdModelList = <CteDocumentoAnteriorIdModel>[];

  final _cteDocumentoAnteriorIdModel = CteDocumentoAnteriorIdModel().obs;
  CteDocumentoAnteriorIdModel get cteDocumentoAnteriorIdModel => _cteDocumentoAnteriorIdModel.value;
  set cteDocumentoAnteriorIdModel(value) => _cteDocumentoAnteriorIdModel.value = value ?? CteDocumentoAnteriorIdModel();

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
    for (var cteDocumentoAnteriorIdModel in _cteDocumentoAnteriorIdModelList) {
      plutoRowList.add(_getPlutoRow(cteDocumentoAnteriorIdModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(CteDocumentoAnteriorIdModel cteDocumentoAnteriorIdModel) {
    return PlutoRow(
      cells: _getPlutoCells(cteDocumentoAnteriorIdModel: cteDocumentoAnteriorIdModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ CteDocumentoAnteriorIdModel? cteDocumentoAnteriorIdModel}) {
    return {
 			"id": PlutoCell(value: cteDocumentoAnteriorIdModel?.id ?? 0),
 			"cteDocumentoAnterior": PlutoCell(value: cteDocumentoAnteriorIdModel?.idCteDocumentoAnterior ?? 0),
 			"tipo": PlutoCell(value: cteDocumentoAnteriorIdModel?.tipo ?? ''),
 			"serie": PlutoCell(value: cteDocumentoAnteriorIdModel?.serie ?? ''),
 			"subserie": PlutoCell(value: cteDocumentoAnteriorIdModel?.subserie ?? ''),
 			"numero": PlutoCell(value: cteDocumentoAnteriorIdModel?.numero ?? ''),
 			"dataEmissao": PlutoCell(value: cteDocumentoAnteriorIdModel?.dataEmissao ?? ''),
 			"chaveCte": PlutoCell(value: cteDocumentoAnteriorIdModel?.chaveCte ?? ''),
 			"idCteDocumentoAnterior": PlutoCell(value: cteDocumentoAnteriorIdModel?.idCteDocumentoAnterior ?? 0),
 		};
  }

  void plutoRowToObject() {
    final modelFromRow = _cteDocumentoAnteriorIdModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      cteDocumentoAnteriorIdModel.plutoRowToObject(plutoRow);
    } else {
      cteDocumentoAnteriorIdModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Cte Documento Anterior Id]';
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
    await Get.find<CteDocumentoAnteriorIdController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await cteDocumentoAnteriorIdRepository.getList(filter: filter).then( (data){ _cteDocumentoAnteriorIdModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Cte Documento Anterior Id',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			cteDocumentoAnteriorModelController.text = currentRow.cells['cteDocumentoAnterior']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			chaveCteController.text = currentRow.cells['chaveCte']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.cteDocumentoAnteriorIdEditPage)!.then((value) {
        if (cteDocumentoAnteriorIdModel.id == 0) {
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
    cteDocumentoAnteriorIdModel = CteDocumentoAnteriorIdModel();
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
        if (await cteDocumentoAnteriorIdRepository.delete(id: currentRow.cells['id']!.value)) {
          _cteDocumentoAnteriorIdModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final cteDocumentoAnteriorModelController = TextEditingController();
	final numeroController = TextEditingController();
	final chaveCteController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
 		plutoRow.cells['id']?.value = cteDocumentoAnteriorIdModel.id;
 		plutoRow.cells['idCteDocumentoAnterior']?.value = cteDocumentoAnteriorIdModel.idCteDocumentoAnterior;
 		plutoRow.cells['cteDocumentoAnterior']?.value = cteDocumentoAnteriorIdModel.idCteDocumentoAnterior ?? 0;
 		plutoRow.cells['tipo']?.value = cteDocumentoAnteriorIdModel.tipo;
 		plutoRow.cells['serie']?.value = cteDocumentoAnteriorIdModel.serie;
 		plutoRow.cells['subserie']?.value = cteDocumentoAnteriorIdModel.subserie;
 		plutoRow.cells['numero']?.value = cteDocumentoAnteriorIdModel.numero;
 		plutoRow.cells['dataEmissao']?.value = Util.formatDate(cteDocumentoAnteriorIdModel.dataEmissao);
 		plutoRow.cells['chaveCte']?.value = cteDocumentoAnteriorIdModel.chaveCte;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await cteDocumentoAnteriorIdRepository.save(cteDocumentoAnteriorIdModel: cteDocumentoAnteriorIdModel); 
        if (result != null) {
          cteDocumentoAnteriorIdModel = result;
          if (_isInserting) {
            _cteDocumentoAnteriorIdModelList.add(result);
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

	Future callCteDocumentoAnteriorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Cte Documento Anterior]'; 
		lookupController.route = '/cte-documento-anterior/'; 
 		lookupController.gridColumns = cteDocumentoAnteriorIdGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CteDocumentoAnteriorIdModel.aliasColumns; 
		lookupController.dbColumns = CteDocumentoAnteriorIdModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			cteDocumentoAnteriorIdModel.idCteDocumentoAnterior = plutoRowResult.cells['idCteDocumentoAnterior']?.value ?? 0; 
			cteDocumentoAnteriorIdModel = CteDocumentoAnteriorIdModel(); // Reset model
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "cte_documento_anterior_id";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		cteDocumentoAnteriorModelController.dispose();
		numeroController.dispose();
		chaveCteController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}