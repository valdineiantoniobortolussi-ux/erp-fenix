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
import 'package:vendas/app/data/repository/venda_cabecalho_repository.dart';
import 'package:vendas/app/page/shared_page/shared_page_imports.dart';
import 'package:vendas/app/page/shared_widget/message_dialog.dart';
import 'package:vendas/app/mixin/controller_base_mixin.dart';

class VendaCabecalhoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final VendaCabecalhoRepository vendaCabecalhoRepository;
	VendaCabecalhoController({required this.vendaCabecalhoRepository});

	// general
	final _dbColumns = VendaCabecalhoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = VendaCabecalhoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = vendaCabecalhoGridColumns();
	
	var _vendaCabecalhoModelList = <VendaCabecalhoModel>[];

	var _vendaCabecalhoModelOld = VendaCabecalhoModel();

	final _vendaCabecalhoModel = VendaCabecalhoModel().obs;
	VendaCabecalhoModel get vendaCabecalhoModel => _vendaCabecalhoModel.value;
	set vendaCabecalhoModel(value) => _vendaCabecalhoModel.value = value ?? VendaCabecalhoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Venda', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Comissão', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Itens da Venda', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Frete', 
		),
	];

	List<Widget> tabPages() {
		return [
			VendaCabecalhoEditPage(),
			VendaComissaoEditPage(),
			const VendaDetalheListPage(),
			const VendaFreteListPage(),
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
		for (var vendaCabecalhoModel in _vendaCabecalhoModelList) {
			plutoRowList.add(_getPlutoRow(vendaCabecalhoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(VendaCabecalhoModel vendaCabecalhoModel) {
		return PlutoRow(
			cells: _getPlutoCells(vendaCabecalhoModel: vendaCabecalhoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ VendaCabecalhoModel? vendaCabecalhoModel}) {
		return {
			"id": PlutoCell(value: vendaCabecalhoModel?.id ?? 0),
			"vendaOrcamentoCabecalho": PlutoCell(value: vendaCabecalhoModel?.vendaOrcamentoCabecalhoModel?.codigo ?? ''),
			"notaFiscalTipo": PlutoCell(value: vendaCabecalhoModel?.notaFiscalTipoModel?.nome ?? ''),
			"viewPessoaVendedor": PlutoCell(value: vendaCabecalhoModel?.viewPessoaVendedorModel?.nome ?? ''),
			"vendaCondicoesPagamento": PlutoCell(value: vendaCabecalhoModel?.vendaCondicoesPagamentoModel?.nome ?? ''),
			"viewPessoaTransportadora": PlutoCell(value: vendaCabecalhoModel?.viewPessoaTransportadoraModel?.nome ?? ''),
			"viewPessoaCliente": PlutoCell(value: vendaCabecalhoModel?.viewPessoaClienteModel?.nome ?? ''),
			"localEntrega": PlutoCell(value: vendaCabecalhoModel?.localEntrega ?? ''),
			"localCobranca": PlutoCell(value: vendaCabecalhoModel?.localCobranca ?? ''),
			"tipoFrete": PlutoCell(value: vendaCabecalhoModel?.tipoFrete ?? ''),
			"formaPagamento": PlutoCell(value: vendaCabecalhoModel?.formaPagamento ?? ''),
			"dataVenda": PlutoCell(value: vendaCabecalhoModel?.dataVenda ?? ''),
			"dataSaida": PlutoCell(value: vendaCabecalhoModel?.dataSaida ?? ''),
			"horaSaida": PlutoCell(value: vendaCabecalhoModel?.horaSaida ?? ''),
			"numeroFatura": PlutoCell(value: vendaCabecalhoModel?.numeroFatura ?? 0),
			"valorFrete": PlutoCell(value: vendaCabecalhoModel?.valorFrete ?? 0),
			"valorSeguro": PlutoCell(value: vendaCabecalhoModel?.valorSeguro ?? 0),
			"valorSubtotal": PlutoCell(value: vendaCabecalhoModel?.valorSubtotal ?? 0),
			"taxaComissao": PlutoCell(value: vendaCabecalhoModel?.taxaComissao ?? 0),
			"valorComissao": PlutoCell(value: vendaCabecalhoModel?.valorComissao ?? 0),
			"taxaDesconto": PlutoCell(value: vendaCabecalhoModel?.taxaDesconto ?? 0),
			"valorDesconto": PlutoCell(value: vendaCabecalhoModel?.valorDesconto ?? 0),
			"valorTotal": PlutoCell(value: vendaCabecalhoModel?.valorTotal ?? 0),
			"situacao": PlutoCell(value: vendaCabecalhoModel?.situacao ?? ''),
			"diaFixoParcela": PlutoCell(value: vendaCabecalhoModel?.diaFixoParcela ?? ''),
			"observacao": PlutoCell(value: vendaCabecalhoModel?.observacao ?? ''),
			"idVendaOrcamentoCabecalho": PlutoCell(value: vendaCabecalhoModel?.idVendaOrcamentoCabecalho ?? 0),
			"idNotaFiscalTipo": PlutoCell(value: vendaCabecalhoModel?.idNotaFiscalTipo ?? 0),
			"idVendedor": PlutoCell(value: vendaCabecalhoModel?.idVendedor ?? 0),
			"idVendaCondicoesPagamento": PlutoCell(value: vendaCabecalhoModel?.idVendaCondicoesPagamento ?? 0),
			"idTransportadora": PlutoCell(value: vendaCabecalhoModel?.idTransportadora ?? 0),
			"idCliente": PlutoCell(value: vendaCabecalhoModel?.idCliente ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _vendaCabecalhoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			vendaCabecalhoModel.plutoRowToObject(plutoRow);
		} else {
			vendaCabecalhoModel = modelFromRow[0];
			_vendaCabecalhoModelOld = vendaCabecalhoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Venda]';
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
		await Get.find<VendaCabecalhoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await vendaCabecalhoRepository.getList(filter: filter).then( (data){ _vendaCabecalhoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Venda',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			vendaOrcamentoCabecalhoModelController.text = currentRow.cells['vendaOrcamentoCabecalho']?.value ?? '';
			notaFiscalTipoModelController.text = currentRow.cells['notaFiscalTipo']?.value ?? '';
			viewPessoaVendedorModelController.text = currentRow.cells['viewPessoaVendedor']?.value ?? '';
			vendaCondicoesPagamentoModelController.text = currentRow.cells['vendaCondicoesPagamento']?.value ?? '';
			viewPessoaTransportadoraModelController.text = currentRow.cells['viewPessoaTransportadora']?.value ?? '';
			viewPessoaClienteModelController.text = currentRow.cells['viewPessoaCliente']?.value ?? '';
			localEntregaController.text = currentRow.cells['localEntrega']?.value ?? '';
			localCobrancaController.text = currentRow.cells['localCobranca']?.value ?? '';
			horaSaidaController.text = currentRow.cells['horaSaida']?.value ?? '';
			numeroFaturaController.text = currentRow.cells['numeroFatura']?.value?.toString() ?? '';
			valorFreteController.text = currentRow.cells['valorFrete']?.value?.toStringAsFixed(2) ?? '';
			valorSeguroController.text = currentRow.cells['valorSeguro']?.value?.toStringAsFixed(2) ?? '';
			valorSubtotalController.text = currentRow.cells['valorSubtotal']?.value?.toStringAsFixed(2) ?? '';
			taxaComissaoController.text = currentRow.cells['taxaComissao']?.value?.toStringAsFixed(2) ?? '';
			valorComissaoController.text = currentRow.cells['valorComissao']?.value?.toStringAsFixed(2) ?? '';
			taxaDescontoController.text = currentRow.cells['taxaDesconto']?.value?.toStringAsFixed(2) ?? '';
			valorDescontoController.text = currentRow.cells['valorDesconto']?.value?.toStringAsFixed(2) ?? '';
			valorTotalController.text = currentRow.cells['valorTotal']?.value?.toStringAsFixed(2) ?? '';
			diaFixoParcelaController.text = currentRow.cells['diaFixoParcela']?.value ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Comissão
			Get.put<VendaComissaoController>(VendaComissaoController()); 
			final vendaComissaoController = Get.find<VendaComissaoController>(); 
			vendaComissaoController.vendaComissaoModel = vendaCabecalhoModel.vendaComissaoModel; 
			vendaComissaoController.formWasChanged = false; 
			vendaComissaoController.callEditPage(); 

			//Itens da Venda
			Get.put<VendaDetalheController>(VendaDetalheController()); 
			final vendaDetalheController = Get.find<VendaDetalheController>(); 
			vendaDetalheController.vendaDetalheModelList = vendaCabecalhoModel.vendaDetalheModelList!; 
			vendaDetalheController.userMadeChanges = false; 

			//Frete
			Get.put<VendaFreteController>(VendaFreteController()); 
			final vendaFreteController = Get.find<VendaFreteController>(); 
			vendaFreteController.vendaFreteModelList = vendaCabecalhoModel.vendaFreteModelList!; 
			vendaFreteController.userMadeChanges = false; 


			Get.toNamed(Routes.vendaCabecalhoTabPage)!.then((value) {
				if (vendaCabecalhoModel.id == 0) {
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
		vendaCabecalhoModel = VendaCabecalhoModel();
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
				if (await vendaCabecalhoRepository.delete(id: currentRow.cells['id']!.value)) {
					_vendaCabecalhoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final vendaOrcamentoCabecalhoModelController = TextEditingController();
	final notaFiscalTipoModelController = TextEditingController();
	final viewPessoaVendedorModelController = TextEditingController();
	final vendaCondicoesPagamentoModelController = TextEditingController();
	final viewPessoaTransportadoraModelController = TextEditingController();
	final viewPessoaClienteModelController = TextEditingController();
	final localEntregaController = TextEditingController();
	final localCobrancaController = TextEditingController();
	final horaSaidaController = MaskedTextController(mask: '00:00:00',);
	final numeroFaturaController = TextEditingController();
	final valorFreteController = MoneyMaskedTextController();
	final valorSeguroController = MoneyMaskedTextController();
	final valorSubtotalController = MoneyMaskedTextController();
	final taxaComissaoController = MoneyMaskedTextController();
	final valorComissaoController = MoneyMaskedTextController();
	final taxaDescontoController = MoneyMaskedTextController();
	final valorDescontoController = MoneyMaskedTextController();
	final valorTotalController = MoneyMaskedTextController();
	final diaFixoParcelaController = TextEditingController();
	final observacaoController = TextEditingController();

	final vendaCabecalhoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final vendaCabecalhoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final vendaCabecalhoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = vendaCabecalhoModel.id;
		plutoRow.cells['idVendaOrcamentoCabecalho']?.value = vendaCabecalhoModel.idVendaOrcamentoCabecalho;
		plutoRow.cells['vendaOrcamentoCabecalho']?.value = vendaCabecalhoModel.vendaOrcamentoCabecalhoModel?.codigo;
		plutoRow.cells['idNotaFiscalTipo']?.value = vendaCabecalhoModel.idNotaFiscalTipo;
		plutoRow.cells['notaFiscalTipo']?.value = vendaCabecalhoModel.notaFiscalTipoModel?.nome;
		plutoRow.cells['idVendedor']?.value = vendaCabecalhoModel.idVendedor;
		plutoRow.cells['viewPessoaVendedor']?.value = vendaCabecalhoModel.viewPessoaVendedorModel?.nome;
		plutoRow.cells['idVendaCondicoesPagamento']?.value = vendaCabecalhoModel.idVendaCondicoesPagamento;
		plutoRow.cells['vendaCondicoesPagamento']?.value = vendaCabecalhoModel.vendaCondicoesPagamentoModel?.nome;
		plutoRow.cells['idTransportadora']?.value = vendaCabecalhoModel.idTransportadora;
		plutoRow.cells['viewPessoaTransportadora']?.value = vendaCabecalhoModel.viewPessoaTransportadoraModel?.nome;
		plutoRow.cells['idCliente']?.value = vendaCabecalhoModel.idCliente;
		plutoRow.cells['viewPessoaCliente']?.value = vendaCabecalhoModel.viewPessoaClienteModel?.nome;
		plutoRow.cells['localEntrega']?.value = vendaCabecalhoModel.localEntrega;
		plutoRow.cells['localCobranca']?.value = vendaCabecalhoModel.localCobranca;
		plutoRow.cells['tipoFrete']?.value = vendaCabecalhoModel.tipoFrete;
		plutoRow.cells['formaPagamento']?.value = vendaCabecalhoModel.formaPagamento;
		plutoRow.cells['dataVenda']?.value = Util.formatDate(vendaCabecalhoModel.dataVenda);
		plutoRow.cells['dataSaida']?.value = Util.formatDate(vendaCabecalhoModel.dataSaida);
		plutoRow.cells['horaSaida']?.value = vendaCabecalhoModel.horaSaida;
		plutoRow.cells['numeroFatura']?.value = vendaCabecalhoModel.numeroFatura;
		plutoRow.cells['valorFrete']?.value = vendaCabecalhoModel.valorFrete;
		plutoRow.cells['valorSeguro']?.value = vendaCabecalhoModel.valorSeguro;
		plutoRow.cells['valorSubtotal']?.value = vendaCabecalhoModel.valorSubtotal;
		plutoRow.cells['taxaComissao']?.value = vendaCabecalhoModel.taxaComissao;
		plutoRow.cells['valorComissao']?.value = vendaCabecalhoModel.valorComissao;
		plutoRow.cells['taxaDesconto']?.value = vendaCabecalhoModel.taxaDesconto;
		plutoRow.cells['valorDesconto']?.value = vendaCabecalhoModel.valorDesconto;
		plutoRow.cells['valorTotal']?.value = vendaCabecalhoModel.valorTotal;
		plutoRow.cells['situacao']?.value = vendaCabecalhoModel.situacao;
		plutoRow.cells['diaFixoParcela']?.value = vendaCabecalhoModel.diaFixoParcela;
		plutoRow.cells['observacao']?.value = vendaCabecalhoModel.observacao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await vendaCabecalhoRepository.save(vendaCabecalhoModel: vendaCabecalhoModel); 
				if (result != null) {
					vendaCabecalhoModel = result;
					if (_isInserting) {
						_vendaCabecalhoModelList.add(vendaCabecalhoModel);
						_isInserting = false;
					} else {
            _vendaCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _vendaCabecalhoModelList.add(vendaCabecalhoModel);
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
		Get.find<VendaComissaoController>().formWasChanged
		|| 
		Get.find<VendaDetalheController>().userMadeChanges
		|| 
		Get.find<VendaFreteController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_vendaCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_vendaCabecalhoModelList.add(_vendaCabecalhoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(vendaCabecalhoModel.notaFiscalTipoModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Tipo Nota Fiscal]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(vendaCabecalhoModel.viewPessoaVendedorModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Vendedor]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(vendaCabecalhoModel.vendaCondicoesPagamentoModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Condicoes Pagamento]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(vendaCabecalhoModel.viewPessoaTransportadoraModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Transportadora]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(vendaCabecalhoModel.viewPessoaClienteModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Cliente]'); 
			return false; 
		}
		final resultVendaComissao = Get.find<VendaComissaoController>().validateForm(); 
		if (!resultVendaComissao) { 
			return false; 
		}
		return true;
	}

	Future callVendaOrcamentoCabecalhoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Orçamento]'; 
		lookupController.route = '/venda-orcamento-cabecalho/'; 
		lookupController.gridColumns = vendaOrcamentoCabecalhoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = VendaOrcamentoCabecalhoModel.aliasColumns; 
		lookupController.dbColumns = VendaOrcamentoCabecalhoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			vendaCabecalhoModel.idVendaOrcamentoCabecalho = plutoRowResult.cells['id']!.value; 
			vendaCabecalhoModel.vendaOrcamentoCabecalhoModel!.plutoRowToObject(plutoRowResult); 
			vendaOrcamentoCabecalhoModelController.text = vendaCabecalhoModel.vendaOrcamentoCabecalhoModel?.codigo ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callNotaFiscalTipoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tipo Nota Fiscal]'; 
		lookupController.route = '/nota-fiscal-tipo/'; 
		lookupController.gridColumns = notaFiscalTipoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = NotaFiscalTipoModel.aliasColumns; 
		lookupController.dbColumns = NotaFiscalTipoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			vendaCabecalhoModel.idNotaFiscalTipo = plutoRowResult.cells['id']!.value; 
			vendaCabecalhoModel.notaFiscalTipoModel!.plutoRowToObject(plutoRowResult); 
			notaFiscalTipoModelController.text = vendaCabecalhoModel.notaFiscalTipoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
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
			vendaCabecalhoModel.idVendedor = plutoRowResult.cells['id']!.value; 
			vendaCabecalhoModel.viewPessoaVendedorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaVendedorModelController.text = vendaCabecalhoModel.viewPessoaVendedorModel?.nome ?? ''; 
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
			vendaCabecalhoModel.idVendaCondicoesPagamento = plutoRowResult.cells['id']!.value; 
			vendaCabecalhoModel.vendaCondicoesPagamentoModel!.plutoRowToObject(plutoRowResult); 
			vendaCondicoesPagamentoModelController.text = vendaCabecalhoModel.vendaCondicoesPagamentoModel?.nome ?? ''; 
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
			vendaCabecalhoModel.idTransportadora = plutoRowResult.cells['id']!.value; 
			vendaCabecalhoModel.viewPessoaTransportadoraModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaTransportadoraModelController.text = vendaCabecalhoModel.viewPessoaTransportadoraModel?.nome ?? ''; 
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
			vendaCabecalhoModel.idCliente = plutoRowResult.cells['id']!.value; 
			vendaCabecalhoModel.viewPessoaClienteModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaClienteModelController.text = vendaCabecalhoModel.viewPessoaClienteModel?.nome ?? ''; 
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
		functionName = "venda_cabecalho";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		vendaOrcamentoCabecalhoModelController.dispose();
		notaFiscalTipoModelController.dispose();
		viewPessoaVendedorModelController.dispose();
		vendaCondicoesPagamentoModelController.dispose();
		viewPessoaTransportadoraModelController.dispose();
		viewPessoaClienteModelController.dispose();
		localEntregaController.dispose();
		localCobrancaController.dispose();
		horaSaidaController.dispose();
		numeroFaturaController.dispose();
		valorFreteController.dispose();
		valorSeguroController.dispose();
		valorSubtotalController.dispose();
		taxaComissaoController.dispose();
		valorComissaoController.dispose();
		taxaDescontoController.dispose();
		valorDescontoController.dispose();
		valorTotalController.dispose();
		diaFixoParcelaController.dispose();
		observacaoController.dispose();
		super.onClose();
	}
}