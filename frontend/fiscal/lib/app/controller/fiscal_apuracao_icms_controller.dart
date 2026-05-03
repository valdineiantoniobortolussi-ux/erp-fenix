import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/controller/controller_imports.dart';
import 'package:fiscal/app/data/model/model_imports.dart';
import 'package:fiscal/app/page/grid_columns/grid_columns_imports.dart';

import 'package:fiscal/app/routes/app_routes.dart';
import 'package:fiscal/app/data/repository/fiscal_apuracao_icms_repository.dart';
import 'package:fiscal/app/page/shared_page/shared_page_imports.dart';
import 'package:fiscal/app/page/shared_widget/message_dialog.dart';
import 'package:fiscal/app/mixin/controller_base_mixin.dart';

class FiscalApuracaoIcmsController extends GetxController with ControllerBaseMixin {
  final FiscalApuracaoIcmsRepository fiscalApuracaoIcmsRepository;
  FiscalApuracaoIcmsController({required this.fiscalApuracaoIcmsRepository});

  // general
  final _dbColumns = FiscalApuracaoIcmsModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FiscalApuracaoIcmsModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = fiscalApuracaoIcmsGridColumns();
  
  var _fiscalApuracaoIcmsModelList = <FiscalApuracaoIcmsModel>[];

  final _fiscalApuracaoIcmsModel = FiscalApuracaoIcmsModel().obs;
  FiscalApuracaoIcmsModel get fiscalApuracaoIcmsModel => _fiscalApuracaoIcmsModel.value;
  set fiscalApuracaoIcmsModel(value) => _fiscalApuracaoIcmsModel.value = value ?? FiscalApuracaoIcmsModel();

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
    for (var fiscalApuracaoIcmsModel in _fiscalApuracaoIcmsModelList) {
      plutoRowList.add(_getPlutoRow(fiscalApuracaoIcmsModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FiscalApuracaoIcmsModel fiscalApuracaoIcmsModel) {
    return PlutoRow(
      cells: _getPlutoCells(fiscalApuracaoIcmsModel: fiscalApuracaoIcmsModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FiscalApuracaoIcmsModel? fiscalApuracaoIcmsModel}) {
    return {
			"id": PlutoCell(value: fiscalApuracaoIcmsModel?.id ?? 0),
			"competencia": PlutoCell(value: fiscalApuracaoIcmsModel?.competencia ?? ''),
			"valorTotalDebito": PlutoCell(value: fiscalApuracaoIcmsModel?.valorTotalDebito ?? 0),
			"valorAjusteDebito": PlutoCell(value: fiscalApuracaoIcmsModel?.valorAjusteDebito ?? 0),
			"valorTotalAjusteDebito": PlutoCell(value: fiscalApuracaoIcmsModel?.valorTotalAjusteDebito ?? 0),
			"valorEstornoCredito": PlutoCell(value: fiscalApuracaoIcmsModel?.valorEstornoCredito ?? 0),
			"valorTotalCredito": PlutoCell(value: fiscalApuracaoIcmsModel?.valorTotalCredito ?? 0),
			"valorAjusteCredito": PlutoCell(value: fiscalApuracaoIcmsModel?.valorAjusteCredito ?? 0),
			"valorTotalAjusteCredito": PlutoCell(value: fiscalApuracaoIcmsModel?.valorTotalAjusteCredito ?? 0),
			"valorEstornoDebito": PlutoCell(value: fiscalApuracaoIcmsModel?.valorEstornoDebito ?? 0),
			"valorSaldoCredorAnterior": PlutoCell(value: fiscalApuracaoIcmsModel?.valorSaldoCredorAnterior ?? 0),
			"valorSaldoApurado": PlutoCell(value: fiscalApuracaoIcmsModel?.valorSaldoApurado ?? 0),
			"valorTotalDeducao": PlutoCell(value: fiscalApuracaoIcmsModel?.valorTotalDeducao ?? 0),
			"valorIcmsRecolher": PlutoCell(value: fiscalApuracaoIcmsModel?.valorIcmsRecolher ?? 0),
			"valorSaldoCredorTransp": PlutoCell(value: fiscalApuracaoIcmsModel?.valorSaldoCredorTransp ?? 0),
			"valorDebitoEspecial": PlutoCell(value: fiscalApuracaoIcmsModel?.valorDebitoEspecial ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _fiscalApuracaoIcmsModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      fiscalApuracaoIcmsModel.plutoRowToObject(plutoRow);
    } else {
      fiscalApuracaoIcmsModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Apuração do ICMS]';
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
    await Get.find<FiscalApuracaoIcmsController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await fiscalApuracaoIcmsRepository.getList(filter: filter).then( (data){ _fiscalApuracaoIcmsModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Apuração do ICMS',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			competenciaController.text = currentRow.cells['competencia']?.value ?? '';
			valorTotalDebitoController.text = currentRow.cells['valorTotalDebito']?.value?.toStringAsFixed(2) ?? '';
			valorAjusteDebitoController.text = currentRow.cells['valorAjusteDebito']?.value?.toStringAsFixed(2) ?? '';
			valorTotalAjusteDebitoController.text = currentRow.cells['valorTotalAjusteDebito']?.value?.toStringAsFixed(2) ?? '';
			valorEstornoCreditoController.text = currentRow.cells['valorEstornoCredito']?.value?.toStringAsFixed(2) ?? '';
			valorTotalCreditoController.text = currentRow.cells['valorTotalCredito']?.value?.toStringAsFixed(2) ?? '';
			valorAjusteCreditoController.text = currentRow.cells['valorAjusteCredito']?.value?.toStringAsFixed(2) ?? '';
			valorTotalAjusteCreditoController.text = currentRow.cells['valorTotalAjusteCredito']?.value?.toStringAsFixed(2) ?? '';
			valorEstornoDebitoController.text = currentRow.cells['valorEstornoDebito']?.value?.toStringAsFixed(2) ?? '';
			valorSaldoCredorAnteriorController.text = currentRow.cells['valorSaldoCredorAnterior']?.value?.toStringAsFixed(2) ?? '';
			valorSaldoApuradoController.text = currentRow.cells['valorSaldoApurado']?.value?.toStringAsFixed(2) ?? '';
			valorTotalDeducaoController.text = currentRow.cells['valorTotalDeducao']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsRecolherController.text = currentRow.cells['valorIcmsRecolher']?.value?.toStringAsFixed(2) ?? '';
			valorSaldoCredorTranspController.text = currentRow.cells['valorSaldoCredorTransp']?.value?.toStringAsFixed(2) ?? '';
			valorDebitoEspecialController.text = currentRow.cells['valorDebitoEspecial']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.fiscalApuracaoIcmsEditPage)!.then((value) {
        if (fiscalApuracaoIcmsModel.id == 0) {
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
    fiscalApuracaoIcmsModel = FiscalApuracaoIcmsModel();
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
        if (await fiscalApuracaoIcmsRepository.delete(id: currentRow.cells['id']!.value)) {
          _fiscalApuracaoIcmsModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final competenciaController = MaskedTextController(mask: '00/0000',);
	final valorTotalDebitoController = MoneyMaskedTextController();
	final valorAjusteDebitoController = MoneyMaskedTextController();
	final valorTotalAjusteDebitoController = MoneyMaskedTextController();
	final valorEstornoCreditoController = MoneyMaskedTextController();
	final valorTotalCreditoController = MoneyMaskedTextController();
	final valorAjusteCreditoController = MoneyMaskedTextController();
	final valorTotalAjusteCreditoController = MoneyMaskedTextController();
	final valorEstornoDebitoController = MoneyMaskedTextController();
	final valorSaldoCredorAnteriorController = MoneyMaskedTextController();
	final valorSaldoApuradoController = MoneyMaskedTextController();
	final valorTotalDeducaoController = MoneyMaskedTextController();
	final valorIcmsRecolherController = MoneyMaskedTextController();
	final valorSaldoCredorTranspController = MoneyMaskedTextController();
	final valorDebitoEspecialController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = fiscalApuracaoIcmsModel.id;
		plutoRow.cells['competencia']?.value = fiscalApuracaoIcmsModel.competencia;
		plutoRow.cells['valorTotalDebito']?.value = fiscalApuracaoIcmsModel.valorTotalDebito;
		plutoRow.cells['valorAjusteDebito']?.value = fiscalApuracaoIcmsModel.valorAjusteDebito;
		plutoRow.cells['valorTotalAjusteDebito']?.value = fiscalApuracaoIcmsModel.valorTotalAjusteDebito;
		plutoRow.cells['valorEstornoCredito']?.value = fiscalApuracaoIcmsModel.valorEstornoCredito;
		plutoRow.cells['valorTotalCredito']?.value = fiscalApuracaoIcmsModel.valorTotalCredito;
		plutoRow.cells['valorAjusteCredito']?.value = fiscalApuracaoIcmsModel.valorAjusteCredito;
		plutoRow.cells['valorTotalAjusteCredito']?.value = fiscalApuracaoIcmsModel.valorTotalAjusteCredito;
		plutoRow.cells['valorEstornoDebito']?.value = fiscalApuracaoIcmsModel.valorEstornoDebito;
		plutoRow.cells['valorSaldoCredorAnterior']?.value = fiscalApuracaoIcmsModel.valorSaldoCredorAnterior;
		plutoRow.cells['valorSaldoApurado']?.value = fiscalApuracaoIcmsModel.valorSaldoApurado;
		plutoRow.cells['valorTotalDeducao']?.value = fiscalApuracaoIcmsModel.valorTotalDeducao;
		plutoRow.cells['valorIcmsRecolher']?.value = fiscalApuracaoIcmsModel.valorIcmsRecolher;
		plutoRow.cells['valorSaldoCredorTransp']?.value = fiscalApuracaoIcmsModel.valorSaldoCredorTransp;
		plutoRow.cells['valorDebitoEspecial']?.value = fiscalApuracaoIcmsModel.valorDebitoEspecial;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await fiscalApuracaoIcmsRepository.save(fiscalApuracaoIcmsModel: fiscalApuracaoIcmsModel); 
        if (result != null) {
          fiscalApuracaoIcmsModel = result;
          if (_isInserting) {
            _fiscalApuracaoIcmsModelList.add(result);
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
		functionName = "fiscal_apuracao_icms";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		competenciaController.dispose();
		valorTotalDebitoController.dispose();
		valorAjusteDebitoController.dispose();
		valorTotalAjusteDebitoController.dispose();
		valorEstornoCreditoController.dispose();
		valorTotalCreditoController.dispose();
		valorAjusteCreditoController.dispose();
		valorTotalAjusteCreditoController.dispose();
		valorEstornoDebitoController.dispose();
		valorSaldoCredorAnteriorController.dispose();
		valorSaldoApuradoController.dispose();
		valorTotalDeducaoController.dispose();
		valorIcmsRecolherController.dispose();
		valorSaldoCredorTranspController.dispose();
		valorDebitoEspecialController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}