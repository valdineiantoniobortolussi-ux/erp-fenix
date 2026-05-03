import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/controller/controller_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/page/grid_columns/grid_columns_imports.dart';

import 'package:contabil/app/routes/app_routes.dart';
import 'package:contabil/app/data/repository/contabil_conta_rateio_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class ContabilContaRateioController extends GetxController with ControllerBaseMixin {
  final ContabilContaRateioRepository contabilContaRateioRepository;
  ContabilContaRateioController({required this.contabilContaRateioRepository});

  // general
  final _dbColumns = ContabilContaRateioModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ContabilContaRateioModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = contabilContaRateioGridColumns();
  
  var _contabilContaRateioModelList = <ContabilContaRateioModel>[];

  final _contabilContaRateioModel = ContabilContaRateioModel().obs;
  ContabilContaRateioModel get contabilContaRateioModel => _contabilContaRateioModel.value;
  set contabilContaRateioModel(value) => _contabilContaRateioModel.value = value ?? ContabilContaRateioModel();

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
    for (var contabilContaRateioModel in _contabilContaRateioModelList) {
      plutoRowList.add(_getPlutoRow(contabilContaRateioModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ContabilContaRateioModel contabilContaRateioModel) {
    return PlutoRow(
      cells: _getPlutoCells(contabilContaRateioModel: contabilContaRateioModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ ContabilContaRateioModel? contabilContaRateioModel}) {
    return {
			"id": PlutoCell(value: contabilContaRateioModel?.id ?? 0),
			"centroResultado": PlutoCell(value: contabilContaRateioModel?.centroResultadoModel?.descricao ?? ''),
			"contabilConta": PlutoCell(value: contabilContaRateioModel?.contabilContaModel?.descricao ?? ''),
			"porcentoRateio": PlutoCell(value: contabilContaRateioModel?.porcentoRateio ?? 0),
			"idCentroResultado": PlutoCell(value: contabilContaRateioModel?.idCentroResultado ?? 0),
			"idContabilConta": PlutoCell(value: contabilContaRateioModel?.idContabilConta ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _contabilContaRateioModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      contabilContaRateioModel.plutoRowToObject(plutoRow);
    } else {
      contabilContaRateioModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Rateio Conta Contábil]';
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
    await Get.find<ContabilContaRateioController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await contabilContaRateioRepository.getList(filter: filter).then( (data){ _contabilContaRateioModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Rateio Conta Contábil',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			centroResultadoModelController.text = currentRow.cells['centroResultado']?.value ?? '';
			contabilContaModelController.text = currentRow.cells['contabilConta']?.value ?? '';
			porcentoRateioController.text = currentRow.cells['porcentoRateio']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.contabilContaRateioEditPage)!.then((value) {
        if (contabilContaRateioModel.id == 0) {
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
    contabilContaRateioModel = ContabilContaRateioModel();
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
        if (await contabilContaRateioRepository.delete(id: currentRow.cells['id']!.value)) {
          _contabilContaRateioModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final centroResultadoModelController = TextEditingController();
	final contabilContaModelController = TextEditingController();
	final porcentoRateioController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contabilContaRateioModel.id;
		plutoRow.cells['idCentroResultado']?.value = contabilContaRateioModel.idCentroResultado;
		plutoRow.cells['centroResultado']?.value = contabilContaRateioModel.centroResultadoModel?.descricao;
		plutoRow.cells['idContabilConta']?.value = contabilContaRateioModel.idContabilConta;
		plutoRow.cells['contabilConta']?.value = contabilContaRateioModel.contabilContaModel?.descricao;
		plutoRow.cells['porcentoRateio']?.value = contabilContaRateioModel.porcentoRateio;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await contabilContaRateioRepository.save(contabilContaRateioModel: contabilContaRateioModel); 
        if (result != null) {
          contabilContaRateioModel = result;
          if (_isInserting) {
            _contabilContaRateioModelList.add(result);
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

	Future callCentroResultadoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Centro Resultado]'; 
		lookupController.route = '/centro-resultado/'; 
		lookupController.gridColumns = centroResultadoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CentroResultadoModel.aliasColumns; 
		lookupController.dbColumns = CentroResultadoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			contabilContaRateioModel.idCentroResultado = plutoRowResult.cells['id']!.value; 
			contabilContaRateioModel.centroResultadoModel!.plutoRowToObject(plutoRowResult); 
			centroResultadoModelController.text = contabilContaRateioModel.centroResultadoModel?.descricao ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callContabilContaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Conta Contábil]'; 
		lookupController.route = '/contabil-conta/'; 
		lookupController.gridColumns = contabilContaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ContabilContaModel.aliasColumns; 
		lookupController.dbColumns = ContabilContaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			contabilContaRateioModel.idContabilConta = plutoRowResult.cells['id']!.value; 
			contabilContaRateioModel.contabilContaModel!.plutoRowToObject(plutoRowResult); 
			contabilContaModelController.text = contabilContaRateioModel.contabilContaModel?.descricao ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "contabil_conta_rateio";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		centroResultadoModelController.dispose();
		contabilContaModelController.dispose();
		porcentoRateioController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}