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
import 'package:financeiro/app/data/repository/fin_lancamento_pagar_repository.dart';
import 'package:financeiro/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro/app/page/shared_widget/message_dialog.dart';
import 'package:financeiro/app/mixin/controller_base_mixin.dart';

class FinLancamentoPagarController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final FinLancamentoPagarRepository finLancamentoPagarRepository;
	FinLancamentoPagarController({required this.finLancamentoPagarRepository});

	// general
	final _dbColumns = FinLancamentoPagarModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = FinLancamentoPagarModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = finLancamentoPagarGridColumns();
	
	var _finLancamentoPagarModelList = <FinLancamentoPagarModel>[];

	var _finLancamentoPagarModelOld = FinLancamentoPagarModel();

	final _finLancamentoPagarModel = FinLancamentoPagarModel().obs;
	FinLancamentoPagarModel get finLancamentoPagarModel => _finLancamentoPagarModel.value;
	set finLancamentoPagarModel(value) => _finLancamentoPagarModel.value = value ?? FinLancamentoPagarModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Lançamento a Pagar', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Parcelas', 
		),
	];

	List<Widget> tabPages() {
		return [
			FinLancamentoPagarEditPage(),
			const FinParcelaPagarListPage(),
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
		for (var finLancamentoPagarModel in _finLancamentoPagarModelList) {
			plutoRowList.add(_getPlutoRow(finLancamentoPagarModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FinLancamentoPagarModel finLancamentoPagarModel) {
		return PlutoRow(
			cells: _getPlutoCells(finLancamentoPagarModel: finLancamentoPagarModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FinLancamentoPagarModel? finLancamentoPagarModel}) {
		return {
			"id": PlutoCell(value: finLancamentoPagarModel?.id ?? 0),
			"viewPessoaFornecedor": PlutoCell(value: finLancamentoPagarModel?.viewPessoaFornecedorModel?.nome ?? ''),
			"bancoContaCaixa": PlutoCell(value: finLancamentoPagarModel?.bancoContaCaixaModel?.nome ?? ''),
			"finDocumentoOrigem": PlutoCell(value: finLancamentoPagarModel?.finDocumentoOrigemModel?.sigla ?? ''),
			"finNaturezaFinanceira": PlutoCell(value: finLancamentoPagarModel?.finNaturezaFinanceiraModel?.descricao ?? ''),
			"quantidadeParcela": PlutoCell(value: finLancamentoPagarModel?.quantidadeParcela ?? 0),
			"valorAPagar": PlutoCell(value: finLancamentoPagarModel?.valorAPagar ?? 0),
			"dataLancamento": PlutoCell(value: finLancamentoPagarModel?.dataLancamento ?? ''),
			"numeroDocumento": PlutoCell(value: finLancamentoPagarModel?.numeroDocumento ?? ''),
			"primeiroVencimento": PlutoCell(value: finLancamentoPagarModel?.primeiroVencimento ?? ''),
			"intervaloEntreParcelas": PlutoCell(value: finLancamentoPagarModel?.intervaloEntreParcelas ?? 0),
			"diaFixo": PlutoCell(value: finLancamentoPagarModel?.diaFixo ?? ''),
			"imagemDocumento": PlutoCell(value: finLancamentoPagarModel?.imagemDocumento ?? ''),
			"idFornecedor": PlutoCell(value: finLancamentoPagarModel?.idFornecedor ?? 0),
			"idBancoContaCaixa": PlutoCell(value: finLancamentoPagarModel?.idBancoContaCaixa ?? 0),
			"idFinDocumentoOrigem": PlutoCell(value: finLancamentoPagarModel?.idFinDocumentoOrigem ?? 0),
			"idFinNaturezaFinanceira": PlutoCell(value: finLancamentoPagarModel?.idFinNaturezaFinanceira ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _finLancamentoPagarModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			finLancamentoPagarModel.plutoRowToObject(plutoRow);
		} else {
			finLancamentoPagarModel = modelFromRow[0];
			_finLancamentoPagarModelOld = finLancamentoPagarModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Lançamento a Pagar]';
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
		await Get.find<FinLancamentoPagarController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await finLancamentoPagarRepository.getList(filter: filter).then( (data){ _finLancamentoPagarModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Lançamento a Pagar',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			viewPessoaFornecedorModelController.text = currentRow.cells['viewPessoaFornecedor']?.value ?? '';
			bancoContaCaixaModelController.text = currentRow.cells['bancoContaCaixa']?.value ?? '';
			finDocumentoOrigemModelController.text = currentRow.cells['finDocumentoOrigem']?.value ?? '';
			finNaturezaFinanceiraModelController.text = currentRow.cells['finNaturezaFinanceira']?.value ?? '';
			quantidadeParcelaController.text = currentRow.cells['quantidadeParcela']?.value?.toString() ?? '';
			valorAPagarController.text = currentRow.cells['valorAPagar']?.value?.toStringAsFixed(2) ?? '';
			numeroDocumentoController.text = currentRow.cells['numeroDocumento']?.value ?? '';
			intervaloEntreParcelasController.text = currentRow.cells['intervaloEntreParcelas']?.value?.toString() ?? '';
			diaFixoController.text = currentRow.cells['diaFixo']?.value ?? '';
			imagemDocumentoController.text = currentRow.cells['imagemDocumento']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Parcelas
			Get.put<FinParcelaPagarController>(FinParcelaPagarController()); 
			final finParcelaPagarController = Get.find<FinParcelaPagarController>(); 
			finParcelaPagarController.finParcelaPagarModelList = finLancamentoPagarModel.finParcelaPagarModelList!; 
			finParcelaPagarController.userMadeChanges = false; 


			Get.toNamed(Routes.finLancamentoPagarTabPage)!.then((value) {
				if (finLancamentoPagarModel.id == 0) {
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
		finLancamentoPagarModel = FinLancamentoPagarModel();
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
				if (await finLancamentoPagarRepository.delete(id: currentRow.cells['id']!.value)) {
					_finLancamentoPagarModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final viewPessoaFornecedorModelController = TextEditingController();
	final bancoContaCaixaModelController = TextEditingController();
	final finDocumentoOrigemModelController = TextEditingController();
	final finNaturezaFinanceiraModelController = TextEditingController();
	final quantidadeParcelaController = TextEditingController();
	final valorAPagarController = MoneyMaskedTextController();
	final numeroDocumentoController = TextEditingController();
	final intervaloEntreParcelasController = TextEditingController();
	final diaFixoController = TextEditingController();
	final imagemDocumentoController = TextEditingController();

	final finLancamentoPagarTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final finLancamentoPagarEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final finLancamentoPagarEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = finLancamentoPagarModel.id;
		plutoRow.cells['idFornecedor']?.value = finLancamentoPagarModel.idFornecedor;
		plutoRow.cells['viewPessoaFornecedor']?.value = finLancamentoPagarModel.viewPessoaFornecedorModel?.nome;
		plutoRow.cells['idBancoContaCaixa']?.value = finLancamentoPagarModel.idBancoContaCaixa;
		plutoRow.cells['bancoContaCaixa']?.value = finLancamentoPagarModel.bancoContaCaixaModel?.nome;
		plutoRow.cells['idFinDocumentoOrigem']?.value = finLancamentoPagarModel.idFinDocumentoOrigem;
		plutoRow.cells['finDocumentoOrigem']?.value = finLancamentoPagarModel.finDocumentoOrigemModel?.sigla;
		plutoRow.cells['idFinNaturezaFinanceira']?.value = finLancamentoPagarModel.idFinNaturezaFinanceira;
		plutoRow.cells['finNaturezaFinanceira']?.value = finLancamentoPagarModel.finNaturezaFinanceiraModel?.descricao;
		plutoRow.cells['quantidadeParcela']?.value = finLancamentoPagarModel.quantidadeParcela;
		plutoRow.cells['valorAPagar']?.value = finLancamentoPagarModel.valorAPagar;
		plutoRow.cells['dataLancamento']?.value = Util.formatDate(finLancamentoPagarModel.dataLancamento);
		plutoRow.cells['numeroDocumento']?.value = finLancamentoPagarModel.numeroDocumento;
		plutoRow.cells['primeiroVencimento']?.value = Util.formatDate(finLancamentoPagarModel.primeiroVencimento);
		plutoRow.cells['intervaloEntreParcelas']?.value = finLancamentoPagarModel.intervaloEntreParcelas;
		plutoRow.cells['diaFixo']?.value = finLancamentoPagarModel.diaFixo;
		plutoRow.cells['imagemDocumento']?.value = finLancamentoPagarModel.imagemDocumento;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await finLancamentoPagarRepository.save(finLancamentoPagarModel: finLancamentoPagarModel); 
				if (result != null) {
					finLancamentoPagarModel = result;
					if (_isInserting) {
						_finLancamentoPagarModelList.add(finLancamentoPagarModel);
						_isInserting = false;
					} else {
            _finLancamentoPagarModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _finLancamentoPagarModelList.add(finLancamentoPagarModel);
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
		Get.find<FinParcelaPagarController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_finLancamentoPagarModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_finLancamentoPagarModelList.add(_finLancamentoPagarModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(finLancamentoPagarModel.viewPessoaFornecedorModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Fornecedor]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(finLancamentoPagarModel.bancoContaCaixaModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Conta/Caixa]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(finLancamentoPagarModel.finDocumentoOrigemModel?.sigla); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Documento Origem]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(finLancamentoPagarModel.finNaturezaFinanceiraModel?.descricao); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Natureza Financeira]'); 
			return false; 
		}
		return true;
	}

	Future callViewPessoaFornecedorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Fornecedor]'; 
		lookupController.route = '/view-pessoa-fornecedor/'; 
		lookupController.gridColumns = viewPessoaFornecedorGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaFornecedorModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaFornecedorModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			finLancamentoPagarModel.idFornecedor = plutoRowResult.cells['id']!.value; 
			finLancamentoPagarModel.viewPessoaFornecedorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaFornecedorModelController.text = finLancamentoPagarModel.viewPessoaFornecedorModel?.nome ?? ''; 
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
			finLancamentoPagarModel.idBancoContaCaixa = plutoRowResult.cells['id']!.value; 
			finLancamentoPagarModel.bancoContaCaixaModel!.plutoRowToObject(plutoRowResult); 
			bancoContaCaixaModelController.text = finLancamentoPagarModel.bancoContaCaixaModel?.nome ?? ''; 
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
			finLancamentoPagarModel.idFinDocumentoOrigem = plutoRowResult.cells['id']!.value; 
			finLancamentoPagarModel.finDocumentoOrigemModel!.plutoRowToObject(plutoRowResult); 
			finDocumentoOrigemModelController.text = finLancamentoPagarModel.finDocumentoOrigemModel?.sigla ?? ''; 
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
			finLancamentoPagarModel.idFinNaturezaFinanceira = plutoRowResult.cells['id']!.value; 
			finLancamentoPagarModel.finNaturezaFinanceiraModel!.plutoRowToObject(plutoRowResult); 
			finNaturezaFinanceiraModelController.text = finLancamentoPagarModel.finNaturezaFinanceiraModel?.descricao ?? ''; 
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
		functionName = "fin_lancamento_pagar";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		viewPessoaFornecedorModelController.dispose();
		bancoContaCaixaModelController.dispose();
		finDocumentoOrigemModelController.dispose();
		finNaturezaFinanceiraModelController.dispose();
		quantidadeParcelaController.dispose();
		valorAPagarController.dispose();
		numeroDocumentoController.dispose();
		intervaloEntreParcelasController.dispose();
		diaFixoController.dispose();
		imagemDocumentoController.dispose();
		super.onClose();
	}
}