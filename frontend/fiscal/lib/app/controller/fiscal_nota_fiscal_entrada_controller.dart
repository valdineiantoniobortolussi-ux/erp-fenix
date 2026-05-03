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
import 'package:fiscal/app/data/repository/fiscal_nota_fiscal_entrada_repository.dart';
import 'package:fiscal/app/page/shared_page/shared_page_imports.dart';
import 'package:fiscal/app/page/shared_widget/message_dialog.dart';
import 'package:fiscal/app/mixin/controller_base_mixin.dart';

class FiscalNotaFiscalEntradaController extends GetxController with ControllerBaseMixin {
  final FiscalNotaFiscalEntradaRepository fiscalNotaFiscalEntradaRepository;
  FiscalNotaFiscalEntradaController({required this.fiscalNotaFiscalEntradaRepository});

  // general
  final _dbColumns = FiscalNotaFiscalEntradaModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FiscalNotaFiscalEntradaModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = fiscalNotaFiscalEntradaGridColumns();
  
  var _fiscalNotaFiscalEntradaModelList = <FiscalNotaFiscalEntradaModel>[];

  final _fiscalNotaFiscalEntradaModel = FiscalNotaFiscalEntradaModel().obs;
  FiscalNotaFiscalEntradaModel get fiscalNotaFiscalEntradaModel => _fiscalNotaFiscalEntradaModel.value;
  set fiscalNotaFiscalEntradaModel(value) => _fiscalNotaFiscalEntradaModel.value = value ?? FiscalNotaFiscalEntradaModel();

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
    for (var fiscalNotaFiscalEntradaModel in _fiscalNotaFiscalEntradaModelList) {
      plutoRowList.add(_getPlutoRow(fiscalNotaFiscalEntradaModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FiscalNotaFiscalEntradaModel fiscalNotaFiscalEntradaModel) {
    return PlutoRow(
      cells: _getPlutoCells(fiscalNotaFiscalEntradaModel: fiscalNotaFiscalEntradaModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FiscalNotaFiscalEntradaModel? fiscalNotaFiscalEntradaModel}) {
    return {
			"id": PlutoCell(value: fiscalNotaFiscalEntradaModel?.id ?? 0),
			"nfeCabecalho": PlutoCell(value: fiscalNotaFiscalEntradaModel?.nfeCabecalhoModel?.chave_acesso ?? ''),
			"competencia": PlutoCell(value: fiscalNotaFiscalEntradaModel?.competencia ?? ''),
			"cfopEntrada": PlutoCell(value: fiscalNotaFiscalEntradaModel?.cfopEntrada ?? 0),
			"valorRateioFrete": PlutoCell(value: fiscalNotaFiscalEntradaModel?.valorRateioFrete ?? 0),
			"valorCustoMedio": PlutoCell(value: fiscalNotaFiscalEntradaModel?.valorCustoMedio ?? 0),
			"valorIcmsAntecipado": PlutoCell(value: fiscalNotaFiscalEntradaModel?.valorIcmsAntecipado ?? 0),
			"valorBcIcmsAntecipado": PlutoCell(value: fiscalNotaFiscalEntradaModel?.valorBcIcmsAntecipado ?? 0),
			"valorBcIcmsCreditado": PlutoCell(value: fiscalNotaFiscalEntradaModel?.valorBcIcmsCreditado ?? 0),
			"valorBcPisCreditado": PlutoCell(value: fiscalNotaFiscalEntradaModel?.valorBcPisCreditado ?? 0),
			"valorBcCofinsCreditado": PlutoCell(value: fiscalNotaFiscalEntradaModel?.valorBcCofinsCreditado ?? 0),
			"valorBcIpiCreditado": PlutoCell(value: fiscalNotaFiscalEntradaModel?.valorBcIpiCreditado ?? 0),
			"cstCreditoIcms": PlutoCell(value: fiscalNotaFiscalEntradaModel?.cstCreditoIcms ?? ''),
			"cstCreditoPis": PlutoCell(value: fiscalNotaFiscalEntradaModel?.cstCreditoPis ?? ''),
			"cstCreditoCofins": PlutoCell(value: fiscalNotaFiscalEntradaModel?.cstCreditoCofins ?? ''),
			"cstCreditoIpi": PlutoCell(value: fiscalNotaFiscalEntradaModel?.cstCreditoIpi ?? ''),
			"valorIcmsCreditado": PlutoCell(value: fiscalNotaFiscalEntradaModel?.valorIcmsCreditado ?? 0),
			"valorPisCreditado": PlutoCell(value: fiscalNotaFiscalEntradaModel?.valorPisCreditado ?? 0),
			"valorCofinsCreditado": PlutoCell(value: fiscalNotaFiscalEntradaModel?.valorCofinsCreditado ?? 0),
			"valorIpiCreditado": PlutoCell(value: fiscalNotaFiscalEntradaModel?.valorIpiCreditado ?? 0),
			"qtdeParcelaCreditoPis": PlutoCell(value: fiscalNotaFiscalEntradaModel?.qtdeParcelaCreditoPis ?? 0),
			"qtdeParcelaCreditoCofins": PlutoCell(value: fiscalNotaFiscalEntradaModel?.qtdeParcelaCreditoCofins ?? 0),
			"qtdeParcelaCreditoIcms": PlutoCell(value: fiscalNotaFiscalEntradaModel?.qtdeParcelaCreditoIcms ?? 0),
			"qtdeParcelaCreditoIpi": PlutoCell(value: fiscalNotaFiscalEntradaModel?.qtdeParcelaCreditoIpi ?? 0),
			"aliquotaCreditoIcms": PlutoCell(value: fiscalNotaFiscalEntradaModel?.aliquotaCreditoIcms ?? 0),
			"aliquotaCreditoPis": PlutoCell(value: fiscalNotaFiscalEntradaModel?.aliquotaCreditoPis ?? 0),
			"aliquotaCreditoCofins": PlutoCell(value: fiscalNotaFiscalEntradaModel?.aliquotaCreditoCofins ?? 0),
			"aliquotaCreditoIpi": PlutoCell(value: fiscalNotaFiscalEntradaModel?.aliquotaCreditoIpi ?? 0),
			"idNfeCabecalho": PlutoCell(value: fiscalNotaFiscalEntradaModel?.idNfeCabecalho ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _fiscalNotaFiscalEntradaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      fiscalNotaFiscalEntradaModel.plutoRowToObject(plutoRow);
    } else {
      fiscalNotaFiscalEntradaModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Registro de Entradas]';
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
    await Get.find<FiscalNotaFiscalEntradaController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await fiscalNotaFiscalEntradaRepository.getList(filter: filter).then( (data){ _fiscalNotaFiscalEntradaModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Registro de Entradas',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nfeCabecalhoModelController.text = currentRow.cells['nfeCabecalho']?.value ?? '';
			competenciaController.text = currentRow.cells['competencia']?.value ?? '';
			cfopEntradaController.text = currentRow.cells['cfopEntrada']?.value?.toString() ?? '';
			valorRateioFreteController.text = currentRow.cells['valorRateioFrete']?.value?.toStringAsFixed(2) ?? '';
			valorCustoMedioController.text = currentRow.cells['valorCustoMedio']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsAntecipadoController.text = currentRow.cells['valorIcmsAntecipado']?.value?.toStringAsFixed(2) ?? '';
			valorBcIcmsAntecipadoController.text = currentRow.cells['valorBcIcmsAntecipado']?.value?.toStringAsFixed(2) ?? '';
			valorBcIcmsCreditadoController.text = currentRow.cells['valorBcIcmsCreditado']?.value?.toStringAsFixed(2) ?? '';
			valorBcPisCreditadoController.text = currentRow.cells['valorBcPisCreditado']?.value?.toStringAsFixed(2) ?? '';
			valorBcCofinsCreditadoController.text = currentRow.cells['valorBcCofinsCreditado']?.value?.toStringAsFixed(2) ?? '';
			valorBcIpiCreditadoController.text = currentRow.cells['valorBcIpiCreditado']?.value?.toStringAsFixed(2) ?? '';
			cstCreditoIcmsController.text = currentRow.cells['cstCreditoIcms']?.value ?? '';
			cstCreditoPisController.text = currentRow.cells['cstCreditoPis']?.value ?? '';
			cstCreditoCofinsController.text = currentRow.cells['cstCreditoCofins']?.value ?? '';
			cstCreditoIpiController.text = currentRow.cells['cstCreditoIpi']?.value ?? '';
			valorIcmsCreditadoController.text = currentRow.cells['valorIcmsCreditado']?.value?.toStringAsFixed(2) ?? '';
			valorPisCreditadoController.text = currentRow.cells['valorPisCreditado']?.value?.toStringAsFixed(2) ?? '';
			valorCofinsCreditadoController.text = currentRow.cells['valorCofinsCreditado']?.value?.toStringAsFixed(2) ?? '';
			valorIpiCreditadoController.text = currentRow.cells['valorIpiCreditado']?.value?.toStringAsFixed(2) ?? '';
			qtdeParcelaCreditoPisController.text = currentRow.cells['qtdeParcelaCreditoPis']?.value?.toString() ?? '';
			qtdeParcelaCreditoCofinsController.text = currentRow.cells['qtdeParcelaCreditoCofins']?.value?.toString() ?? '';
			qtdeParcelaCreditoIcmsController.text = currentRow.cells['qtdeParcelaCreditoIcms']?.value?.toString() ?? '';
			qtdeParcelaCreditoIpiController.text = currentRow.cells['qtdeParcelaCreditoIpi']?.value?.toString() ?? '';
			aliquotaCreditoIcmsController.text = currentRow.cells['aliquotaCreditoIcms']?.value?.toStringAsFixed(2) ?? '';
			aliquotaCreditoPisController.text = currentRow.cells['aliquotaCreditoPis']?.value?.toStringAsFixed(2) ?? '';
			aliquotaCreditoCofinsController.text = currentRow.cells['aliquotaCreditoCofins']?.value?.toStringAsFixed(2) ?? '';
			aliquotaCreditoIpiController.text = currentRow.cells['aliquotaCreditoIpi']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.fiscalNotaFiscalEntradaEditPage)!.then((value) {
        if (fiscalNotaFiscalEntradaModel.id == 0) {
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
    fiscalNotaFiscalEntradaModel = FiscalNotaFiscalEntradaModel();
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
        if (await fiscalNotaFiscalEntradaRepository.delete(id: currentRow.cells['id']!.value)) {
          _fiscalNotaFiscalEntradaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nfeCabecalhoModelController = TextEditingController();
	final competenciaController = MaskedTextController(mask: '00/0000',);
	final cfopEntradaController = TextEditingController();
	final valorRateioFreteController = MoneyMaskedTextController();
	final valorCustoMedioController = MoneyMaskedTextController();
	final valorIcmsAntecipadoController = MoneyMaskedTextController();
	final valorBcIcmsAntecipadoController = MoneyMaskedTextController();
	final valorBcIcmsCreditadoController = MoneyMaskedTextController();
	final valorBcPisCreditadoController = MoneyMaskedTextController();
	final valorBcCofinsCreditadoController = MoneyMaskedTextController();
	final valorBcIpiCreditadoController = MoneyMaskedTextController();
	final cstCreditoIcmsController = TextEditingController();
	final cstCreditoPisController = TextEditingController();
	final cstCreditoCofinsController = TextEditingController();
	final cstCreditoIpiController = TextEditingController();
	final valorIcmsCreditadoController = MoneyMaskedTextController();
	final valorPisCreditadoController = MoneyMaskedTextController();
	final valorCofinsCreditadoController = MoneyMaskedTextController();
	final valorIpiCreditadoController = MoneyMaskedTextController();
	final qtdeParcelaCreditoPisController = TextEditingController();
	final qtdeParcelaCreditoCofinsController = TextEditingController();
	final qtdeParcelaCreditoIcmsController = TextEditingController();
	final qtdeParcelaCreditoIpiController = TextEditingController();
	final aliquotaCreditoIcmsController = MoneyMaskedTextController();
	final aliquotaCreditoPisController = MoneyMaskedTextController();
	final aliquotaCreditoCofinsController = MoneyMaskedTextController();
	final aliquotaCreditoIpiController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = fiscalNotaFiscalEntradaModel.id;
		plutoRow.cells['idNfeCabecalho']?.value = fiscalNotaFiscalEntradaModel.idNfeCabecalho;
		plutoRow.cells['nfeCabecalho']?.value = fiscalNotaFiscalEntradaModel.nfeCabecalhoModel?.chave_acesso;
		plutoRow.cells['competencia']?.value = fiscalNotaFiscalEntradaModel.competencia;
		plutoRow.cells['cfopEntrada']?.value = fiscalNotaFiscalEntradaModel.cfopEntrada;
		plutoRow.cells['valorRateioFrete']?.value = fiscalNotaFiscalEntradaModel.valorRateioFrete;
		plutoRow.cells['valorCustoMedio']?.value = fiscalNotaFiscalEntradaModel.valorCustoMedio;
		plutoRow.cells['valorIcmsAntecipado']?.value = fiscalNotaFiscalEntradaModel.valorIcmsAntecipado;
		plutoRow.cells['valorBcIcmsAntecipado']?.value = fiscalNotaFiscalEntradaModel.valorBcIcmsAntecipado;
		plutoRow.cells['valorBcIcmsCreditado']?.value = fiscalNotaFiscalEntradaModel.valorBcIcmsCreditado;
		plutoRow.cells['valorBcPisCreditado']?.value = fiscalNotaFiscalEntradaModel.valorBcPisCreditado;
		plutoRow.cells['valorBcCofinsCreditado']?.value = fiscalNotaFiscalEntradaModel.valorBcCofinsCreditado;
		plutoRow.cells['valorBcIpiCreditado']?.value = fiscalNotaFiscalEntradaModel.valorBcIpiCreditado;
		plutoRow.cells['cstCreditoIcms']?.value = fiscalNotaFiscalEntradaModel.cstCreditoIcms;
		plutoRow.cells['cstCreditoPis']?.value = fiscalNotaFiscalEntradaModel.cstCreditoPis;
		plutoRow.cells['cstCreditoCofins']?.value = fiscalNotaFiscalEntradaModel.cstCreditoCofins;
		plutoRow.cells['cstCreditoIpi']?.value = fiscalNotaFiscalEntradaModel.cstCreditoIpi;
		plutoRow.cells['valorIcmsCreditado']?.value = fiscalNotaFiscalEntradaModel.valorIcmsCreditado;
		plutoRow.cells['valorPisCreditado']?.value = fiscalNotaFiscalEntradaModel.valorPisCreditado;
		plutoRow.cells['valorCofinsCreditado']?.value = fiscalNotaFiscalEntradaModel.valorCofinsCreditado;
		plutoRow.cells['valorIpiCreditado']?.value = fiscalNotaFiscalEntradaModel.valorIpiCreditado;
		plutoRow.cells['qtdeParcelaCreditoPis']?.value = fiscalNotaFiscalEntradaModel.qtdeParcelaCreditoPis;
		plutoRow.cells['qtdeParcelaCreditoCofins']?.value = fiscalNotaFiscalEntradaModel.qtdeParcelaCreditoCofins;
		plutoRow.cells['qtdeParcelaCreditoIcms']?.value = fiscalNotaFiscalEntradaModel.qtdeParcelaCreditoIcms;
		plutoRow.cells['qtdeParcelaCreditoIpi']?.value = fiscalNotaFiscalEntradaModel.qtdeParcelaCreditoIpi;
		plutoRow.cells['aliquotaCreditoIcms']?.value = fiscalNotaFiscalEntradaModel.aliquotaCreditoIcms;
		plutoRow.cells['aliquotaCreditoPis']?.value = fiscalNotaFiscalEntradaModel.aliquotaCreditoPis;
		plutoRow.cells['aliquotaCreditoCofins']?.value = fiscalNotaFiscalEntradaModel.aliquotaCreditoCofins;
		plutoRow.cells['aliquotaCreditoIpi']?.value = fiscalNotaFiscalEntradaModel.aliquotaCreditoIpi;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await fiscalNotaFiscalEntradaRepository.save(fiscalNotaFiscalEntradaModel: fiscalNotaFiscalEntradaModel); 
        if (result != null) {
          fiscalNotaFiscalEntradaModel = result;
          if (_isInserting) {
            _fiscalNotaFiscalEntradaModelList.add(result);
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

	Future callNfeCabecalhoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [NFe Cabecalho]'; 
		lookupController.route = '/nfe-cabecalho/'; 
		lookupController.gridColumns = nfeCabecalhoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = NfeCabecalhoModel.aliasColumns; 
		lookupController.dbColumns = NfeCabecalhoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			fiscalNotaFiscalEntradaModel.idNfeCabecalho = plutoRowResult.cells['id']!.value; 
			fiscalNotaFiscalEntradaModel.nfeCabecalhoModel!.plutoRowToObject(plutoRowResult); 
			nfeCabecalhoModelController.text = fiscalNotaFiscalEntradaModel.nfeCabecalhoModel?.chave_acesso ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "fiscal_nota_fiscal_entrada";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nfeCabecalhoModelController.dispose();
		competenciaController.dispose();
		cfopEntradaController.dispose();
		valorRateioFreteController.dispose();
		valorCustoMedioController.dispose();
		valorIcmsAntecipadoController.dispose();
		valorBcIcmsAntecipadoController.dispose();
		valorBcIcmsCreditadoController.dispose();
		valorBcPisCreditadoController.dispose();
		valorBcCofinsCreditadoController.dispose();
		valorBcIpiCreditadoController.dispose();
		cstCreditoIcmsController.dispose();
		cstCreditoPisController.dispose();
		cstCreditoCofinsController.dispose();
		cstCreditoIpiController.dispose();
		valorIcmsCreditadoController.dispose();
		valorPisCreditadoController.dispose();
		valorCofinsCreditadoController.dispose();
		valorIpiCreditadoController.dispose();
		qtdeParcelaCreditoPisController.dispose();
		qtdeParcelaCreditoCofinsController.dispose();
		qtdeParcelaCreditoIcmsController.dispose();
		qtdeParcelaCreditoIpiController.dispose();
		aliquotaCreditoIcmsController.dispose();
		aliquotaCreditoPisController.dispose();
		aliquotaCreditoCofinsController.dispose();
		aliquotaCreditoIpiController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}