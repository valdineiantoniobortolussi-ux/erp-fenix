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
import 'package:cte/app/data/repository/cte_informacao_nf_transporte_repository.dart';
import 'package:cte/app/page/shared_page/shared_page_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';
import 'package:cte/app/mixin/controller_base_mixin.dart';

class CteInformacaoNfTransporteController extends GetxController with ControllerBaseMixin {
  final CteInformacaoNfTransporteRepository cteInformacaoNfTransporteRepository;
  CteInformacaoNfTransporteController({required this.cteInformacaoNfTransporteRepository});

  // general
  final _dbColumns = CteInformacaoNfTransporteModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = CteInformacaoNfTransporteModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = cteInformacaoNfTransporteGridColumns();
  
  var _cteInformacaoNfTransporteModelList = <CteInformacaoNfTransporteModel>[];

  final _cteInformacaoNfTransporteModel = CteInformacaoNfTransporteModel().obs;
  CteInformacaoNfTransporteModel get cteInformacaoNfTransporteModel => _cteInformacaoNfTransporteModel.value;
  set cteInformacaoNfTransporteModel(value) => _cteInformacaoNfTransporteModel.value = value ?? CteInformacaoNfTransporteModel();

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
    for (var cteInformacaoNfTransporteModel in _cteInformacaoNfTransporteModelList) {
      plutoRowList.add(_getPlutoRow(cteInformacaoNfTransporteModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(CteInformacaoNfTransporteModel cteInformacaoNfTransporteModel) {
    return PlutoRow(
      cells: _getPlutoCells(cteInformacaoNfTransporteModel: cteInformacaoNfTransporteModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ CteInformacaoNfTransporteModel? cteInformacaoNfTransporteModel}) {
    return {
			"id": PlutoCell(value: cteInformacaoNfTransporteModel?.id ?? 0),
			"cteInformacaoNfOutros": PlutoCell(value: cteInformacaoNfTransporteModel?.cteInformacaoNfOutrosModel?.numero ?? ''),
			"tipoUnidadeTransporte": PlutoCell(value: cteInformacaoNfTransporteModel?.tipoUnidadeTransporte ?? ''),
			"idUnidadeTransporte": PlutoCell(value: cteInformacaoNfTransporteModel?.idUnidadeTransporte ?? ''),
			"idCteInformacaoNf": PlutoCell(value: cteInformacaoNfTransporteModel?.idCteInformacaoNf ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _cteInformacaoNfTransporteModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      cteInformacaoNfTransporteModel.plutoRowToObject(plutoRow);
    } else {
      cteInformacaoNfTransporteModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Cte Informacao Nf Transporte]';
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
    await Get.find<CteInformacaoNfTransporteController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await cteInformacaoNfTransporteRepository.getList(filter: filter).then( (data){ _cteInformacaoNfTransporteModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Cte Informacao Nf Transporte',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			cteInformacaoNfOutrosModelController.text = currentRow.cells['cteInformacaoNfOutros']?.value ?? '';
			idUnidadeTransporteController.text = currentRow.cells['idUnidadeTransporte']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.cteInformacaoNfTransporteEditPage)!.then((value) {
        if (cteInformacaoNfTransporteModel.id == 0) {
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
    cteInformacaoNfTransporteModel = CteInformacaoNfTransporteModel();
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
        if (await cteInformacaoNfTransporteRepository.delete(id: currentRow.cells['id']!.value)) {
          _cteInformacaoNfTransporteModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final cteInformacaoNfOutrosModelController = TextEditingController();
	final idUnidadeTransporteController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteInformacaoNfTransporteModel.id;
		plutoRow.cells['idCteInformacaoNf']?.value = cteInformacaoNfTransporteModel.idCteInformacaoNf;
		plutoRow.cells['cteInformacaoNfOutros']?.value = cteInformacaoNfTransporteModel.cteInformacaoNfOutrosModel?.numero;
		plutoRow.cells['tipoUnidadeTransporte']?.value = cteInformacaoNfTransporteModel.tipoUnidadeTransporte;
		plutoRow.cells['idUnidadeTransporte']?.value = cteInformacaoNfTransporteModel.idUnidadeTransporte;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await cteInformacaoNfTransporteRepository.save(cteInformacaoNfTransporteModel: cteInformacaoNfTransporteModel); 
        if (result != null) {
          cteInformacaoNfTransporteModel = result;
          if (_isInserting) {
            _cteInformacaoNfTransporteModelList.add(result);
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

	Future callCteInformacaoNfOutrosLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Cte Informacao Nf]'; 
		lookupController.route = '/cte-informacao-nf-outros/'; 
		lookupController.gridColumns = cteInformacaoNfOutrosGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CteInformacaoNfOutrosModel.aliasColumns; 
		lookupController.dbColumns = CteInformacaoNfOutrosModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			cteInformacaoNfTransporteModel.idCteInformacaoNf = plutoRowResult.cells['id']!.value; 
			cteInformacaoNfTransporteModel.cteInformacaoNfOutrosModel!.plutoRowToObject(plutoRowResult); 
			cteInformacaoNfOutrosModelController.text = cteInformacaoNfTransporteModel.cteInformacaoNfOutrosModel?.numero ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "cte_informacao_nf_transporte";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		cteInformacaoNfOutrosModelController.dispose();
		idUnidadeTransporteController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}