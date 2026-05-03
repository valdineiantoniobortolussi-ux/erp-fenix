import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/controller/controller_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/page/grid_columns/grid_columns_imports.dart';
import 'package:nfe/app/page/page_imports.dart';

import 'package:nfe/app/routes/app_routes.dart';
import 'package:nfe/app/data/repository/nfe_detalhe_repository.dart';
import 'package:nfe/app/page/shared_page/shared_page_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';
import 'package:nfe/app/mixin/controller_base_mixin.dart';

class NfeDetalheController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final NfeDetalheRepository nfeDetalheRepository;
	NfeDetalheController({required this.nfeDetalheRepository});

	// general
	final _dbColumns = NfeDetalheModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = NfeDetalheModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = nfeDetalheGridColumns();
	
	var _nfeDetalheModelList = <NfeDetalheModel>[];

	var _nfeDetalheModelOld = NfeDetalheModel();

	final _nfeDetalheModel = NfeDetalheModel().obs;
	NfeDetalheModel get nfeDetalheModel => _nfeDetalheModel.value;
	set nfeDetalheModel(value) => _nfeDetalheModel.value = value ?? NfeDetalheModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Itens da Nota', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Veículo', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Medicamento', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Armamento', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Combustível', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Declaração Importação', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'ICMS', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'IPI', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Imposto Importação', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'PIS', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'COFINS', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'ISSQN', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Exportacao', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Item Rastreado', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'PIS ST', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'ICMS UF Destinatário', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'COFINS ST', 
		),
	];

	List<Widget> tabPages() {
		return [
			NfeDetalheEditPage(),
			const NfeDetEspecificoVeiculoListPage(),
			const NfeDetEspecificoMedicamentoListPage(),
			const NfeDetEspecificoArmamentoListPage(),
			const NfeDetEspecificoCombustivelListPage(),
			const NfeDeclaracaoImportacaoListPage(),
			const NfeDetalheImpostoIcmsListPage(),
			const NfeDetalheImpostoIpiListPage(),
			const NfeDetalheImpostoIiListPage(),
			const NfeDetalheImpostoPisListPage(),
			const NfeDetalheImpostoCofinsListPage(),
			const NfeDetalheImpostoIssqnListPage(),
			const NfeExportacaoListPage(),
			const NfeItemRastreadoListPage(),
			const NfeDetalheImpostoPisStListPage(),
			const NfeDetalheImpostoIcmsUfdestListPage(),
			const NfeDetalheImpostoCofinsStListPage(),
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
		for (var nfeDetalheModel in _nfeDetalheModelList) {
			plutoRowList.add(_getPlutoRow(nfeDetalheModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeDetalheModel nfeDetalheModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeDetalheModel: nfeDetalheModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeDetalheModel? nfeDetalheModel}) {
		return {
			"id": PlutoCell(value: nfeDetalheModel?.id ?? 0),
			"nfeCabecalho": PlutoCell(value: nfeDetalheModel?.nfeCabecalhoModel?.numero ?? ''),
			"produto": PlutoCell(value: nfeDetalheModel?.produtoModel?.nome ?? ''),
			"numeroItem": PlutoCell(value: nfeDetalheModel?.numeroItem ?? 0),
			"codigoProduto": PlutoCell(value: nfeDetalheModel?.codigoProduto ?? ''),
			"gtin": PlutoCell(value: nfeDetalheModel?.gtin ?? ''),
			"nomeProduto": PlutoCell(value: nfeDetalheModel?.nomeProduto ?? ''),
			"ncm": PlutoCell(value: nfeDetalheModel?.ncm ?? ''),
			"nve": PlutoCell(value: nfeDetalheModel?.nve ?? ''),
			"cest": PlutoCell(value: nfeDetalheModel?.cest ?? ''),
			"indicadorEscalaRelevante": PlutoCell(value: nfeDetalheModel?.indicadorEscalaRelevante ?? ''),
			"cnpjFabricante": PlutoCell(value: nfeDetalheModel?.cnpjFabricante ?? ''),
			"codigoBeneficioFiscal": PlutoCell(value: nfeDetalheModel?.codigoBeneficioFiscal ?? ''),
			"exTipi": PlutoCell(value: nfeDetalheModel?.exTipi ?? 0),
			"cfop": PlutoCell(value: nfeDetalheModel?.cfop ?? 0),
			"unidadeComercial": PlutoCell(value: nfeDetalheModel?.unidadeComercial ?? ''),
			"quantidadeComercial": PlutoCell(value: nfeDetalheModel?.quantidadeComercial ?? 0),
			"numeroPedidoCompra": PlutoCell(value: nfeDetalheModel?.numeroPedidoCompra ?? ''),
			"itemPedidoCompra": PlutoCell(value: nfeDetalheModel?.itemPedidoCompra ?? 0),
			"numeroFci": PlutoCell(value: nfeDetalheModel?.numeroFci ?? ''),
			"numeroRecopi": PlutoCell(value: nfeDetalheModel?.numeroRecopi ?? ''),
			"valorUnitarioComercial": PlutoCell(value: nfeDetalheModel?.valorUnitarioComercial ?? 0),
			"valorBrutoProduto": PlutoCell(value: nfeDetalheModel?.valorBrutoProduto ?? 0),
			"gtinUnidadeTributavel": PlutoCell(value: nfeDetalheModel?.gtinUnidadeTributavel ?? ''),
			"unidadeTributavel": PlutoCell(value: nfeDetalheModel?.unidadeTributavel ?? ''),
			"quantidadeTributavel": PlutoCell(value: nfeDetalheModel?.quantidadeTributavel ?? 0),
			"valorUnitarioTributavel": PlutoCell(value: nfeDetalheModel?.valorUnitarioTributavel ?? 0),
			"valorFrete": PlutoCell(value: nfeDetalheModel?.valorFrete ?? 0),
			"valorSeguro": PlutoCell(value: nfeDetalheModel?.valorSeguro ?? 0),
			"valorDesconto": PlutoCell(value: nfeDetalheModel?.valorDesconto ?? 0),
			"valorOutrasDespesas": PlutoCell(value: nfeDetalheModel?.valorOutrasDespesas ?? 0),
			"entraTotal": PlutoCell(value: nfeDetalheModel?.entraTotal ?? ''),
			"valorTotalTributos": PlutoCell(value: nfeDetalheModel?.valorTotalTributos ?? 0),
			"percentualDevolvido": PlutoCell(value: nfeDetalheModel?.percentualDevolvido ?? 0),
			"valorIpiDevolvido": PlutoCell(value: nfeDetalheModel?.valorIpiDevolvido ?? 0),
			"informacoesAdicionais": PlutoCell(value: nfeDetalheModel?.informacoesAdicionais ?? ''),
			"valorSubtotal": PlutoCell(value: nfeDetalheModel?.valorSubtotal ?? 0),
			"valorTotal": PlutoCell(value: nfeDetalheModel?.valorTotal ?? 0),
			"idNfeCabecalho": PlutoCell(value: nfeDetalheModel?.idNfeCabecalho ?? 0),
			"idProduto": PlutoCell(value: nfeDetalheModel?.idProduto ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _nfeDetalheModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			nfeDetalheModel.plutoRowToObject(plutoRow);
		} else {
			nfeDetalheModel = modelFromRow[0];
			_nfeDetalheModelOld = nfeDetalheModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Itens da Nota]';
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
		await Get.find<NfeDetalheController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await nfeDetalheRepository.getList(filter: filter).then( (data){ _nfeDetalheModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Itens da Nota',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			nfeCabecalhoModelController.text = currentRow.cells['nfeCabecalho']?.value ?? '';
			produtoModelController.text = currentRow.cells['produto']?.value ?? '';
			numeroItemController.text = currentRow.cells['numeroItem']?.value?.toString() ?? '';
			codigoProdutoController.text = currentRow.cells['codigoProduto']?.value ?? '';
			gtinController.text = currentRow.cells['gtin']?.value ?? '';
			nomeProdutoController.text = currentRow.cells['nomeProduto']?.value ?? '';
			ncmController.text = currentRow.cells['ncm']?.value ?? '';
			nveController.text = currentRow.cells['nve']?.value ?? '';
			cestController.text = currentRow.cells['cest']?.value ?? '';
			cnpjFabricanteController.text = currentRow.cells['cnpjFabricante']?.value ?? '';
			codigoBeneficioFiscalController.text = currentRow.cells['codigoBeneficioFiscal']?.value ?? '';
			exTipiController.text = currentRow.cells['exTipi']?.value?.toString() ?? '';
			cfopController.text = currentRow.cells['cfop']?.value?.toString() ?? '';
			unidadeComercialController.text = currentRow.cells['unidadeComercial']?.value ?? '';
			quantidadeComercialController.text = currentRow.cells['quantidadeComercial']?.value?.toStringAsFixed(2) ?? '';
			numeroPedidoCompraController.text = currentRow.cells['numeroPedidoCompra']?.value ?? '';
			itemPedidoCompraController.text = currentRow.cells['itemPedidoCompra']?.value?.toString() ?? '';
			numeroFciController.text = currentRow.cells['numeroFci']?.value ?? '';
			numeroRecopiController.text = currentRow.cells['numeroRecopi']?.value ?? '';
			valorUnitarioComercialController.text = currentRow.cells['valorUnitarioComercial']?.value?.toStringAsFixed(2) ?? '';
			valorBrutoProdutoController.text = currentRow.cells['valorBrutoProduto']?.value?.toStringAsFixed(2) ?? '';
			gtinUnidadeTributavelController.text = currentRow.cells['gtinUnidadeTributavel']?.value ?? '';
			unidadeTributavelController.text = currentRow.cells['unidadeTributavel']?.value ?? '';
			quantidadeTributavelController.text = currentRow.cells['quantidadeTributavel']?.value?.toStringAsFixed(2) ?? '';
			valorUnitarioTributavelController.text = currentRow.cells['valorUnitarioTributavel']?.value?.toStringAsFixed(2) ?? '';
			valorFreteController.text = currentRow.cells['valorFrete']?.value?.toStringAsFixed(2) ?? '';
			valorSeguroController.text = currentRow.cells['valorSeguro']?.value?.toStringAsFixed(2) ?? '';
			valorDescontoController.text = currentRow.cells['valorDesconto']?.value?.toStringAsFixed(2) ?? '';
			valorOutrasDespesasController.text = currentRow.cells['valorOutrasDespesas']?.value?.toStringAsFixed(2) ?? '';
			valorTotalTributosController.text = currentRow.cells['valorTotalTributos']?.value?.toStringAsFixed(2) ?? '';
			percentualDevolvidoController.text = currentRow.cells['percentualDevolvido']?.value?.toStringAsFixed(2) ?? '';
			valorIpiDevolvidoController.text = currentRow.cells['valorIpiDevolvido']?.value?.toStringAsFixed(2) ?? '';
			informacoesAdicionaisController.text = currentRow.cells['informacoesAdicionais']?.value ?? '';
			valorSubtotalController.text = currentRow.cells['valorSubtotal']?.value?.toStringAsFixed(2) ?? '';
			valorTotalController.text = currentRow.cells['valorTotal']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Veículo
			Get.put<NfeDetEspecificoVeiculoController>(NfeDetEspecificoVeiculoController()); 
			final nfeDetEspecificoVeiculoController = Get.find<NfeDetEspecificoVeiculoController>(); 
			nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModelList = nfeDetalheModel.nfeDetEspecificoVeiculoModelList!; 
			nfeDetEspecificoVeiculoController.userMadeChanges = false; 

			//Medicamento
			Get.put<NfeDetEspecificoMedicamentoController>(NfeDetEspecificoMedicamentoController()); 
			final nfeDetEspecificoMedicamentoController = Get.find<NfeDetEspecificoMedicamentoController>(); 
			nfeDetEspecificoMedicamentoController.nfeDetEspecificoMedicamentoModelList = nfeDetalheModel.nfeDetEspecificoMedicamentoModelList!; 
			nfeDetEspecificoMedicamentoController.userMadeChanges = false; 

			//Armamento
			Get.put<NfeDetEspecificoArmamentoController>(NfeDetEspecificoArmamentoController()); 
			final nfeDetEspecificoArmamentoController = Get.find<NfeDetEspecificoArmamentoController>(); 
			nfeDetEspecificoArmamentoController.nfeDetEspecificoArmamentoModelList = nfeDetalheModel.nfeDetEspecificoArmamentoModelList!; 
			nfeDetEspecificoArmamentoController.userMadeChanges = false; 

			//Combustível
			Get.put<NfeDetEspecificoCombustivelController>(NfeDetEspecificoCombustivelController()); 
			final nfeDetEspecificoCombustivelController = Get.find<NfeDetEspecificoCombustivelController>(); 
			nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModelList = nfeDetalheModel.nfeDetEspecificoCombustivelModelList!; 
			nfeDetEspecificoCombustivelController.userMadeChanges = false; 

			//Declaração Importação
			Get.put<NfeDeclaracaoImportacaoController>(NfeDeclaracaoImportacaoController()); 
			final nfeDeclaracaoImportacaoController = Get.find<NfeDeclaracaoImportacaoController>(); 
			nfeDeclaracaoImportacaoController.nfeDeclaracaoImportacaoModelList = nfeDetalheModel.nfeDeclaracaoImportacaoModelList!; 
			nfeDeclaracaoImportacaoController.userMadeChanges = false; 

			//ICMS
			Get.put<NfeDetalheImpostoIcmsController>(NfeDetalheImpostoIcmsController()); 
			final nfeDetalheImpostoIcmsController = Get.find<NfeDetalheImpostoIcmsController>(); 
			nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModelList = nfeDetalheModel.nfeDetalheImpostoIcmsModelList!; 
			nfeDetalheImpostoIcmsController.userMadeChanges = false; 

			//IPI
			Get.put<NfeDetalheImpostoIpiController>(NfeDetalheImpostoIpiController()); 
			final nfeDetalheImpostoIpiController = Get.find<NfeDetalheImpostoIpiController>(); 
			nfeDetalheImpostoIpiController.nfeDetalheImpostoIpiModelList = nfeDetalheModel.nfeDetalheImpostoIpiModelList!; 
			nfeDetalheImpostoIpiController.userMadeChanges = false; 

			//Imposto Importação
			Get.put<NfeDetalheImpostoIiController>(NfeDetalheImpostoIiController()); 
			final nfeDetalheImpostoIiController = Get.find<NfeDetalheImpostoIiController>(); 
			nfeDetalheImpostoIiController.nfeDetalheImpostoIiModelList = nfeDetalheModel.nfeDetalheImpostoIiModelList!; 
			nfeDetalheImpostoIiController.userMadeChanges = false; 

			//PIS
			Get.put<NfeDetalheImpostoPisController>(NfeDetalheImpostoPisController()); 
			final nfeDetalheImpostoPisController = Get.find<NfeDetalheImpostoPisController>(); 
			nfeDetalheImpostoPisController.nfeDetalheImpostoPisModelList = nfeDetalheModel.nfeDetalheImpostoPisModelList!; 
			nfeDetalheImpostoPisController.userMadeChanges = false; 

			//COFINS
			Get.put<NfeDetalheImpostoCofinsController>(NfeDetalheImpostoCofinsController()); 
			final nfeDetalheImpostoCofinsController = Get.find<NfeDetalheImpostoCofinsController>(); 
			nfeDetalheImpostoCofinsController.nfeDetalheImpostoCofinsModelList = nfeDetalheModel.nfeDetalheImpostoCofinsModelList!; 
			nfeDetalheImpostoCofinsController.userMadeChanges = false; 

			//ISSQN
			Get.put<NfeDetalheImpostoIssqnController>(NfeDetalheImpostoIssqnController()); 
			final nfeDetalheImpostoIssqnController = Get.find<NfeDetalheImpostoIssqnController>(); 
			nfeDetalheImpostoIssqnController.nfeDetalheImpostoIssqnModelList = nfeDetalheModel.nfeDetalheImpostoIssqnModelList!; 
			nfeDetalheImpostoIssqnController.userMadeChanges = false; 

			//Exportacao
			Get.put<NfeExportacaoController>(NfeExportacaoController()); 
			final nfeExportacaoController = Get.find<NfeExportacaoController>(); 
			nfeExportacaoController.nfeExportacaoModelList = nfeDetalheModel.nfeExportacaoModelList!; 
			nfeExportacaoController.userMadeChanges = false; 

			//Item Rastreado
			Get.put<NfeItemRastreadoController>(NfeItemRastreadoController()); 
			final nfeItemRastreadoController = Get.find<NfeItemRastreadoController>(); 
			nfeItemRastreadoController.nfeItemRastreadoModelList = nfeDetalheModel.nfeItemRastreadoModelList!; 
			nfeItemRastreadoController.userMadeChanges = false; 

			//PIS ST
			Get.put<NfeDetalheImpostoPisStController>(NfeDetalheImpostoPisStController()); 
			final nfeDetalheImpostoPisStController = Get.find<NfeDetalheImpostoPisStController>(); 
			nfeDetalheImpostoPisStController.nfeDetalheImpostoPisStModelList = nfeDetalheModel.nfeDetalheImpostoPisStModelList!; 
			nfeDetalheImpostoPisStController.userMadeChanges = false; 

			//ICMS UF Destinatário
			Get.put<NfeDetalheImpostoIcmsUfdestController>(NfeDetalheImpostoIcmsUfdestController()); 
			final nfeDetalheImpostoIcmsUfdestController = Get.find<NfeDetalheImpostoIcmsUfdestController>(); 
			nfeDetalheImpostoIcmsUfdestController.nfeDetalheImpostoIcmsUfdestModelList = nfeDetalheModel.nfeDetalheImpostoIcmsUfdestModelList!; 
			nfeDetalheImpostoIcmsUfdestController.userMadeChanges = false; 

			//COFINS ST
			Get.put<NfeDetalheImpostoCofinsStController>(NfeDetalheImpostoCofinsStController()); 
			final nfeDetalheImpostoCofinsStController = Get.find<NfeDetalheImpostoCofinsStController>(); 
			nfeDetalheImpostoCofinsStController.nfeDetalheImpostoCofinsStModelList = nfeDetalheModel.nfeDetalheImpostoCofinsStModelList!; 
			nfeDetalheImpostoCofinsStController.userMadeChanges = false; 


			Get.toNamed(Routes.nfeDetalheTabPage)!.then((value) {
				if (nfeDetalheModel.id == 0) {
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
		nfeDetalheModel = NfeDetalheModel();
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
				if (await nfeDetalheRepository.delete(id: currentRow.cells['id']!.value)) {
					_nfeDetalheModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nfeCabecalhoModelController = TextEditingController();
	final produtoModelController = TextEditingController();
	final numeroItemController = TextEditingController();
	final codigoProdutoController = TextEditingController();
	final gtinController = TextEditingController();
	final nomeProdutoController = TextEditingController();
	final ncmController = TextEditingController();
	final nveController = TextEditingController();
	final cestController = TextEditingController();
	final cnpjFabricanteController = MaskedTextController(mask: '00.000.000/0000-00',);
	final codigoBeneficioFiscalController = TextEditingController();
	final exTipiController = TextEditingController();
	final cfopController = TextEditingController();
	final unidadeComercialController = TextEditingController();
	final quantidadeComercialController = MoneyMaskedTextController();
	final numeroPedidoCompraController = TextEditingController();
	final itemPedidoCompraController = TextEditingController();
	final numeroFciController = TextEditingController();
	final numeroRecopiController = TextEditingController();
	final valorUnitarioComercialController = MoneyMaskedTextController();
	final valorBrutoProdutoController = MoneyMaskedTextController();
	final gtinUnidadeTributavelController = TextEditingController();
	final unidadeTributavelController = TextEditingController();
	final quantidadeTributavelController = MoneyMaskedTextController();
	final valorUnitarioTributavelController = MoneyMaskedTextController();
	final valorFreteController = MoneyMaskedTextController();
	final valorSeguroController = MoneyMaskedTextController();
	final valorDescontoController = MoneyMaskedTextController();
	final valorOutrasDespesasController = MoneyMaskedTextController();
	final valorTotalTributosController = MoneyMaskedTextController();
	final percentualDevolvidoController = MoneyMaskedTextController();
	final valorIpiDevolvidoController = MoneyMaskedTextController();
	final informacoesAdicionaisController = TextEditingController();
	final valorSubtotalController = MoneyMaskedTextController();
	final valorTotalController = MoneyMaskedTextController();

	final nfeDetalheTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final nfeDetalheEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final nfeDetalheEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeDetalheModel.id;
		plutoRow.cells['idNfeCabecalho']?.value = nfeDetalheModel.idNfeCabecalho;
		plutoRow.cells['nfeCabecalho']?.value = nfeDetalheModel.nfeCabecalhoModel?.numero;
		plutoRow.cells['idProduto']?.value = nfeDetalheModel.idProduto;
		plutoRow.cells['produto']?.value = nfeDetalheModel.produtoModel?.nome;
		plutoRow.cells['numeroItem']?.value = nfeDetalheModel.numeroItem;
		plutoRow.cells['codigoProduto']?.value = nfeDetalheModel.codigoProduto;
		plutoRow.cells['gtin']?.value = nfeDetalheModel.gtin;
		plutoRow.cells['nomeProduto']?.value = nfeDetalheModel.nomeProduto;
		plutoRow.cells['ncm']?.value = nfeDetalheModel.ncm;
		plutoRow.cells['nve']?.value = nfeDetalheModel.nve;
		plutoRow.cells['cest']?.value = nfeDetalheModel.cest;
		plutoRow.cells['indicadorEscalaRelevante']?.value = nfeDetalheModel.indicadorEscalaRelevante;
		plutoRow.cells['cnpjFabricante']?.value = nfeDetalheModel.cnpjFabricante;
		plutoRow.cells['codigoBeneficioFiscal']?.value = nfeDetalheModel.codigoBeneficioFiscal;
		plutoRow.cells['exTipi']?.value = nfeDetalheModel.exTipi;
		plutoRow.cells['cfop']?.value = nfeDetalheModel.cfop;
		plutoRow.cells['unidadeComercial']?.value = nfeDetalheModel.unidadeComercial;
		plutoRow.cells['quantidadeComercial']?.value = nfeDetalheModel.quantidadeComercial;
		plutoRow.cells['numeroPedidoCompra']?.value = nfeDetalheModel.numeroPedidoCompra;
		plutoRow.cells['itemPedidoCompra']?.value = nfeDetalheModel.itemPedidoCompra;
		plutoRow.cells['numeroFci']?.value = nfeDetalheModel.numeroFci;
		plutoRow.cells['numeroRecopi']?.value = nfeDetalheModel.numeroRecopi;
		plutoRow.cells['valorUnitarioComercial']?.value = nfeDetalheModel.valorUnitarioComercial;
		plutoRow.cells['valorBrutoProduto']?.value = nfeDetalheModel.valorBrutoProduto;
		plutoRow.cells['gtinUnidadeTributavel']?.value = nfeDetalheModel.gtinUnidadeTributavel;
		plutoRow.cells['unidadeTributavel']?.value = nfeDetalheModel.unidadeTributavel;
		plutoRow.cells['quantidadeTributavel']?.value = nfeDetalheModel.quantidadeTributavel;
		plutoRow.cells['valorUnitarioTributavel']?.value = nfeDetalheModel.valorUnitarioTributavel;
		plutoRow.cells['valorFrete']?.value = nfeDetalheModel.valorFrete;
		plutoRow.cells['valorSeguro']?.value = nfeDetalheModel.valorSeguro;
		plutoRow.cells['valorDesconto']?.value = nfeDetalheModel.valorDesconto;
		plutoRow.cells['valorOutrasDespesas']?.value = nfeDetalheModel.valorOutrasDespesas;
		plutoRow.cells['entraTotal']?.value = nfeDetalheModel.entraTotal;
		plutoRow.cells['valorTotalTributos']?.value = nfeDetalheModel.valorTotalTributos;
		plutoRow.cells['percentualDevolvido']?.value = nfeDetalheModel.percentualDevolvido;
		plutoRow.cells['valorIpiDevolvido']?.value = nfeDetalheModel.valorIpiDevolvido;
		plutoRow.cells['informacoesAdicionais']?.value = nfeDetalheModel.informacoesAdicionais;
		plutoRow.cells['valorSubtotal']?.value = nfeDetalheModel.valorSubtotal;
		plutoRow.cells['valorTotal']?.value = nfeDetalheModel.valorTotal;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await nfeDetalheRepository.save(nfeDetalheModel: nfeDetalheModel); 
				if (result != null) {
					nfeDetalheModel = result;
					if (_isInserting) {
						_nfeDetalheModelList.add(nfeDetalheModel);
						_isInserting = false;
					} else {
            _nfeDetalheModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _nfeDetalheModelList.add(nfeDetalheModel);
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
		Get.find<NfeDetEspecificoVeiculoController>().userMadeChanges
		|| 
		Get.find<NfeDetEspecificoMedicamentoController>().userMadeChanges
		|| 
		Get.find<NfeDetEspecificoArmamentoController>().userMadeChanges
		|| 
		Get.find<NfeDetEspecificoCombustivelController>().userMadeChanges
		|| 
		Get.find<NfeDeclaracaoImportacaoController>().userMadeChanges
		|| 
		Get.find<NfeDetalheImpostoIcmsController>().userMadeChanges
		|| 
		Get.find<NfeDetalheImpostoIpiController>().userMadeChanges
		|| 
		Get.find<NfeDetalheImpostoIiController>().userMadeChanges
		|| 
		Get.find<NfeDetalheImpostoPisController>().userMadeChanges
		|| 
		Get.find<NfeDetalheImpostoCofinsController>().userMadeChanges
		|| 
		Get.find<NfeDetalheImpostoIssqnController>().userMadeChanges
		|| 
		Get.find<NfeExportacaoController>().userMadeChanges
		|| 
		Get.find<NfeItemRastreadoController>().userMadeChanges
		|| 
		Get.find<NfeDetalheImpostoPisStController>().userMadeChanges
		|| 
		Get.find<NfeDetalheImpostoIcmsUfdestController>().userMadeChanges
		|| 
		Get.find<NfeDetalheImpostoCofinsStController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_nfeDetalheModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_nfeDetalheModelList.add(_nfeDetalheModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(nfeDetalheModel.nfeCabecalhoModel?.numero); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [NF-e]'); 
			return false; 
		}
		return true;
	}

	Future callNfeCabecalhoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [NF-e]'; 
		lookupController.route = '/nfe-cabecalho/'; 
		lookupController.gridColumns = nfeCabecalhoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = NfeCabecalhoModel.aliasColumns; 
		lookupController.dbColumns = NfeCabecalhoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			nfeDetalheModel.idNfeCabecalho = plutoRowResult.cells['id']!.value; 
			nfeDetalheModel.nfeCabecalhoModel!.plutoRowToObject(plutoRowResult); 
			nfeCabecalhoModelController.text = nfeDetalheModel.nfeCabecalhoModel?.numero ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callProdutoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Produto]'; 
		lookupController.route = '/produto/'; 
		lookupController.gridColumns = produtoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ProdutoModel.aliasColumns; 
		lookupController.dbColumns = ProdutoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			nfeDetalheModel.idProduto = plutoRowResult.cells['id']!.value; 
			nfeDetalheModel.produtoModel!.plutoRowToObject(plutoRowResult); 
			produtoModelController.text = nfeDetalheModel.produtoModel?.nome ?? ''; 
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
		functionName = "nfe_detalhe";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		nfeCabecalhoModelController.dispose();
		produtoModelController.dispose();
		numeroItemController.dispose();
		codigoProdutoController.dispose();
		gtinController.dispose();
		nomeProdutoController.dispose();
		ncmController.dispose();
		nveController.dispose();
		cestController.dispose();
		cnpjFabricanteController.dispose();
		codigoBeneficioFiscalController.dispose();
		exTipiController.dispose();
		cfopController.dispose();
		unidadeComercialController.dispose();
		quantidadeComercialController.dispose();
		numeroPedidoCompraController.dispose();
		itemPedidoCompraController.dispose();
		numeroFciController.dispose();
		numeroRecopiController.dispose();
		valorUnitarioComercialController.dispose();
		valorBrutoProdutoController.dispose();
		gtinUnidadeTributavelController.dispose();
		unidadeTributavelController.dispose();
		quantidadeTributavelController.dispose();
		valorUnitarioTributavelController.dispose();
		valorFreteController.dispose();
		valorSeguroController.dispose();
		valorDescontoController.dispose();
		valorOutrasDespesasController.dispose();
		valorTotalTributosController.dispose();
		percentualDevolvidoController.dispose();
		valorIpiDevolvidoController.dispose();
		informacoesAdicionaisController.dispose();
		valorSubtotalController.dispose();
		valorTotalController.dispose();
		super.onClose();
	}
}