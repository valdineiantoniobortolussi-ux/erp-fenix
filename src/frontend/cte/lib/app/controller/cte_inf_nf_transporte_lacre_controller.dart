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
import 'package:cte/app/data/repository/cte_inf_nf_transporte_lacre_repository.dart';
import 'package:cte/app/page/shared_page/shared_page_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';
import 'package:cte/app/mixin/controller_base_mixin.dart';

class CteInfNfTransporteLacreController extends GetxController with ControllerBaseMixin {
  final CteInfNfTransporteLacreRepository cteInfNfTransporteLacreRepository;
  CteInfNfTransporteLacreController({required this.cteInfNfTransporteLacreRepository});

  // general
  final _dbColumns = CteInfNfTransporteLacreModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = CteInfNfTransporteLacreModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = cteInfNfTransporteLacreGridColumns();
  
  var _cteInfNfTransporteLacreModelList = <CteInfNfTransporteLacreModel>[];

  final _cteInfNfTransporteLacreModel = CteInfNfTransporteLacreModel().obs;
  CteInfNfTransporteLacreModel get cteInfNfTransporteLacreModel => _cteInfNfTransporteLacreModel.value;
  set cteInfNfTransporteLacreModel(value) => _cteInfNfTransporteLacreModel.value = value ?? CteInfNfTransporteLacreModel();

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
    for (var cteInfNfTransporteLacreModel in _cteInfNfTransporteLacreModelList) {
      plutoRowList.add(_getPlutoRow(cteInfNfTransporteLacreModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(CteInfNfTransporteLacreModel cteInfNfTransporteLacreModel) {
    return PlutoRow(
      cells: _getPlutoCells(cteInfNfTransporteLacreModel: cteInfNfTransporteLacreModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ CteInfNfTransporteLacreModel? cteInfNfTransporteLacreModel}) {
    return {
			"id": PlutoCell(value: cteInfNfTransporteLacreModel?.id ?? 0),
			"cteInformacaoNfTransporte": PlutoCell(value: cteInfNfTransporteLacreModel?.cteInformacaoNfTransporteModel?.tipoUnidadeTransporte ?? ''),
			"numero": PlutoCell(value: cteInfNfTransporteLacreModel?.numero ?? ''),
			"idCteInformacaoNfTransporte": PlutoCell(value: cteInfNfTransporteLacreModel?.idCteInformacaoNfTransporte ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _cteInfNfTransporteLacreModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      cteInfNfTransporteLacreModel.plutoRowToObject(plutoRow);
    } else {
      cteInfNfTransporteLacreModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Cte Inf Nf Transporte Lacre]';
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
    await Get.find<CteInfNfTransporteLacreController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await cteInfNfTransporteLacreRepository.getList(filter: filter).then( (data){ _cteInfNfTransporteLacreModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Cte Inf Nf Transporte Lacre',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			cteInformacaoNfTransporteModelController.text = currentRow.cells['cteInformacaoNfTransporte']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.cteInfNfTransporteLacreEditPage)!.then((value) {
        if (cteInfNfTransporteLacreModel.id == 0) {
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
    cteInfNfTransporteLacreModel = CteInfNfTransporteLacreModel();
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
        if (await cteInfNfTransporteLacreRepository.delete(id: currentRow.cells['id']!.value)) {
          _cteInfNfTransporteLacreModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final cteInformacaoNfTransporteModelController = TextEditingController();
	final numeroController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteInfNfTransporteLacreModel.id;
		plutoRow.cells['idCteInformacaoNfTransporte']?.value = cteInfNfTransporteLacreModel.idCteInformacaoNfTransporte;
		plutoRow.cells['cteInformacaoNfTransporte']?.value = cteInfNfTransporteLacreModel.cteInformacaoNfTransporteModel?.tipoUnidadeTransporte;
		plutoRow.cells['numero']?.value = cteInfNfTransporteLacreModel.numero;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await cteInfNfTransporteLacreRepository.save(cteInfNfTransporteLacreModel: cteInfNfTransporteLacreModel); 
        if (result != null) {
          cteInfNfTransporteLacreModel = result;
          if (_isInserting) {
            _cteInfNfTransporteLacreModelList.add(result);
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

	Future callCteInformacaoNfTransporteLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Cte Informacao Nf Transporte]'; 
		lookupController.route = '/cte-informacao-nf-transporte/'; 
		lookupController.gridColumns = cteInformacaoNfTransporteGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CteInformacaoNfTransporteModel.aliasColumns; 
		lookupController.dbColumns = CteInformacaoNfTransporteModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			cteInfNfTransporteLacreModel.idCteInformacaoNfTransporte = plutoRowResult.cells['id']!.value; 
			cteInfNfTransporteLacreModel.cteInformacaoNfTransporteModel!.plutoRowToObject(plutoRowResult); 
			cteInformacaoNfTransporteModelController.text = cteInfNfTransporteLacreModel.cteInformacaoNfTransporteModel?.tipoUnidadeTransporte ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "cte_inf_nf_transporte_lacre";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		cteInformacaoNfTransporteModelController.dispose();
		numeroController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}