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
import 'package:cte/app/data/repository/cte_rodoviario_lacre_repository.dart';
import 'package:cte/app/page/shared_page/shared_page_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';
import 'package:cte/app/mixin/controller_base_mixin.dart';

class CteRodoviarioLacreController extends GetxController with ControllerBaseMixin {
  final CteRodoviarioLacreRepository cteRodoviarioLacreRepository;
  CteRodoviarioLacreController({required this.cteRodoviarioLacreRepository});

  // general
  final _dbColumns = CteRodoviarioLacreModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = CteRodoviarioLacreModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = cteRodoviarioLacreGridColumns();
  
  var _cteRodoviarioLacreModelList = <CteRodoviarioLacreModel>[];

  final _cteRodoviarioLacreModel = CteRodoviarioLacreModel().obs;
  CteRodoviarioLacreModel get cteRodoviarioLacreModel => _cteRodoviarioLacreModel.value;
  set cteRodoviarioLacreModel(value) => _cteRodoviarioLacreModel.value = value ?? CteRodoviarioLacreModel();

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
    for (var cteRodoviarioLacreModel in _cteRodoviarioLacreModelList) {
      plutoRowList.add(_getPlutoRow(cteRodoviarioLacreModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(CteRodoviarioLacreModel cteRodoviarioLacreModel) {
    return PlutoRow(
      cells: _getPlutoCells(cteRodoviarioLacreModel: cteRodoviarioLacreModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ CteRodoviarioLacreModel? cteRodoviarioLacreModel}) {
    return {
			"id": PlutoCell(value: cteRodoviarioLacreModel?.id ?? 0),
			"cteRodoviario": PlutoCell(value: cteRodoviarioLacreModel?.cteRodoviarioModel?.rntrc ?? ''),
			"numero": PlutoCell(value: cteRodoviarioLacreModel?.numero ?? ''),
			"idCteRodoviario": PlutoCell(value: cteRodoviarioLacreModel?.idCteRodoviario ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _cteRodoviarioLacreModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      cteRodoviarioLacreModel.plutoRowToObject(plutoRow);
    } else {
      cteRodoviarioLacreModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Cte Rodoviario Lacre]';
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
    await Get.find<CteRodoviarioLacreController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await cteRodoviarioLacreRepository.getList(filter: filter).then( (data){ _cteRodoviarioLacreModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Cte Rodoviario Lacre',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			cteRodoviarioModelController.text = currentRow.cells['cteRodoviario']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.cteRodoviarioLacreEditPage)!.then((value) {
        if (cteRodoviarioLacreModel.id == 0) {
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
    cteRodoviarioLacreModel = CteRodoviarioLacreModel();
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
        if (await cteRodoviarioLacreRepository.delete(id: currentRow.cells['id']!.value)) {
          _cteRodoviarioLacreModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final cteRodoviarioModelController = TextEditingController();
	final numeroController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteRodoviarioLacreModel.id;
		plutoRow.cells['idCteRodoviario']?.value = cteRodoviarioLacreModel.idCteRodoviario;
		plutoRow.cells['cteRodoviario']?.value = cteRodoviarioLacreModel.cteRodoviarioModel?.rntrc;
		plutoRow.cells['numero']?.value = cteRodoviarioLacreModel.numero;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await cteRodoviarioLacreRepository.save(cteRodoviarioLacreModel: cteRodoviarioLacreModel); 
        if (result != null) {
          cteRodoviarioLacreModel = result;
          if (_isInserting) {
            _cteRodoviarioLacreModelList.add(result);
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

	Future callCteRodoviarioLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Cte Rodoviario]'; 
		lookupController.route = '/cte-rodoviario/'; 
		lookupController.gridColumns = cteRodoviarioGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CteRodoviarioModel.aliasColumns; 
		lookupController.dbColumns = CteRodoviarioModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			cteRodoviarioLacreModel.idCteRodoviario = plutoRowResult.cells['id']!.value; 
			cteRodoviarioLacreModel.cteRodoviarioModel!.plutoRowToObject(plutoRowResult); 
			cteRodoviarioModelController.text = cteRodoviarioLacreModel.cteRodoviarioModel?.rntrc ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "cte_rodoviario_lacre";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		cteRodoviarioModelController.dispose();
		numeroController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}