import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/controller/controller_imports.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/page/grid_columns/grid_columns_imports.dart';
import 'package:financeiro/app/page/page_imports.dart';

import 'package:financeiro/app/routes/app_routes.dart';
import 'package:financeiro/app/data/repository/fin_lancamento_receber_repository.dart';
import 'package:financeiro/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro/app/page/shared_widget/message_dialog.dart';
import 'package:financeiro/app/mixin/controller_base_mixin.dart';

class FinLancamentoReceberController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final FinLancamentoReceberRepository finLancamentoReceberRepository;
	FinLancamentoReceberController({required this.finLancamentoReceberRepository});

	// general
	final _dbColumns = FinLancamentoReceberModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = FinLancamentoReceberModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = finLancamentoReceberGridColumns();
	
	var _finLancamentoReceberModelList = <FinLancamentoReceberModel>[];

	var _finLancamentoReceberModelOld = FinLancamentoReceberModel();

	final _finLancamentoReceberModel = FinLancamentoReceberModel().obs;
	FinLancamentoReceberModel get finLancamentoReceberModel => _finLancamentoReceberModel.value;
	set finLancamentoReceberModel(value) => _finLancamentoReceberModel.value = value ?? FinLancamentoReceberModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Lançamento a Receber', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Parcelas', 
		),
	];

	List<Widget> tabPages() {
		return [
			FinLancamentoReceberEditPage(),
			const FinParcelaReceberListPage(),
		];
	}

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
		for (var finLancamentoReceberModel in _finLancamentoReceberModelList) {
			plutoRowList.add(_getPlutoRow(finLancamentoReceberModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FinLancamentoReceberModel finLancamentoReceberModel) {
		return PlutoRow(
			cells: _getPlutoCells(finLancamentoReceberModel: finLancamentoReceberModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FinLancamentoReceberModel? finLancamentoReceberModel}) {
		return {
			"id": PlutoCell(value: finLancamentoReceberModel?.id ?? 0),
			"viewPessoaCliente": PlutoCell(value: finLancamentoReceberModel?.viewPessoaClienteModel?.nome ?? ''),
			"bancoContaCaixa": PlutoCell(value: finLancamentoReceberModel?.bancoContaCaixaModel?.nome ?? ''),
			"finDocumentoOrigem": PlutoCell(value: finLancamentoReceberModel?.finDocumentoOrigemModel?.sigla ?? ''),
			"finNaturezaFinanceira": PlutoCell(value: finLancamentoReceberModel?.finNaturezaFinanceiraModel?.descricao ?? ''),
			"quantidadeParcela": PlutoCell(value: finLancamentoReceberModel?.quantidadeParcela ?? 0),
			"valorAReceber": PlutoCell(value: finLancamentoReceberModel?.valorAReceber ?? 0),
			"dataLancamento": PlutoCell(value: finLancamentoReceberModel?.dataLancamento ?? ''),
			"numeroDocumento": PlutoCell(value: finLancamentoReceberModel?.numeroDocumento ?? ''),
			"primeiroVencimento": PlutoCell(value: finLancamentoReceberModel?.primeiroVencimento ?? ''),
			"taxaComissao": PlutoCell(value: finLancamentoReceberModel?.taxaComissao ?? 0),
			"valorComissao": PlutoCell(value: finLancamentoReceberModel?.valorComissao ?? 0),
			"intervaloEntreParcelas": PlutoCell(value: finLancamentoReceberModel?.intervaloEntreParcelas ?? 0),
			"diaFixo": PlutoCell(value: finLancamentoReceberModel?.diaFixo ?? ''),
			"idCliente": PlutoCell(value: finLancamentoReceberModel?.idCliente ?? 0),
			"idBancoContaCaixa": PlutoCell(value: finLancamentoReceberModel?.idBancoContaCaixa ?? 0),
			"idFinDocumentoOrigem": PlutoCell(value: finLancamentoReceberModel?.idFinDocumentoOrigem ?? 0),
			"idFinNaturezaFinanceira": PlutoCell(value: finLancamentoReceberModel?.idFinNaturezaFinanceira ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _finLancamentoReceberModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			finLancamentoReceberModel.plutoRowToObject(plutoRow);
		} else {
			finLancamentoReceberModel = modelFromRow[0];
			_finLancamentoReceberModelOld = finLancamentoReceberModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Lançamento a Receber]';
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
		await Get.find<FinLancamentoReceberController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await finLancamentoReceberRepository.getList(filter: filter).then( (data){ _finLancamentoReceberModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Lançamento a Receber',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			viewPessoaClienteModelController.text = currentRow.cells['viewPessoaCliente']?.value ?? '';
			bancoContaCaixaModelController.text = currentRow.cells['bancoContaCaixa']?.value ?? '';
			finDocumentoOrigemModelController.text = currentRow.cells['finDocumentoOrigem']?.value ?? '';
			finNaturezaFinanceiraModelController.text = currentRow.cells['finNaturezaFinanceira']?.value ?? '';
			quantidadeParcelaController.text = currentRow.cells['quantidadeParcela']?.value?.toString() ?? '';
			valorAReceberController.text = currentRow.cells['valorAReceber']?.value?.toStringAsFixed(2) ?? '';
			numeroDocumentoController.text = currentRow.cells['numeroDocumento']?.value ?? '';
			taxaComissaoController.text = currentRow.cells['taxaComissao']?.value?.toStringAsFixed(2) ?? '';
			valorComissaoController.text = currentRow.cells['valorComissao']?.value?.toStringAsFixed(2) ?? '';
			intervaloEntreParcelasController.text = currentRow.cells['intervaloEntreParcelas']?.value?.toString() ?? '';
			diaFixoController.text = currentRow.cells['diaFixo']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Parcelas
			Get.put<FinParcelaReceberController>(FinParcelaReceberController()); 
			final finParcelaReceberController = Get.find<FinParcelaReceberController>(); 
			finParcelaReceberController.finParcelaReceberModelList = finLancamentoReceberModel.finParcelaReceberModelList!; 
			finParcelaReceberController.userMadeChanges = false; 


			Get.toNamed(Routes.finLancamentoReceberTabPage)!.then((value) {
				if (finLancamentoReceberModel.id == 0) {
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
		finLancamentoReceberModel = FinLancamentoReceberModel();
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
				if (await finLancamentoReceberRepository.delete(id: currentRow.cells['id']!.value)) {
					_finLancamentoReceberModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	String? mandatoryMessage;
	
	final scrollController = ScrollController();
	final viewPessoaClienteModelController = TextEditingController();
	final bancoContaCaixaModelController = TextEditingController();
	final finDocumentoOrigemModelController = TextEditingController();
	final finNaturezaFinanceiraModelController = TextEditingController();
	final quantidadeParcelaController = TextEditingController();
	final valorAReceberController = MoneyMaskedTextController();
	final numeroDocumentoController = TextEditingController();
	final taxaComissaoController = MoneyMaskedTextController();
	final valorComissaoController = MoneyMaskedTextController();
	final intervaloEntreParcelasController = TextEditingController();
	final diaFixoController = TextEditingController();

	final finLancamentoReceberTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final finLancamentoReceberEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final finLancamentoReceberEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = finLancamentoReceberModel.id;
		plutoRow.cells['idCliente']?.value = finLancamentoReceberModel.idCliente;
		plutoRow.cells['viewPessoaCliente']?.value = finLancamentoReceberModel.viewPessoaClienteModel?.nome;
		plutoRow.cells['idBancoContaCaixa']?.value = finLancamentoReceberModel.idBancoContaCaixa;
		plutoRow.cells['bancoContaCaixa']?.value = finLancamentoReceberModel.bancoContaCaixaModel?.nome;
		plutoRow.cells['idFinDocumentoOrigem']?.value = finLancamentoReceberModel.idFinDocumentoOrigem;
		plutoRow.cells['finDocumentoOrigem']?.value = finLancamentoReceberModel.finDocumentoOrigemModel?.sigla;
		plutoRow.cells['idFinNaturezaFinanceira']?.value = finLancamentoReceberModel.idFinNaturezaFinanceira;
		plutoRow.cells['finNaturezaFinanceira']?.value = finLancamentoReceberModel.finNaturezaFinanceiraModel?.descricao;
		plutoRow.cells['quantidadeParcela']?.value = finLancamentoReceberModel.quantidadeParcela;
		plutoRow.cells['valorAReceber']?.value = finLancamentoReceberModel.valorAReceber;
		plutoRow.cells['dataLancamento']?.value = Util.formatDate(finLancamentoReceberModel.dataLancamento);
		plutoRow.cells['numeroDocumento']?.value = finLancamentoReceberModel.numeroDocumento;
		plutoRow.cells['primeiroVencimento']?.value = Util.formatDate(finLancamentoReceberModel.primeiroVencimento);
		plutoRow.cells['taxaComissao']?.value = finLancamentoReceberModel.taxaComissao;
		plutoRow.cells['valorComissao']?.value = finLancamentoReceberModel.valorComissao;
		plutoRow.cells['intervaloEntreParcelas']?.value = finLancamentoReceberModel.intervaloEntreParcelas;
		plutoRow.cells['diaFixo']?.value = finLancamentoReceberModel.diaFixo;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await finLancamentoReceberRepository.save(finLancamentoReceberModel: finLancamentoReceberModel); 
				if (result != null) {
					finLancamentoReceberModel = result;
					if (_isInserting) {
						_finLancamentoReceberModelList.add(finLancamentoReceberModel);
						_isInserting = false;
					} else {
            _finLancamentoReceberModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _finLancamentoReceberModelList.add(finLancamentoReceberModel);
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
		if (userMadeChanges()) {
			showQuestionDialog('message_data_loss'.tr, () { 
				clearUserChanges();
				Get.back(); 
			});
		} else {
			clearUserChanges();
			Get.back();
		}
	}	

	bool userMadeChanges() {
		return
		formWasChanged 
		|| 
		Get.find<FinParcelaReceberController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_finLancamentoReceberModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_finLancamentoReceberModelList.add(_finLancamentoReceberModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(finLancamentoReceberModel.viewPessoaClienteModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Cliente]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(finLancamentoReceberModel.bancoContaCaixaModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Conta/Caixa]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(finLancamentoReceberModel.finDocumentoOrigemModel?.sigla); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Documento Origem]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(finLancamentoReceberModel.finNaturezaFinanceiraModel?.descricao); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Natureza Financeira]'); 
			return false; 
		}
		return true;
	}

	Future callViewPessoaClienteLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Cliente]'; 
		lookupController.route = '/view-pessoa-cliente/'; 
		lookupController.gridColumns = viewPessoaClienteGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaClienteModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaClienteModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			finLancamentoReceberModel.idCliente = plutoRowResult.cells['id']!.value; 
			finLancamentoReceberModel.viewPessoaClienteModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaClienteModelController.text = finLancamentoReceberModel.viewPessoaClienteModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callBancoContaCaixaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Conta/Caixa]'; 
		lookupController.route = '/banco-conta-caixa/'; 
		lookupController.gridColumns = bancoContaCaixaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = BancoContaCaixaModel.aliasColumns; 
		lookupController.dbColumns = BancoContaCaixaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			finLancamentoReceberModel.idBancoContaCaixa = plutoRowResult.cells['id']!.value; 
			finLancamentoReceberModel.bancoContaCaixaModel!.plutoRowToObject(plutoRowResult); 
			bancoContaCaixaModelController.text = finLancamentoReceberModel.bancoContaCaixaModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callFinDocumentoOrigemLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Documento Origem]'; 
		lookupController.route = '/fin-documento-origem/'; 
		lookupController.gridColumns = finDocumentoOrigemGridColumns(isForLookup: true); 
		lookupController.aliasColumns = FinDocumentoOrigemModel.aliasColumns; 
		lookupController.dbColumns = FinDocumentoOrigemModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			finLancamentoReceberModel.idFinDocumentoOrigem = plutoRowResult.cells['id']!.value; 
			finLancamentoReceberModel.finDocumentoOrigemModel!.plutoRowToObject(plutoRowResult); 
			finDocumentoOrigemModelController.text = finLancamentoReceberModel.finDocumentoOrigemModel?.sigla ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callFinNaturezaFinanceiraLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Natureza Financeira]'; 
		lookupController.route = '/fin-natureza-financeira/'; 
		lookupController.gridColumns = finNaturezaFinanceiraGridColumns(isForLookup: true); 
		lookupController.aliasColumns = FinNaturezaFinanceiraModel.aliasColumns; 
		lookupController.dbColumns = FinNaturezaFinanceiraModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			finLancamentoReceberModel.idFinNaturezaFinanceira = plutoRowResult.cells['id']!.value; 
			finLancamentoReceberModel.finNaturezaFinanceiraModel!.plutoRowToObject(plutoRowResult); 
			finNaturezaFinanceiraModelController.text = finLancamentoReceberModel.finNaturezaFinanceiraModel?.descricao ?? ''; 
			formWasChanged = true; 
		}
	}


	// override
	@override
	void onInit() {
		bootstrapGridParameters(
			gutterSize: Constants.flutterBootstrapGutterSize,
		);
		tabController = TabController(vsync: this, length: tabItems.length);
		functionName = "fin_lancamento_receber";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		viewPessoaClienteModelController.dispose();
		bancoContaCaixaModelController.dispose();
		finDocumentoOrigemModelController.dispose();
		finNaturezaFinanceiraModelController.dispose();
		quantidadeParcelaController.dispose();
		valorAReceberController.dispose();
		numeroDocumentoController.dispose();
		taxaComissaoController.dispose();
		valorComissaoController.dispose();
		intervaloEntreParcelasController.dispose();
		diaFixoController.dispose();
		super.onClose();
	}
}