import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/controller/controller_imports.dart';
import 'package:compras/app/data/model/model_imports.dart';
import 'package:compras/app/page/grid_columns/grid_columns_imports.dart';
import 'package:compras/app/page/page_imports.dart';

import 'package:compras/app/routes/app_routes.dart';
import 'package:compras/app/data/repository/compra_pedido_repository.dart';
import 'package:compras/app/page/shared_page/shared_page_imports.dart';
import 'package:compras/app/page/shared_widget/message_dialog.dart';
import 'package:compras/app/mixin/controller_base_mixin.dart';

class CompraPedidoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final CompraPedidoRepository compraPedidoRepository;
	CompraPedidoController({required this.compraPedidoRepository});

	// general
	final _dbColumns = CompraPedidoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = CompraPedidoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = compraPedidoGridColumns();
	
	var _compraPedidoModelList = <CompraPedidoModel>[];

	var _compraPedidoModelOld = CompraPedidoModel();

	final _compraPedidoModel = CompraPedidoModel().obs;
	CompraPedidoModel get compraPedidoModel => _compraPedidoModel.value;
	set compraPedidoModel(value) => _compraPedidoModel.value = value ?? CompraPedidoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Pedido', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Itens Pedido', 
		),
	];

	List<Widget> tabPages() {
		return [
			CompraPedidoEditPage(),
			const CompraPedidoDetalheListPage(),
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
		for (var compraPedidoModel in _compraPedidoModelList) {
			plutoRowList.add(_getPlutoRow(compraPedidoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CompraPedidoModel compraPedidoModel) {
		return PlutoRow(
			cells: _getPlutoCells(compraPedidoModel: compraPedidoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CompraPedidoModel? compraPedidoModel}) {
		return {
			"id": PlutoCell(value: compraPedidoModel?.id ?? 0),
			"compraTipoPedido": PlutoCell(value: compraPedidoModel?.compraTipoPedidoModel?.nome ?? ''),
			"viewPessoaColaborador": PlutoCell(value: compraPedidoModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"viewPessoaFornecedor": PlutoCell(value: compraPedidoModel?.viewPessoaFornecedorModel?.nome ?? ''),
			"codigoCotacao": PlutoCell(value: compraPedidoModel?.codigoCotacao ?? ''),
			"dataPedido": PlutoCell(value: compraPedidoModel?.dataPedido ?? ''),
			"dataPrevistaEntrega": PlutoCell(value: compraPedidoModel?.dataPrevistaEntrega ?? ''),
			"dataPrevisaoPagamento": PlutoCell(value: compraPedidoModel?.dataPrevisaoPagamento ?? ''),
			"localEntrega": PlutoCell(value: compraPedidoModel?.localEntrega ?? ''),
			"localCobranca": PlutoCell(value: compraPedidoModel?.localCobranca ?? ''),
			"contato": PlutoCell(value: compraPedidoModel?.contato ?? ''),
			"valorSubtotal": PlutoCell(value: compraPedidoModel?.valorSubtotal ?? 0),
			"taxaDesconto": PlutoCell(value: compraPedidoModel?.taxaDesconto ?? 0),
			"valorDesconto": PlutoCell(value: compraPedidoModel?.valorDesconto ?? 0),
			"valorTotal": PlutoCell(value: compraPedidoModel?.valorTotal ?? 0),
			"tipoFrete": PlutoCell(value: compraPedidoModel?.tipoFrete ?? ''),
			"formaPagamento": PlutoCell(value: compraPedidoModel?.formaPagamento ?? ''),
			"baseCalculoIcms": PlutoCell(value: compraPedidoModel?.baseCalculoIcms ?? 0),
			"valorIcms": PlutoCell(value: compraPedidoModel?.valorIcms ?? 0),
			"baseCalculoIcmsSt": PlutoCell(value: compraPedidoModel?.baseCalculoIcmsSt ?? 0),
			"valorIcmsSt": PlutoCell(value: compraPedidoModel?.valorIcmsSt ?? 0),
			"valorTotalProdutos": PlutoCell(value: compraPedidoModel?.valorTotalProdutos ?? 0),
			"valorFrete": PlutoCell(value: compraPedidoModel?.valorFrete ?? 0),
			"valorSeguro": PlutoCell(value: compraPedidoModel?.valorSeguro ?? 0),
			"valorOutrasDespesas": PlutoCell(value: compraPedidoModel?.valorOutrasDespesas ?? 0),
			"valorIpi": PlutoCell(value: compraPedidoModel?.valorIpi ?? 0),
			"valorTotalNf": PlutoCell(value: compraPedidoModel?.valorTotalNf ?? 0),
			"quantidadeParcelas": PlutoCell(value: compraPedidoModel?.quantidadeParcelas ?? 0),
			"diaPrimeiroVencimento": PlutoCell(value: compraPedidoModel?.diaPrimeiroVencimento ?? ''),
			"intervaloEntreParcelas": PlutoCell(value: compraPedidoModel?.intervaloEntreParcelas ?? 0),
			"diaFixoParcela": PlutoCell(value: compraPedidoModel?.diaFixoParcela ?? ''),
			"idCompraTipoPedido": PlutoCell(value: compraPedidoModel?.idCompraTipoPedido ?? 0),
			"idColaborador": PlutoCell(value: compraPedidoModel?.idColaborador ?? 0),
			"idFornecedor": PlutoCell(value: compraPedidoModel?.idFornecedor ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _compraPedidoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			compraPedidoModel.plutoRowToObject(plutoRow);
		} else {
			compraPedidoModel = modelFromRow[0];
			_compraPedidoModelOld = compraPedidoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Pedido]';
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
		await Get.find<CompraPedidoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await compraPedidoRepository.getList(filter: filter).then( (data){ _compraPedidoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Pedido',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			compraTipoPedidoModelController.text = currentRow.cells['compraTipoPedido']?.value ?? '';
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			viewPessoaFornecedorModelController.text = currentRow.cells['viewPessoaFornecedor']?.value ?? '';
			codigoCotacaoController.text = currentRow.cells['codigoCotacao']?.value ?? '';
			localEntregaController.text = currentRow.cells['localEntrega']?.value ?? '';
			localCobrancaController.text = currentRow.cells['localCobranca']?.value ?? '';
			contatoController.text = currentRow.cells['contato']?.value ?? '';
			valorSubtotalController.text = currentRow.cells['valorSubtotal']?.value?.toStringAsFixed(2) ?? '';
			taxaDescontoController.text = currentRow.cells['taxaDesconto']?.value?.toStringAsFixed(2) ?? '';
			valorDescontoController.text = currentRow.cells['valorDesconto']?.value?.toStringAsFixed(2) ?? '';
			valorTotalController.text = currentRow.cells['valorTotal']?.value?.toStringAsFixed(2) ?? '';
			baseCalculoIcmsController.text = currentRow.cells['baseCalculoIcms']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsController.text = currentRow.cells['valorIcms']?.value?.toStringAsFixed(2) ?? '';
			baseCalculoIcmsStController.text = currentRow.cells['baseCalculoIcmsSt']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsStController.text = currentRow.cells['valorIcmsSt']?.value?.toStringAsFixed(2) ?? '';
			valorTotalProdutosController.text = currentRow.cells['valorTotalProdutos']?.value?.toStringAsFixed(2) ?? '';
			valorFreteController.text = currentRow.cells['valorFrete']?.value?.toStringAsFixed(2) ?? '';
			valorSeguroController.text = currentRow.cells['valorSeguro']?.value?.toStringAsFixed(2) ?? '';
			valorOutrasDespesasController.text = currentRow.cells['valorOutrasDespesas']?.value?.toStringAsFixed(2) ?? '';
			valorIpiController.text = currentRow.cells['valorIpi']?.value?.toStringAsFixed(2) ?? '';
			valorTotalNfController.text = currentRow.cells['valorTotalNf']?.value?.toStringAsFixed(2) ?? '';
			quantidadeParcelasController.text = currentRow.cells['quantidadeParcelas']?.value?.toString() ?? '';
			diaPrimeiroVencimentoController.text = currentRow.cells['diaPrimeiroVencimento']?.value ?? '';
			intervaloEntreParcelasController.text = currentRow.cells['intervaloEntreParcelas']?.value?.toString() ?? '';
			diaFixoParcelaController.text = currentRow.cells['diaFixoParcela']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Itens Pedido
			Get.put<CompraPedidoDetalheController>(CompraPedidoDetalheController()); 
			final compraPedidoDetalheController = Get.find<CompraPedidoDetalheController>(); 
			compraPedidoDetalheController.compraPedidoDetalheModelList = compraPedidoModel.compraPedidoDetalheModelList!; 
			compraPedidoDetalheController.userMadeChanges = false; 


			Get.toNamed(Routes.compraPedidoTabPage)!.then((value) {
				if (compraPedidoModel.id == 0) {
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
		compraPedidoModel = CompraPedidoModel();
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
				if (await compraPedidoRepository.delete(id: currentRow.cells['id']!.value)) {
					_compraPedidoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final compraTipoPedidoModelController = TextEditingController();
	final viewPessoaColaboradorModelController = TextEditingController();
	final viewPessoaFornecedorModelController = TextEditingController();
	final codigoCotacaoController = TextEditingController();
	final localEntregaController = TextEditingController();
	final localCobrancaController = TextEditingController();
	final contatoController = TextEditingController();
	final valorSubtotalController = MoneyMaskedTextController();
	final taxaDescontoController = MoneyMaskedTextController();
	final valorDescontoController = MoneyMaskedTextController();
	final valorTotalController = MoneyMaskedTextController();
	final baseCalculoIcmsController = MoneyMaskedTextController();
	final valorIcmsController = MoneyMaskedTextController();
	final baseCalculoIcmsStController = MoneyMaskedTextController();
	final valorIcmsStController = MoneyMaskedTextController();
	final valorTotalProdutosController = MoneyMaskedTextController();
	final valorFreteController = MoneyMaskedTextController();
	final valorSeguroController = MoneyMaskedTextController();
	final valorOutrasDespesasController = MoneyMaskedTextController();
	final valorIpiController = MoneyMaskedTextController();
	final valorTotalNfController = MoneyMaskedTextController();
	final quantidadeParcelasController = TextEditingController();
	final diaPrimeiroVencimentoController = TextEditingController();
	final intervaloEntreParcelasController = TextEditingController();
	final diaFixoParcelaController = TextEditingController();

	final compraPedidoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final compraPedidoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final compraPedidoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = compraPedidoModel.id;
		plutoRow.cells['idCompraTipoPedido']?.value = compraPedidoModel.idCompraTipoPedido;
		plutoRow.cells['compraTipoPedido']?.value = compraPedidoModel.compraTipoPedidoModel?.nome;
		plutoRow.cells['idColaborador']?.value = compraPedidoModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = compraPedidoModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['idFornecedor']?.value = compraPedidoModel.idFornecedor;
		plutoRow.cells['viewPessoaFornecedor']?.value = compraPedidoModel.viewPessoaFornecedorModel?.nome;
		plutoRow.cells['codigoCotacao']?.value = compraPedidoModel.codigoCotacao;
		plutoRow.cells['dataPedido']?.value = Util.formatDate(compraPedidoModel.dataPedido);
		plutoRow.cells['dataPrevistaEntrega']?.value = Util.formatDate(compraPedidoModel.dataPrevistaEntrega);
		plutoRow.cells['dataPrevisaoPagamento']?.value = Util.formatDate(compraPedidoModel.dataPrevisaoPagamento);
		plutoRow.cells['localEntrega']?.value = compraPedidoModel.localEntrega;
		plutoRow.cells['localCobranca']?.value = compraPedidoModel.localCobranca;
		plutoRow.cells['contato']?.value = compraPedidoModel.contato;
		plutoRow.cells['valorSubtotal']?.value = compraPedidoModel.valorSubtotal;
		plutoRow.cells['taxaDesconto']?.value = compraPedidoModel.taxaDesconto;
		plutoRow.cells['valorDesconto']?.value = compraPedidoModel.valorDesconto;
		plutoRow.cells['valorTotal']?.value = compraPedidoModel.valorTotal;
		plutoRow.cells['tipoFrete']?.value = compraPedidoModel.tipoFrete;
		plutoRow.cells['formaPagamento']?.value = compraPedidoModel.formaPagamento;
		plutoRow.cells['baseCalculoIcms']?.value = compraPedidoModel.baseCalculoIcms;
		plutoRow.cells['valorIcms']?.value = compraPedidoModel.valorIcms;
		plutoRow.cells['baseCalculoIcmsSt']?.value = compraPedidoModel.baseCalculoIcmsSt;
		plutoRow.cells['valorIcmsSt']?.value = compraPedidoModel.valorIcmsSt;
		plutoRow.cells['valorTotalProdutos']?.value = compraPedidoModel.valorTotalProdutos;
		plutoRow.cells['valorFrete']?.value = compraPedidoModel.valorFrete;
		plutoRow.cells['valorSeguro']?.value = compraPedidoModel.valorSeguro;
		plutoRow.cells['valorOutrasDespesas']?.value = compraPedidoModel.valorOutrasDespesas;
		plutoRow.cells['valorIpi']?.value = compraPedidoModel.valorIpi;
		plutoRow.cells['valorTotalNf']?.value = compraPedidoModel.valorTotalNf;
		plutoRow.cells['quantidadeParcelas']?.value = compraPedidoModel.quantidadeParcelas;
		plutoRow.cells['diaPrimeiroVencimento']?.value = compraPedidoModel.diaPrimeiroVencimento;
		plutoRow.cells['intervaloEntreParcelas']?.value = compraPedidoModel.intervaloEntreParcelas;
		plutoRow.cells['diaFixoParcela']?.value = compraPedidoModel.diaFixoParcela;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await compraPedidoRepository.save(compraPedidoModel: compraPedidoModel); 
				if (result != null) {
					compraPedidoModel = result;
					if (_isInserting) {
						_compraPedidoModelList.add(compraPedidoModel);
						_isInserting = false;
					} else {
            _compraPedidoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _compraPedidoModelList.add(compraPedidoModel);
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
		Get.find<CompraPedidoDetalheController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_compraPedidoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_compraPedidoModelList.add(_compraPedidoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(compraPedidoModel.compraTipoPedidoModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Tipo Pedido]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(compraPedidoModel.viewPessoaColaboradorModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Colaborador]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(compraPedidoModel.viewPessoaFornecedorModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Fornecedor]'); 
			return false; 
		}
		return true;
	}

	Future callCompraTipoPedidoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tipo Pedido]'; 
		lookupController.route = '/compra-tipo-pedido/'; 
		lookupController.gridColumns = compraTipoPedidoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CompraTipoPedidoModel.aliasColumns; 
		lookupController.dbColumns = CompraTipoPedidoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			compraPedidoModel.idCompraTipoPedido = plutoRowResult.cells['id']!.value; 
			compraPedidoModel.compraTipoPedidoModel!.plutoRowToObject(plutoRowResult); 
			compraTipoPedidoModelController.text = compraPedidoModel.compraTipoPedidoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callViewPessoaColaboradorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Colaborador]'; 
		lookupController.route = '/view-pessoa-colaborador/'; 
		lookupController.gridColumns = viewPessoaColaboradorGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaColaboradorModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaColaboradorModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			compraPedidoModel.idColaborador = plutoRowResult.cells['id']!.value; 
			compraPedidoModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = compraPedidoModel.viewPessoaColaboradorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
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
			compraPedidoModel.idFornecedor = plutoRowResult.cells['id']!.value; 
			compraPedidoModel.viewPessoaFornecedorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaFornecedorModelController.text = compraPedidoModel.viewPessoaFornecedorModel?.nome ?? ''; 
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
		functionName = "compra_pedido";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		compraTipoPedidoModelController.dispose();
		viewPessoaColaboradorModelController.dispose();
		viewPessoaFornecedorModelController.dispose();
		codigoCotacaoController.dispose();
		localEntregaController.dispose();
		localCobrancaController.dispose();
		contatoController.dispose();
		valorSubtotalController.dispose();
		taxaDescontoController.dispose();
		valorDescontoController.dispose();
		valorTotalController.dispose();
		baseCalculoIcmsController.dispose();
		valorIcmsController.dispose();
		baseCalculoIcmsStController.dispose();
		valorIcmsStController.dispose();
		valorTotalProdutosController.dispose();
		valorFreteController.dispose();
		valorSeguroController.dispose();
		valorOutrasDespesasController.dispose();
		valorIpiController.dispose();
		valorTotalNfController.dispose();
		quantidadeParcelasController.dispose();
		diaPrimeiroVencimentoController.dispose();
		intervaloEntreParcelasController.dispose();
		diaFixoParcelaController.dispose();
		super.onClose();
	}
}