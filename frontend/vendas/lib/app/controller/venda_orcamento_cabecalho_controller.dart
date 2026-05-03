import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/controller/controller_imports.dart';
import 'package:vendas/app/data/model/model_imports.dart';
import 'package:vendas/app/page/grid_columns/grid_columns_imports.dart';
import 'package:vendas/app/page/page_imports.dart';

import 'package:vendas/app/routes/app_routes.dart';
import 'package:vendas/app/data/repository/venda_orcamento_cabecalho_repository.dart';
import 'package:vendas/app/page/shared_page/shared_page_imports.dart';
import 'package:vendas/app/page/shared_widget/message_dialog.dart';
import 'package:vendas/app/mixin/controller_base_mixin.dart';

class VendaOrcamentoCabecalhoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final VendaOrcamentoCabecalhoRepository vendaOrcamentoCabecalhoRepository;
	VendaOrcamentoCabecalhoController({required this.vendaOrcamentoCabecalhoRepository});

	// general
	final _dbColumns = VendaOrcamentoCabecalhoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = VendaOrcamentoCabecalhoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = vendaOrcamentoCabecalhoGridColumns();
	
	var _vendaOrcamentoCabecalhoModelList = <VendaOrcamentoCabecalhoModel>[];

	var _vendaOrcamentoCabecalhoModelOld = VendaOrcamentoCabecalhoModel();

	final _vendaOrcamentoCabecalhoModel = VendaOrcamentoCabecalhoModel().obs;
	VendaOrcamentoCabecalhoModel get vendaOrcamentoCabecalhoModel => _vendaOrcamentoCabecalhoModel.value;
	set vendaOrcamentoCabecalhoModel(value) => _vendaOrcamentoCabecalhoModel.value = value ?? VendaOrcamentoCabecalhoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Orçamento de Venda', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Itens do Orçamento', 
		),
	];

	List<Widget> tabPages() {
		return [
			VendaOrcamentoCabecalhoEditPage(),
			const VendaOrcamentoDetalheListPage(),
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
		for (var vendaOrcamentoCabecalhoModel in _vendaOrcamentoCabecalhoModelList) {
			plutoRowList.add(_getPlutoRow(vendaOrcamentoCabecalhoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(VendaOrcamentoCabecalhoModel vendaOrcamentoCabecalhoModel) {
		return PlutoRow(
			cells: _getPlutoCells(vendaOrcamentoCabecalhoModel: vendaOrcamentoCabecalhoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ VendaOrcamentoCabecalhoModel? vendaOrcamentoCabecalhoModel}) {
		return {
			"id": PlutoCell(value: vendaOrcamentoCabecalhoModel?.id ?? 0),
			"viewPessoaVendedor": PlutoCell(value: vendaOrcamentoCabecalhoModel?.viewPessoaVendedorModel?.nome ?? ''),
			"viewPessoaCliente": PlutoCell(value: vendaOrcamentoCabecalhoModel?.viewPessoaClienteModel?.nome ?? ''),
			"vendaCondicoesPagamento": PlutoCell(value: vendaOrcamentoCabecalhoModel?.vendaCondicoesPagamentoModel?.nome ?? ''),
			"viewPessoaTransportadora": PlutoCell(value: vendaOrcamentoCabecalhoModel?.viewPessoaTransportadoraModel?.nome ?? ''),
			"tipoFrete": PlutoCell(value: vendaOrcamentoCabecalhoModel?.tipoFrete ?? ''),
			"codigo": PlutoCell(value: vendaOrcamentoCabecalhoModel?.codigo ?? ''),
			"dataCadastro": PlutoCell(value: vendaOrcamentoCabecalhoModel?.dataCadastro ?? ''),
			"dataEntrega": PlutoCell(value: vendaOrcamentoCabecalhoModel?.dataEntrega ?? ''),
			"dataValidade": PlutoCell(value: vendaOrcamentoCabecalhoModel?.dataValidade ?? ''),
			"valorSubtotal": PlutoCell(value: vendaOrcamentoCabecalhoModel?.valorSubtotal ?? 0),
			"valorFrete": PlutoCell(value: vendaOrcamentoCabecalhoModel?.valorFrete ?? 0),
			"taxaComissao": PlutoCell(value: vendaOrcamentoCabecalhoModel?.taxaComissao ?? 0),
			"valorComissao": PlutoCell(value: vendaOrcamentoCabecalhoModel?.valorComissao ?? 0),
			"taxaDesconto": PlutoCell(value: vendaOrcamentoCabecalhoModel?.taxaDesconto ?? 0),
			"valorDesconto": PlutoCell(value: vendaOrcamentoCabecalhoModel?.valorDesconto ?? 0),
			"valorTotal": PlutoCell(value: vendaOrcamentoCabecalhoModel?.valorTotal ?? 0),
			"observacao": PlutoCell(value: vendaOrcamentoCabecalhoModel?.observacao ?? ''),
			"idVendedor": PlutoCell(value: vendaOrcamentoCabecalhoModel?.idVendedor ?? 0),
			"idCliente": PlutoCell(value: vendaOrcamentoCabecalhoModel?.idCliente ?? 0),
			"idVendaCondicoesPagamento": PlutoCell(value: vendaOrcamentoCabecalhoModel?.idVendaCondicoesPagamento ?? 0),
			"idTransportadora": PlutoCell(value: vendaOrcamentoCabecalhoModel?.idTransportadora ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _vendaOrcamentoCabecalhoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			vendaOrcamentoCabecalhoModel.plutoRowToObject(plutoRow);
		} else {
			vendaOrcamentoCabecalhoModel = modelFromRow[0];
			_vendaOrcamentoCabecalhoModelOld = vendaOrcamentoCabecalhoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Orçamento de Venda]';
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
		await Get.find<VendaOrcamentoCabecalhoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await vendaOrcamentoCabecalhoRepository.getList(filter: filter).then( (data){ _vendaOrcamentoCabecalhoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Orçamento de Venda',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			viewPessoaVendedorModelController.text = currentRow.cells['viewPessoaVendedor']?.value ?? '';
			viewPessoaClienteModelController.text = currentRow.cells['viewPessoaCliente']?.value ?? '';
			vendaCondicoesPagamentoModelController.text = currentRow.cells['vendaCondicoesPagamento']?.value ?? '';
			viewPessoaTransportadoraModelController.text = currentRow.cells['viewPessoaTransportadora']?.value ?? '';
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			valorSubtotalController.text = currentRow.cells['valorSubtotal']?.value?.toStringAsFixed(2) ?? '';
			valorFreteController.text = currentRow.cells['valorFrete']?.value?.toStringAsFixed(2) ?? '';
			taxaComissaoController.text = currentRow.cells['taxaComissao']?.value?.toStringAsFixed(2) ?? '';
			valorComissaoController.text = currentRow.cells['valorComissao']?.value?.toStringAsFixed(2) ?? '';
			taxaDescontoController.text = currentRow.cells['taxaDesconto']?.value?.toStringAsFixed(2) ?? '';
			valorDescontoController.text = currentRow.cells['valorDesconto']?.value?.toStringAsFixed(2) ?? '';
			valorTotalController.text = currentRow.cells['valorTotal']?.value?.toStringAsFixed(2) ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Itens do Orçamento
			Get.put<VendaOrcamentoDetalheController>(VendaOrcamentoDetalheController()); 
			final vendaOrcamentoDetalheController = Get.find<VendaOrcamentoDetalheController>(); 
			vendaOrcamentoDetalheController.vendaOrcamentoDetalheModelList = vendaOrcamentoCabecalhoModel.vendaOrcamentoDetalheModelList!; 
			vendaOrcamentoDetalheController.userMadeChanges = false; 


			Get.toNamed(Routes.vendaOrcamentoCabecalhoTabPage)!.then((value) {
				if (vendaOrcamentoCabecalhoModel.id == 0) {
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
		vendaOrcamentoCabecalhoModel = VendaOrcamentoCabecalhoModel();
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
				if (await vendaOrcamentoCabecalhoRepository.delete(id: currentRow.cells['id']!.value)) {
					_vendaOrcamentoCabecalhoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final viewPessoaVendedorModelController = TextEditingController();
	final viewPessoaClienteModelController = TextEditingController();
	final vendaCondicoesPagamentoModelController = TextEditingController();
	final viewPessoaTransportadoraModelController = TextEditingController();
	final codigoController = TextEditingController();
	final valorSubtotalController = MoneyMaskedTextController();
	final valorFreteController = MoneyMaskedTextController();
	final taxaComissaoController = MoneyMaskedTextController();
	final valorComissaoController = MoneyMaskedTextController();
	final taxaDescontoController = MoneyMaskedTextController();
	final valorDescontoController = MoneyMaskedTextController();
	final valorTotalController = MoneyMaskedTextController();
	final observacaoController = TextEditingController();

	final vendaOrcamentoCabecalhoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final vendaOrcamentoCabecalhoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final vendaOrcamentoCabecalhoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = vendaOrcamentoCabecalhoModel.id;
		plutoRow.cells['idVendedor']?.value = vendaOrcamentoCabecalhoModel.idVendedor;
		plutoRow.cells['viewPessoaVendedor']?.value = vendaOrcamentoCabecalhoModel.viewPessoaVendedorModel?.nome;
		plutoRow.cells['idCliente']?.value = vendaOrcamentoCabecalhoModel.idCliente;
		plutoRow.cells['viewPessoaCliente']?.value = vendaOrcamentoCabecalhoModel.viewPessoaClienteModel?.nome;
		plutoRow.cells['idVendaCondicoesPagamento']?.value = vendaOrcamentoCabecalhoModel.idVendaCondicoesPagamento;
		plutoRow.cells['vendaCondicoesPagamento']?.value = vendaOrcamentoCabecalhoModel.vendaCondicoesPagamentoModel?.nome;
		plutoRow.cells['idTransportadora']?.value = vendaOrcamentoCabecalhoModel.idTransportadora;
		plutoRow.cells['viewPessoaTransportadora']?.value = vendaOrcamentoCabecalhoModel.viewPessoaTransportadoraModel?.nome;
		plutoRow.cells['tipoFrete']?.value = vendaOrcamentoCabecalhoModel.tipoFrete;
		plutoRow.cells['codigo']?.value = vendaOrcamentoCabecalhoModel.codigo;
		plutoRow.cells['dataCadastro']?.value = Util.formatDate(vendaOrcamentoCabecalhoModel.dataCadastro);
		plutoRow.cells['dataEntrega']?.value = Util.formatDate(vendaOrcamentoCabecalhoModel.dataEntrega);
		plutoRow.cells['dataValidade']?.value = Util.formatDate(vendaOrcamentoCabecalhoModel.dataValidade);
		plutoRow.cells['valorSubtotal']?.value = vendaOrcamentoCabecalhoModel.valorSubtotal;
		plutoRow.cells['valorFrete']?.value = vendaOrcamentoCabecalhoModel.valorFrete;
		plutoRow.cells['taxaComissao']?.value = vendaOrcamentoCabecalhoModel.taxaComissao;
		plutoRow.cells['valorComissao']?.value = vendaOrcamentoCabecalhoModel.valorComissao;
		plutoRow.cells['taxaDesconto']?.value = vendaOrcamentoCabecalhoModel.taxaDesconto;
		plutoRow.cells['valorDesconto']?.value = vendaOrcamentoCabecalhoModel.valorDesconto;
		plutoRow.cells['valorTotal']?.value = vendaOrcamentoCabecalhoModel.valorTotal;
		plutoRow.cells['observacao']?.value = vendaOrcamentoCabecalhoModel.observacao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await vendaOrcamentoCabecalhoRepository.save(vendaOrcamentoCabecalhoModel: vendaOrcamentoCabecalhoModel); 
				if (result != null) {
					vendaOrcamentoCabecalhoModel = result;
					if (_isInserting) {
						_vendaOrcamentoCabecalhoModelList.add(vendaOrcamentoCabecalhoModel);
						_isInserting = false;
					} else {
            _vendaOrcamentoCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _vendaOrcamentoCabecalhoModelList.add(vendaOrcamentoCabecalhoModel);
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
		Get.find<VendaOrcamentoDetalheController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_vendaOrcamentoCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_vendaOrcamentoCabecalhoModelList.add(_vendaOrcamentoCabecalhoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(vendaOrcamentoCabecalhoModel.viewPessoaVendedorModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Vendedor]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(vendaOrcamentoCabecalhoModel.viewPessoaClienteModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Cliente]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(vendaOrcamentoCabecalhoModel.vendaCondicoesPagamentoModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Condicoes Pagamento]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(vendaOrcamentoCabecalhoModel.viewPessoaTransportadoraModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Transportadora]'); 
			return false; 
		}
		return true;
	}

	Future callViewPessoaVendedorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Vendedor]'; 
		lookupController.route = '/view-pessoa-vendedor/'; 
		lookupController.gridColumns = viewPessoaVendedorGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaVendedorModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaVendedorModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			vendaOrcamentoCabecalhoModel.idVendedor = plutoRowResult.cells['id']!.value; 
			vendaOrcamentoCabecalhoModel.viewPessoaVendedorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaVendedorModelController.text = vendaOrcamentoCabecalhoModel.viewPessoaVendedorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
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
			vendaOrcamentoCabecalhoModel.idCliente = plutoRowResult.cells['id']!.value; 
			vendaOrcamentoCabecalhoModel.viewPessoaClienteModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaClienteModelController.text = vendaOrcamentoCabecalhoModel.viewPessoaClienteModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callVendaCondicoesPagamentoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Condicoes Pagamento]'; 
		lookupController.route = '/venda-condicoes-pagamento/'; 
		lookupController.gridColumns = vendaCondicoesPagamentoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = VendaCondicoesPagamentoModel.aliasColumns; 
		lookupController.dbColumns = VendaCondicoesPagamentoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			vendaOrcamentoCabecalhoModel.idVendaCondicoesPagamento = plutoRowResult.cells['id']!.value; 
			vendaOrcamentoCabecalhoModel.vendaCondicoesPagamentoModel!.plutoRowToObject(plutoRowResult); 
			vendaCondicoesPagamentoModelController.text = vendaOrcamentoCabecalhoModel.vendaCondicoesPagamentoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callViewPessoaTransportadoraLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Transportadora]'; 
		lookupController.route = '/view-pessoa-transportadora/'; 
		lookupController.gridColumns = viewPessoaTransportadoraGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaTransportadoraModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaTransportadoraModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			vendaOrcamentoCabecalhoModel.idTransportadora = plutoRowResult.cells['id']!.value; 
			vendaOrcamentoCabecalhoModel.viewPessoaTransportadoraModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaTransportadoraModelController.text = vendaOrcamentoCabecalhoModel.viewPessoaTransportadoraModel?.nome ?? ''; 
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
		functionName = "venda_orcamento_cabecalho";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		viewPessoaVendedorModelController.dispose();
		viewPessoaClienteModelController.dispose();
		vendaCondicoesPagamentoModelController.dispose();
		viewPessoaTransportadoraModelController.dispose();
		codigoController.dispose();
		valorSubtotalController.dispose();
		valorFreteController.dispose();
		taxaComissaoController.dispose();
		valorComissaoController.dispose();
		taxaDescontoController.dispose();
		valorDescontoController.dispose();
		valorTotalController.dispose();
		observacaoController.dispose();
		super.onClose();
	}
}