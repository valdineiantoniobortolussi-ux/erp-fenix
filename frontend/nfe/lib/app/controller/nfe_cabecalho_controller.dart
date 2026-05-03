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
import 'package:nfe/app/data/repository/nfe_cabecalho_repository.dart';
import 'package:nfe/app/page/shared_page/shared_page_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';
import 'package:nfe/app/mixin/controller_base_mixin.dart';

class NfeCabecalhoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final NfeCabecalhoRepository nfeCabecalhoRepository;
	NfeCabecalhoController({required this.nfeCabecalhoRepository});

	// general
	final _dbColumns = NfeCabecalhoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = NfeCabecalhoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = nfeCabecalhoGridColumns();
	
	var _nfeCabecalhoModelList = <NfeCabecalhoModel>[];

	var _nfeCabecalhoModelOld = NfeCabecalhoModel();

	final _nfeCabecalhoModel = NfeCabecalhoModel().obs;
	NfeCabecalhoModel get nfeCabecalhoModel => _nfeCabecalhoModel.value;
	set nfeCabecalhoModel(value) => _nfeCabecalhoModel.value = value ?? NfeCabecalhoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'NF-e', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'NFe Referenciada', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Emitente', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Destinatário', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Local Retirada', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Local Entrega', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Transporte', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Fatura', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Cana', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'NFe Produtor Rural', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'NF Referenciada', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Processo Referenciado', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Acesso XML', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Informação Pagamento', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Responsável Técnico', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'CTe Referenciado', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'CF Referenciado', 
		),
	];

	List<Widget> tabPages() {
		return [
			NfeCabecalhoEditPage(),
			const NfeReferenciadaListPage(),
			const NfeEmitenteListPage(),
			const NfeDestinatarioListPage(),
			const NfeLocalRetiradaListPage(),
			const NfeLocalEntregaListPage(),
			const NfeTransporteListPage(),
			const NfeFaturaListPage(),
			const NfeCanaListPage(),
			const NfeProdRuralReferenciadaListPage(),
			const NfeNfReferenciadaListPage(),
			const NfeProcessoReferenciadoListPage(),
			const NfeAcessoXmlListPage(),
			const NfeInformacaoPagamentoListPage(),
			const NfeResponsavelTecnicoListPage(),
			const NfeCteReferenciadoListPage(),
			const NfeCupomFiscalReferenciadoListPage(),
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
		for (var nfeCabecalhoModel in _nfeCabecalhoModelList) {
			plutoRowList.add(_getPlutoRow(nfeCabecalhoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeCabecalhoModel nfeCabecalhoModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeCabecalhoModel: nfeCabecalhoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeCabecalhoModel? nfeCabecalhoModel}) {
		return {
			"id": PlutoCell(value: nfeCabecalhoModel?.id ?? 0),
			"ufEmitente": PlutoCell(value: nfeCabecalhoModel?.ufEmitente ?? ''),
			"codigoNumerico": PlutoCell(value: nfeCabecalhoModel?.codigoNumerico ?? ''),
			"naturezaOperacao": PlutoCell(value: nfeCabecalhoModel?.naturezaOperacao ?? ''),
			"codigoModelo": PlutoCell(value: nfeCabecalhoModel?.codigoModelo ?? ''),
			"serie": PlutoCell(value: nfeCabecalhoModel?.serie ?? ''),
			"numero": PlutoCell(value: nfeCabecalhoModel?.numero ?? ''),
			"dataHoraEmissao": PlutoCell(value: nfeCabecalhoModel?.dataHoraEmissao ?? ''),
			"dataHoraEntradaSaida": PlutoCell(value: nfeCabecalhoModel?.dataHoraEntradaSaida ?? ''),
			"tipoOperacao": PlutoCell(value: nfeCabecalhoModel?.tipoOperacao ?? ''),
			"localDestino": PlutoCell(value: nfeCabecalhoModel?.localDestino ?? ''),
			"codigoMunicipio": PlutoCell(value: nfeCabecalhoModel?.codigoMunicipio ?? 0),
			"formatoImpressaoDanfe": PlutoCell(value: nfeCabecalhoModel?.formatoImpressaoDanfe ?? ''),
			"tipoEmissao": PlutoCell(value: nfeCabecalhoModel?.tipoEmissao ?? ''),
			"chaveAcesso": PlutoCell(value: nfeCabecalhoModel?.chaveAcesso ?? ''),
			"digitoChaveAcesso": PlutoCell(value: nfeCabecalhoModel?.digitoChaveAcesso ?? ''),
			"ambiente": PlutoCell(value: nfeCabecalhoModel?.ambiente ?? ''),
			"finalidadeEmissao": PlutoCell(value: nfeCabecalhoModel?.finalidadeEmissao ?? ''),
			"consumidorOperacao": PlutoCell(value: nfeCabecalhoModel?.consumidorOperacao ?? ''),
			"consumidorPresenca": PlutoCell(value: nfeCabecalhoModel?.consumidorPresenca ?? ''),
			"processoEmissao": PlutoCell(value: nfeCabecalhoModel?.processoEmissao ?? ''),
			"versaoProcessoEmissao": PlutoCell(value: nfeCabecalhoModel?.versaoProcessoEmissao ?? ''),
			"dataEntradaContingencia": PlutoCell(value: nfeCabecalhoModel?.dataEntradaContingencia ?? ''),
			"justificativaContingencia": PlutoCell(value: nfeCabecalhoModel?.justificativaContingencia ?? ''),
			"baseCalculoIcms": PlutoCell(value: nfeCabecalhoModel?.baseCalculoIcms ?? 0),
			"valorIcms": PlutoCell(value: nfeCabecalhoModel?.valorIcms ?? 0),
			"valorIcmsDesonerado": PlutoCell(value: nfeCabecalhoModel?.valorIcmsDesonerado ?? 0),
			"totalIcmsFcpUfDestino": PlutoCell(value: nfeCabecalhoModel?.totalIcmsFcpUfDestino ?? 0),
			"totalIcmsInterestadualUfDestino": PlutoCell(value: nfeCabecalhoModel?.totalIcmsInterestadualUfDestino ?? 0),
			"totalIcmsInterestadualUfRemetente": PlutoCell(value: nfeCabecalhoModel?.totalIcmsInterestadualUfRemetente ?? 0),
			"valorTotalFcp": PlutoCell(value: nfeCabecalhoModel?.valorTotalFcp ?? 0),
			"baseCalculoIcmsSt": PlutoCell(value: nfeCabecalhoModel?.baseCalculoIcmsSt ?? 0),
			"valorIcmsSt": PlutoCell(value: nfeCabecalhoModel?.valorIcmsSt ?? 0),
			"valorTotalFcpSt": PlutoCell(value: nfeCabecalhoModel?.valorTotalFcpSt ?? 0),
			"valorTotalFcpStRetido": PlutoCell(value: nfeCabecalhoModel?.valorTotalFcpStRetido ?? 0),
			"valorTotalProdutos": PlutoCell(value: nfeCabecalhoModel?.valorTotalProdutos ?? 0),
			"valorFrete": PlutoCell(value: nfeCabecalhoModel?.valorFrete ?? 0),
			"valorSeguro": PlutoCell(value: nfeCabecalhoModel?.valorSeguro ?? 0),
			"valorDesconto": PlutoCell(value: nfeCabecalhoModel?.valorDesconto ?? 0),
			"valorImpostoImportacao": PlutoCell(value: nfeCabecalhoModel?.valorImpostoImportacao ?? 0),
			"valorIpi": PlutoCell(value: nfeCabecalhoModel?.valorIpi ?? 0),
			"valorIpiDevolvido": PlutoCell(value: nfeCabecalhoModel?.valorIpiDevolvido ?? 0),
			"valorPis": PlutoCell(value: nfeCabecalhoModel?.valorPis ?? 0),
			"valorCofins": PlutoCell(value: nfeCabecalhoModel?.valorCofins ?? 0),
			"valorDespesasAcessorias": PlutoCell(value: nfeCabecalhoModel?.valorDespesasAcessorias ?? 0),
			"valorTotal": PlutoCell(value: nfeCabecalhoModel?.valorTotal ?? 0),
			"valorTotalTributos": PlutoCell(value: nfeCabecalhoModel?.valorTotalTributos ?? 0),
			"valorServicos": PlutoCell(value: nfeCabecalhoModel?.valorServicos ?? 0),
			"baseCalculoIssqn": PlutoCell(value: nfeCabecalhoModel?.baseCalculoIssqn ?? 0),
			"valorIssqn": PlutoCell(value: nfeCabecalhoModel?.valorIssqn ?? 0),
			"valorPisIssqn": PlutoCell(value: nfeCabecalhoModel?.valorPisIssqn ?? 0),
			"valorCofinsIssqn": PlutoCell(value: nfeCabecalhoModel?.valorCofinsIssqn ?? 0),
			"dataPrestacaoServico": PlutoCell(value: nfeCabecalhoModel?.dataPrestacaoServico ?? ''),
			"valorDeducaoIssqn": PlutoCell(value: nfeCabecalhoModel?.valorDeducaoIssqn ?? 0),
			"outrasRetencoesIssqn": PlutoCell(value: nfeCabecalhoModel?.outrasRetencoesIssqn ?? 0),
			"descontoIncondicionadoIssqn": PlutoCell(value: nfeCabecalhoModel?.descontoIncondicionadoIssqn ?? 0),
			"descontoCondicionadoIssqn": PlutoCell(value: nfeCabecalhoModel?.descontoCondicionadoIssqn ?? 0),
			"totalRetencaoIssqn": PlutoCell(value: nfeCabecalhoModel?.totalRetencaoIssqn ?? 0),
			"regimeEspecialTributacao": PlutoCell(value: nfeCabecalhoModel?.regimeEspecialTributacao ?? ''),
			"valorRetidoPis": PlutoCell(value: nfeCabecalhoModel?.valorRetidoPis ?? 0),
			"valorRetidoCofins": PlutoCell(value: nfeCabecalhoModel?.valorRetidoCofins ?? 0),
			"valorRetidoCsll": PlutoCell(value: nfeCabecalhoModel?.valorRetidoCsll ?? 0),
			"baseCalculoIrrf": PlutoCell(value: nfeCabecalhoModel?.baseCalculoIrrf ?? 0),
			"valorRetidoIrrf": PlutoCell(value: nfeCabecalhoModel?.valorRetidoIrrf ?? 0),
			"baseCalculoPrevidencia": PlutoCell(value: nfeCabecalhoModel?.baseCalculoPrevidencia ?? 0),
			"valorRetidoPrevidencia": PlutoCell(value: nfeCabecalhoModel?.valorRetidoPrevidencia ?? 0),
			"informacoesAddFisco": PlutoCell(value: nfeCabecalhoModel?.informacoesAddFisco ?? ''),
			"informacoesAddContribuinte": PlutoCell(value: nfeCabecalhoModel?.informacoesAddContribuinte ?? ''),
			"comexUfEmbarque": PlutoCell(value: nfeCabecalhoModel?.comexUfEmbarque ?? ''),
			"comexLocalEmbarque": PlutoCell(value: nfeCabecalhoModel?.comexLocalEmbarque ?? ''),
			"comexLocalDespacho": PlutoCell(value: nfeCabecalhoModel?.comexLocalDespacho ?? ''),
			"compraNotaEmpenho": PlutoCell(value: nfeCabecalhoModel?.compraNotaEmpenho ?? ''),
			"compraPedido": PlutoCell(value: nfeCabecalhoModel?.compraPedido ?? ''),
			"compraContrato": PlutoCell(value: nfeCabecalhoModel?.compraContrato ?? ''),
			"qrcode": PlutoCell(value: nfeCabecalhoModel?.qrcode ?? ''),
			"urlChave": PlutoCell(value: nfeCabecalhoModel?.urlChave ?? ''),
			"statusNota": PlutoCell(value: nfeCabecalhoModel?.statusNota ?? ''),
			"vendaCabecalho": PlutoCell(value: nfeCabecalhoModel?.vendaCabecalhoModel?.id ?? ''),
			"tributOperacaoFiscal": PlutoCell(value: nfeCabecalhoModel?.tributOperacaoFiscalModel?.descricao ?? ''),
			"viewPessoaCliente": PlutoCell(value: nfeCabecalhoModel?.viewPessoaClienteModel?.nome ?? ''),
			"viewPessoaColaborador": PlutoCell(value: nfeCabecalhoModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"viewPessoaFornecedor": PlutoCell(value: nfeCabecalhoModel?.viewPessoaFornecedorModel?.nome ?? ''),
			"idVendaCabecalho": PlutoCell(value: nfeCabecalhoModel?.idVendaCabecalho ?? 0),
			"idTributOperacaoFiscal": PlutoCell(value: nfeCabecalhoModel?.idTributOperacaoFiscal ?? 0),
			"idCliente": PlutoCell(value: nfeCabecalhoModel?.idCliente ?? 0),
			"idColaborador": PlutoCell(value: nfeCabecalhoModel?.idColaborador ?? 0),
			"idFornecedor": PlutoCell(value: nfeCabecalhoModel?.idFornecedor ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _nfeCabecalhoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			nfeCabecalhoModel.plutoRowToObject(plutoRow);
		} else {
			nfeCabecalhoModel = modelFromRow[0];
			_nfeCabecalhoModelOld = nfeCabecalhoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [NF-e]';
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
		await Get.find<NfeCabecalhoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await nfeCabecalhoRepository.getList(filter: filter).then( (data){ _nfeCabecalhoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'NF-e',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			codigoNumericoController.text = currentRow.cells['codigoNumerico']?.value ?? '';
			naturezaOperacaoController.text = currentRow.cells['naturezaOperacao']?.value ?? '';
			serieController.text = currentRow.cells['serie']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			codigoMunicipioController.text = currentRow.cells['codigoMunicipio']?.value?.toString() ?? '';
			chaveAcessoController.text = currentRow.cells['chaveAcesso']?.value ?? '';
			digitoChaveAcessoController.text = currentRow.cells['digitoChaveAcesso']?.value ?? '';
			versaoProcessoEmissaoController.text = currentRow.cells['versaoProcessoEmissao']?.value ?? '';
			justificativaContingenciaController.text = currentRow.cells['justificativaContingencia']?.value ?? '';
			baseCalculoIcmsController.text = currentRow.cells['baseCalculoIcms']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsController.text = currentRow.cells['valorIcms']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsDesoneradoController.text = currentRow.cells['valorIcmsDesonerado']?.value?.toStringAsFixed(2) ?? '';
			totalIcmsFcpUfDestinoController.text = currentRow.cells['totalIcmsFcpUfDestino']?.value?.toStringAsFixed(2) ?? '';
			totalIcmsInterestadualUfDestinoController.text = currentRow.cells['totalIcmsInterestadualUfDestino']?.value?.toStringAsFixed(2) ?? '';
			totalIcmsInterestadualUfRemetenteController.text = currentRow.cells['totalIcmsInterestadualUfRemetente']?.value?.toStringAsFixed(2) ?? '';
			valorTotalFcpController.text = currentRow.cells['valorTotalFcp']?.value?.toStringAsFixed(2) ?? '';
			baseCalculoIcmsStController.text = currentRow.cells['baseCalculoIcmsSt']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsStController.text = currentRow.cells['valorIcmsSt']?.value?.toStringAsFixed(2) ?? '';
			valorTotalFcpStController.text = currentRow.cells['valorTotalFcpSt']?.value?.toStringAsFixed(2) ?? '';
			valorTotalFcpStRetidoController.text = currentRow.cells['valorTotalFcpStRetido']?.value?.toStringAsFixed(2) ?? '';
			valorTotalProdutosController.text = currentRow.cells['valorTotalProdutos']?.value?.toStringAsFixed(2) ?? '';
			valorFreteController.text = currentRow.cells['valorFrete']?.value?.toStringAsFixed(2) ?? '';
			valorSeguroController.text = currentRow.cells['valorSeguro']?.value?.toStringAsFixed(2) ?? '';
			valorDescontoController.text = currentRow.cells['valorDesconto']?.value?.toStringAsFixed(2) ?? '';
			valorImpostoImportacaoController.text = currentRow.cells['valorImpostoImportacao']?.value?.toStringAsFixed(2) ?? '';
			valorIpiController.text = currentRow.cells['valorIpi']?.value?.toStringAsFixed(2) ?? '';
			valorIpiDevolvidoController.text = currentRow.cells['valorIpiDevolvido']?.value?.toStringAsFixed(2) ?? '';
			valorPisController.text = currentRow.cells['valorPis']?.value?.toStringAsFixed(2) ?? '';
			valorCofinsController.text = currentRow.cells['valorCofins']?.value?.toStringAsFixed(2) ?? '';
			valorDespesasAcessoriasController.text = currentRow.cells['valorDespesasAcessorias']?.value?.toStringAsFixed(2) ?? '';
			valorTotalController.text = currentRow.cells['valorTotal']?.value?.toStringAsFixed(2) ?? '';
			valorTotalTributosController.text = currentRow.cells['valorTotalTributos']?.value?.toStringAsFixed(2) ?? '';
			valorServicosController.text = currentRow.cells['valorServicos']?.value?.toStringAsFixed(2) ?? '';
			baseCalculoIssqnController.text = currentRow.cells['baseCalculoIssqn']?.value?.toStringAsFixed(2) ?? '';
			valorIssqnController.text = currentRow.cells['valorIssqn']?.value?.toStringAsFixed(2) ?? '';
			valorPisIssqnController.text = currentRow.cells['valorPisIssqn']?.value?.toStringAsFixed(2) ?? '';
			valorCofinsIssqnController.text = currentRow.cells['valorCofinsIssqn']?.value?.toStringAsFixed(2) ?? '';
			valorDeducaoIssqnController.text = currentRow.cells['valorDeducaoIssqn']?.value?.toStringAsFixed(2) ?? '';
			outrasRetencoesIssqnController.text = currentRow.cells['outrasRetencoesIssqn']?.value?.toStringAsFixed(2) ?? '';
			descontoIncondicionadoIssqnController.text = currentRow.cells['descontoIncondicionadoIssqn']?.value?.toStringAsFixed(2) ?? '';
			descontoCondicionadoIssqnController.text = currentRow.cells['descontoCondicionadoIssqn']?.value?.toStringAsFixed(2) ?? '';
			totalRetencaoIssqnController.text = currentRow.cells['totalRetencaoIssqn']?.value?.toStringAsFixed(2) ?? '';
			valorRetidoPisController.text = currentRow.cells['valorRetidoPis']?.value?.toStringAsFixed(2) ?? '';
			valorRetidoCofinsController.text = currentRow.cells['valorRetidoCofins']?.value?.toStringAsFixed(2) ?? '';
			valorRetidoCsllController.text = currentRow.cells['valorRetidoCsll']?.value?.toStringAsFixed(2) ?? '';
			baseCalculoIrrfController.text = currentRow.cells['baseCalculoIrrf']?.value?.toStringAsFixed(2) ?? '';
			valorRetidoIrrfController.text = currentRow.cells['valorRetidoIrrf']?.value?.toStringAsFixed(2) ?? '';
			baseCalculoPrevidenciaController.text = currentRow.cells['baseCalculoPrevidencia']?.value?.toStringAsFixed(2) ?? '';
			valorRetidoPrevidenciaController.text = currentRow.cells['valorRetidoPrevidencia']?.value?.toStringAsFixed(2) ?? '';
			informacoesAddFiscoController.text = currentRow.cells['informacoesAddFisco']?.value ?? '';
			informacoesAddContribuinteController.text = currentRow.cells['informacoesAddContribuinte']?.value ?? '';
			comexLocalEmbarqueController.text = currentRow.cells['comexLocalEmbarque']?.value ?? '';
			comexLocalDespachoController.text = currentRow.cells['comexLocalDespacho']?.value ?? '';
			compraNotaEmpenhoController.text = currentRow.cells['compraNotaEmpenho']?.value ?? '';
			compraPedidoController.text = currentRow.cells['compraPedido']?.value ?? '';
			compraContratoController.text = currentRow.cells['compraContrato']?.value ?? '';
			qrcodeController.text = currentRow.cells['qrcode']?.value ?? '';
			urlChaveController.text = currentRow.cells['urlChave']?.value ?? '';
			vendaCabecalhoModelController.text = currentRow.cells['vendaCabecalho']?.value ?? '';
			tributOperacaoFiscalModelController.text = currentRow.cells['tributOperacaoFiscal']?.value ?? '';
			viewPessoaClienteModelController.text = currentRow.cells['viewPessoaCliente']?.value ?? '';
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			viewPessoaFornecedorModelController.text = currentRow.cells['viewPessoaFornecedor']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//NFe Referenciada
			Get.put<NfeReferenciadaController>(NfeReferenciadaController()); 
			final nfeReferenciadaController = Get.find<NfeReferenciadaController>(); 
			nfeReferenciadaController.nfeReferenciadaModelList = nfeCabecalhoModel.nfeReferenciadaModelList!; 
			nfeReferenciadaController.userMadeChanges = false; 

			//Emitente
			Get.put<NfeEmitenteController>(NfeEmitenteController()); 
			final nfeEmitenteController = Get.find<NfeEmitenteController>(); 
			nfeEmitenteController.nfeEmitenteModelList = nfeCabecalhoModel.nfeEmitenteModelList!; 
			nfeEmitenteController.userMadeChanges = false; 

			//Destinatário
			Get.put<NfeDestinatarioController>(NfeDestinatarioController()); 
			final nfeDestinatarioController = Get.find<NfeDestinatarioController>(); 
			nfeDestinatarioController.nfeDestinatarioModelList = nfeCabecalhoModel.nfeDestinatarioModelList!; 
			nfeDestinatarioController.userMadeChanges = false; 

			//Local Retirada
			Get.put<NfeLocalRetiradaController>(NfeLocalRetiradaController()); 
			final nfeLocalRetiradaController = Get.find<NfeLocalRetiradaController>(); 
			nfeLocalRetiradaController.nfeLocalRetiradaModelList = nfeCabecalhoModel.nfeLocalRetiradaModelList!; 
			nfeLocalRetiradaController.userMadeChanges = false; 

			//Local Entrega
			Get.put<NfeLocalEntregaController>(NfeLocalEntregaController()); 
			final nfeLocalEntregaController = Get.find<NfeLocalEntregaController>(); 
			nfeLocalEntregaController.nfeLocalEntregaModelList = nfeCabecalhoModel.nfeLocalEntregaModelList!; 
			nfeLocalEntregaController.userMadeChanges = false; 

			//Transporte
			Get.put<NfeTransporteController>(NfeTransporteController()); 
			final nfeTransporteController = Get.find<NfeTransporteController>(); 
			nfeTransporteController.nfeTransporteModelList = nfeCabecalhoModel.nfeTransporteModelList!; 
			nfeTransporteController.userMadeChanges = false; 

			//Fatura
			Get.put<NfeFaturaController>(NfeFaturaController()); 
			final nfeFaturaController = Get.find<NfeFaturaController>(); 
			nfeFaturaController.nfeFaturaModelList = nfeCabecalhoModel.nfeFaturaModelList!; 
			nfeFaturaController.userMadeChanges = false; 

			//Cana
			Get.put<NfeCanaController>(NfeCanaController()); 
			final nfeCanaController = Get.find<NfeCanaController>(); 
			nfeCanaController.nfeCanaModelList = nfeCabecalhoModel.nfeCanaModelList!; 
			nfeCanaController.userMadeChanges = false; 

			//NFe Produtor Rural
			Get.put<NfeProdRuralReferenciadaController>(NfeProdRuralReferenciadaController()); 
			final nfeProdRuralReferenciadaController = Get.find<NfeProdRuralReferenciadaController>(); 
			nfeProdRuralReferenciadaController.nfeProdRuralReferenciadaModelList = nfeCabecalhoModel.nfeProdRuralReferenciadaModelList!; 
			nfeProdRuralReferenciadaController.userMadeChanges = false; 

			//NF Referenciada
			Get.put<NfeNfReferenciadaController>(NfeNfReferenciadaController()); 
			final nfeNfReferenciadaController = Get.find<NfeNfReferenciadaController>(); 
			nfeNfReferenciadaController.nfeNfReferenciadaModelList = nfeCabecalhoModel.nfeNfReferenciadaModelList!; 
			nfeNfReferenciadaController.userMadeChanges = false; 

			//Processo Referenciado
			Get.put<NfeProcessoReferenciadoController>(NfeProcessoReferenciadoController()); 
			final nfeProcessoReferenciadoController = Get.find<NfeProcessoReferenciadoController>(); 
			nfeProcessoReferenciadoController.nfeProcessoReferenciadoModelList = nfeCabecalhoModel.nfeProcessoReferenciadoModelList!; 
			nfeProcessoReferenciadoController.userMadeChanges = false; 

			//Acesso XML
			Get.put<NfeAcessoXmlController>(NfeAcessoXmlController()); 
			final nfeAcessoXmlController = Get.find<NfeAcessoXmlController>(); 
			nfeAcessoXmlController.nfeAcessoXmlModelList = nfeCabecalhoModel.nfeAcessoXmlModelList!; 
			nfeAcessoXmlController.userMadeChanges = false; 

			//Informação Pagamento
			Get.put<NfeInformacaoPagamentoController>(NfeInformacaoPagamentoController()); 
			final nfeInformacaoPagamentoController = Get.find<NfeInformacaoPagamentoController>(); 
			nfeInformacaoPagamentoController.nfeInformacaoPagamentoModelList = nfeCabecalhoModel.nfeInformacaoPagamentoModelList!; 
			nfeInformacaoPagamentoController.userMadeChanges = false; 

			//Responsável Técnico
			Get.put<NfeResponsavelTecnicoController>(NfeResponsavelTecnicoController()); 
			final nfeResponsavelTecnicoController = Get.find<NfeResponsavelTecnicoController>(); 
			nfeResponsavelTecnicoController.nfeResponsavelTecnicoModelList = nfeCabecalhoModel.nfeResponsavelTecnicoModelList!; 
			nfeResponsavelTecnicoController.userMadeChanges = false; 

			//CTe Referenciado
			Get.put<NfeCteReferenciadoController>(NfeCteReferenciadoController()); 
			final nfeCteReferenciadoController = Get.find<NfeCteReferenciadoController>(); 
			nfeCteReferenciadoController.nfeCteReferenciadoModelList = nfeCabecalhoModel.nfeCteReferenciadoModelList!; 
			nfeCteReferenciadoController.userMadeChanges = false; 

			//CF Referenciado
			Get.put<NfeCupomFiscalReferenciadoController>(NfeCupomFiscalReferenciadoController()); 
			final nfeCupomFiscalReferenciadoController = Get.find<NfeCupomFiscalReferenciadoController>(); 
			nfeCupomFiscalReferenciadoController.nfeCupomFiscalReferenciadoModelList = nfeCabecalhoModel.nfeCupomFiscalReferenciadoModelList!; 
			nfeCupomFiscalReferenciadoController.userMadeChanges = false; 


			Get.toNamed(Routes.nfeCabecalhoTabPage)!.then((value) {
				if (nfeCabecalhoModel.id == 0) {
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
		nfeCabecalhoModel = NfeCabecalhoModel();
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
				if (await nfeCabecalhoRepository.delete(id: currentRow.cells['id']!.value)) {
					_nfeCabecalhoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final codigoNumericoController = TextEditingController();
	final naturezaOperacaoController = TextEditingController();
	final serieController = TextEditingController();
	final numeroController = TextEditingController();
	final codigoMunicipioController = TextEditingController();
	final chaveAcessoController = TextEditingController();
	final digitoChaveAcessoController = TextEditingController();
	final versaoProcessoEmissaoController = TextEditingController();
	final justificativaContingenciaController = TextEditingController();
	final baseCalculoIcmsController = MoneyMaskedTextController();
	final valorIcmsController = MoneyMaskedTextController();
	final valorIcmsDesoneradoController = MoneyMaskedTextController();
	final totalIcmsFcpUfDestinoController = MoneyMaskedTextController();
	final totalIcmsInterestadualUfDestinoController = MoneyMaskedTextController();
	final totalIcmsInterestadualUfRemetenteController = MoneyMaskedTextController();
	final valorTotalFcpController = MoneyMaskedTextController();
	final baseCalculoIcmsStController = MoneyMaskedTextController();
	final valorIcmsStController = MoneyMaskedTextController();
	final valorTotalFcpStController = MoneyMaskedTextController();
	final valorTotalFcpStRetidoController = MoneyMaskedTextController();
	final valorTotalProdutosController = MoneyMaskedTextController();
	final valorFreteController = MoneyMaskedTextController();
	final valorSeguroController = MoneyMaskedTextController();
	final valorDescontoController = MoneyMaskedTextController();
	final valorImpostoImportacaoController = MoneyMaskedTextController();
	final valorIpiController = MoneyMaskedTextController();
	final valorIpiDevolvidoController = MoneyMaskedTextController();
	final valorPisController = MoneyMaskedTextController();
	final valorCofinsController = MoneyMaskedTextController();
	final valorDespesasAcessoriasController = MoneyMaskedTextController();
	final valorTotalController = MoneyMaskedTextController();
	final valorTotalTributosController = MoneyMaskedTextController();
	final valorServicosController = MoneyMaskedTextController();
	final baseCalculoIssqnController = MoneyMaskedTextController();
	final valorIssqnController = MoneyMaskedTextController();
	final valorPisIssqnController = MoneyMaskedTextController();
	final valorCofinsIssqnController = MoneyMaskedTextController();
	final valorDeducaoIssqnController = MoneyMaskedTextController();
	final outrasRetencoesIssqnController = MoneyMaskedTextController();
	final descontoIncondicionadoIssqnController = MoneyMaskedTextController();
	final descontoCondicionadoIssqnController = MoneyMaskedTextController();
	final totalRetencaoIssqnController = MoneyMaskedTextController();
	final valorRetidoPisController = MoneyMaskedTextController();
	final valorRetidoCofinsController = MoneyMaskedTextController();
	final valorRetidoCsllController = MoneyMaskedTextController();
	final baseCalculoIrrfController = MoneyMaskedTextController();
	final valorRetidoIrrfController = MoneyMaskedTextController();
	final baseCalculoPrevidenciaController = MoneyMaskedTextController();
	final valorRetidoPrevidenciaController = MoneyMaskedTextController();
	final informacoesAddFiscoController = TextEditingController();
	final informacoesAddContribuinteController = TextEditingController();
	final comexLocalEmbarqueController = TextEditingController();
	final comexLocalDespachoController = TextEditingController();
	final compraNotaEmpenhoController = TextEditingController();
	final compraPedidoController = TextEditingController();
	final compraContratoController = TextEditingController();
	final qrcodeController = TextEditingController();
	final urlChaveController = TextEditingController();
	final vendaCabecalhoModelController = TextEditingController();
	final tributOperacaoFiscalModelController = TextEditingController();
	final viewPessoaClienteModelController = TextEditingController();
	final viewPessoaColaboradorModelController = TextEditingController();
	final viewPessoaFornecedorModelController = TextEditingController();

	final nfeCabecalhoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final nfeCabecalhoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final nfeCabecalhoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeCabecalhoModel.id;
		plutoRow.cells['ufEmitente']?.value = nfeCabecalhoModel.ufEmitente;
		plutoRow.cells['codigoNumerico']?.value = nfeCabecalhoModel.codigoNumerico;
		plutoRow.cells['naturezaOperacao']?.value = nfeCabecalhoModel.naturezaOperacao;
		plutoRow.cells['codigoModelo']?.value = nfeCabecalhoModel.codigoModelo;
		plutoRow.cells['serie']?.value = nfeCabecalhoModel.serie;
		plutoRow.cells['numero']?.value = nfeCabecalhoModel.numero;
		plutoRow.cells['dataHoraEmissao']?.value = Util.formatDate(nfeCabecalhoModel.dataHoraEmissao);
		plutoRow.cells['dataHoraEntradaSaida']?.value = Util.formatDate(nfeCabecalhoModel.dataHoraEntradaSaida);
		plutoRow.cells['tipoOperacao']?.value = nfeCabecalhoModel.tipoOperacao;
		plutoRow.cells['localDestino']?.value = nfeCabecalhoModel.localDestino;
		plutoRow.cells['codigoMunicipio']?.value = nfeCabecalhoModel.codigoMunicipio;
		plutoRow.cells['formatoImpressaoDanfe']?.value = nfeCabecalhoModel.formatoImpressaoDanfe;
		plutoRow.cells['tipoEmissao']?.value = nfeCabecalhoModel.tipoEmissao;
		plutoRow.cells['chaveAcesso']?.value = nfeCabecalhoModel.chaveAcesso;
		plutoRow.cells['digitoChaveAcesso']?.value = nfeCabecalhoModel.digitoChaveAcesso;
		plutoRow.cells['ambiente']?.value = nfeCabecalhoModel.ambiente;
		plutoRow.cells['finalidadeEmissao']?.value = nfeCabecalhoModel.finalidadeEmissao;
		plutoRow.cells['consumidorOperacao']?.value = nfeCabecalhoModel.consumidorOperacao;
		plutoRow.cells['consumidorPresenca']?.value = nfeCabecalhoModel.consumidorPresenca;
		plutoRow.cells['processoEmissao']?.value = nfeCabecalhoModel.processoEmissao;
		plutoRow.cells['versaoProcessoEmissao']?.value = nfeCabecalhoModel.versaoProcessoEmissao;
		plutoRow.cells['dataEntradaContingencia']?.value = Util.formatDate(nfeCabecalhoModel.dataEntradaContingencia);
		plutoRow.cells['justificativaContingencia']?.value = nfeCabecalhoModel.justificativaContingencia;
		plutoRow.cells['baseCalculoIcms']?.value = nfeCabecalhoModel.baseCalculoIcms;
		plutoRow.cells['valorIcms']?.value = nfeCabecalhoModel.valorIcms;
		plutoRow.cells['valorIcmsDesonerado']?.value = nfeCabecalhoModel.valorIcmsDesonerado;
		plutoRow.cells['totalIcmsFcpUfDestino']?.value = nfeCabecalhoModel.totalIcmsFcpUfDestino;
		plutoRow.cells['totalIcmsInterestadualUfDestino']?.value = nfeCabecalhoModel.totalIcmsInterestadualUfDestino;
		plutoRow.cells['totalIcmsInterestadualUfRemetente']?.value = nfeCabecalhoModel.totalIcmsInterestadualUfRemetente;
		plutoRow.cells['valorTotalFcp']?.value = nfeCabecalhoModel.valorTotalFcp;
		plutoRow.cells['baseCalculoIcmsSt']?.value = nfeCabecalhoModel.baseCalculoIcmsSt;
		plutoRow.cells['valorIcmsSt']?.value = nfeCabecalhoModel.valorIcmsSt;
		plutoRow.cells['valorTotalFcpSt']?.value = nfeCabecalhoModel.valorTotalFcpSt;
		plutoRow.cells['valorTotalFcpStRetido']?.value = nfeCabecalhoModel.valorTotalFcpStRetido;
		plutoRow.cells['valorTotalProdutos']?.value = nfeCabecalhoModel.valorTotalProdutos;
		plutoRow.cells['valorFrete']?.value = nfeCabecalhoModel.valorFrete;
		plutoRow.cells['valorSeguro']?.value = nfeCabecalhoModel.valorSeguro;
		plutoRow.cells['valorDesconto']?.value = nfeCabecalhoModel.valorDesconto;
		plutoRow.cells['valorImpostoImportacao']?.value = nfeCabecalhoModel.valorImpostoImportacao;
		plutoRow.cells['valorIpi']?.value = nfeCabecalhoModel.valorIpi;
		plutoRow.cells['valorIpiDevolvido']?.value = nfeCabecalhoModel.valorIpiDevolvido;
		plutoRow.cells['valorPis']?.value = nfeCabecalhoModel.valorPis;
		plutoRow.cells['valorCofins']?.value = nfeCabecalhoModel.valorCofins;
		plutoRow.cells['valorDespesasAcessorias']?.value = nfeCabecalhoModel.valorDespesasAcessorias;
		plutoRow.cells['valorTotal']?.value = nfeCabecalhoModel.valorTotal;
		plutoRow.cells['valorTotalTributos']?.value = nfeCabecalhoModel.valorTotalTributos;
		plutoRow.cells['valorServicos']?.value = nfeCabecalhoModel.valorServicos;
		plutoRow.cells['baseCalculoIssqn']?.value = nfeCabecalhoModel.baseCalculoIssqn;
		plutoRow.cells['valorIssqn']?.value = nfeCabecalhoModel.valorIssqn;
		plutoRow.cells['valorPisIssqn']?.value = nfeCabecalhoModel.valorPisIssqn;
		plutoRow.cells['valorCofinsIssqn']?.value = nfeCabecalhoModel.valorCofinsIssqn;
		plutoRow.cells['dataPrestacaoServico']?.value = Util.formatDate(nfeCabecalhoModel.dataPrestacaoServico);
		plutoRow.cells['valorDeducaoIssqn']?.value = nfeCabecalhoModel.valorDeducaoIssqn;
		plutoRow.cells['outrasRetencoesIssqn']?.value = nfeCabecalhoModel.outrasRetencoesIssqn;
		plutoRow.cells['descontoIncondicionadoIssqn']?.value = nfeCabecalhoModel.descontoIncondicionadoIssqn;
		plutoRow.cells['descontoCondicionadoIssqn']?.value = nfeCabecalhoModel.descontoCondicionadoIssqn;
		plutoRow.cells['totalRetencaoIssqn']?.value = nfeCabecalhoModel.totalRetencaoIssqn;
		plutoRow.cells['regimeEspecialTributacao']?.value = nfeCabecalhoModel.regimeEspecialTributacao;
		plutoRow.cells['valorRetidoPis']?.value = nfeCabecalhoModel.valorRetidoPis;
		plutoRow.cells['valorRetidoCofins']?.value = nfeCabecalhoModel.valorRetidoCofins;
		plutoRow.cells['valorRetidoCsll']?.value = nfeCabecalhoModel.valorRetidoCsll;
		plutoRow.cells['baseCalculoIrrf']?.value = nfeCabecalhoModel.baseCalculoIrrf;
		plutoRow.cells['valorRetidoIrrf']?.value = nfeCabecalhoModel.valorRetidoIrrf;
		plutoRow.cells['baseCalculoPrevidencia']?.value = nfeCabecalhoModel.baseCalculoPrevidencia;
		plutoRow.cells['valorRetidoPrevidencia']?.value = nfeCabecalhoModel.valorRetidoPrevidencia;
		plutoRow.cells['informacoesAddFisco']?.value = nfeCabecalhoModel.informacoesAddFisco;
		plutoRow.cells['informacoesAddContribuinte']?.value = nfeCabecalhoModel.informacoesAddContribuinte;
		plutoRow.cells['comexUfEmbarque']?.value = nfeCabecalhoModel.comexUfEmbarque;
		plutoRow.cells['comexLocalEmbarque']?.value = nfeCabecalhoModel.comexLocalEmbarque;
		plutoRow.cells['comexLocalDespacho']?.value = nfeCabecalhoModel.comexLocalDespacho;
		plutoRow.cells['compraNotaEmpenho']?.value = nfeCabecalhoModel.compraNotaEmpenho;
		plutoRow.cells['compraPedido']?.value = nfeCabecalhoModel.compraPedido;
		plutoRow.cells['compraContrato']?.value = nfeCabecalhoModel.compraContrato;
		plutoRow.cells['qrcode']?.value = nfeCabecalhoModel.qrcode;
		plutoRow.cells['urlChave']?.value = nfeCabecalhoModel.urlChave;
		plutoRow.cells['statusNota']?.value = nfeCabecalhoModel.statusNota;
		plutoRow.cells['idVendaCabecalho']?.value = nfeCabecalhoModel.idVendaCabecalho;
		plutoRow.cells['vendaCabecalho']?.value = nfeCabecalhoModel.vendaCabecalhoModel?.id;
		plutoRow.cells['idTributOperacaoFiscal']?.value = nfeCabecalhoModel.idTributOperacaoFiscal;
		plutoRow.cells['tributOperacaoFiscal']?.value = nfeCabecalhoModel.tributOperacaoFiscalModel?.descricao;
		plutoRow.cells['idCliente']?.value = nfeCabecalhoModel.idCliente;
		plutoRow.cells['viewPessoaCliente']?.value = nfeCabecalhoModel.viewPessoaClienteModel?.nome;
		plutoRow.cells['idColaborador']?.value = nfeCabecalhoModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = nfeCabecalhoModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['idFornecedor']?.value = nfeCabecalhoModel.idFornecedor;
		plutoRow.cells['viewPessoaFornecedor']?.value = nfeCabecalhoModel.viewPessoaFornecedorModel?.nome;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await nfeCabecalhoRepository.save(nfeCabecalhoModel: nfeCabecalhoModel); 
				if (result != null) {
					nfeCabecalhoModel = result;
					if (_isInserting) {
						_nfeCabecalhoModelList.add(nfeCabecalhoModel);
						_isInserting = false;
					} else {
            _nfeCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _nfeCabecalhoModelList.add(nfeCabecalhoModel);
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
		Get.find<NfeReferenciadaController>().userMadeChanges
		|| 
		Get.find<NfeEmitenteController>().userMadeChanges
		|| 
		Get.find<NfeDestinatarioController>().userMadeChanges
		|| 
		Get.find<NfeLocalRetiradaController>().userMadeChanges
		|| 
		Get.find<NfeLocalEntregaController>().userMadeChanges
		|| 
		Get.find<NfeTransporteController>().userMadeChanges
		|| 
		Get.find<NfeFaturaController>().userMadeChanges
		|| 
		Get.find<NfeCanaController>().userMadeChanges
		|| 
		Get.find<NfeProdRuralReferenciadaController>().userMadeChanges
		|| 
		Get.find<NfeNfReferenciadaController>().userMadeChanges
		|| 
		Get.find<NfeProcessoReferenciadoController>().userMadeChanges
		|| 
		Get.find<NfeAcessoXmlController>().userMadeChanges
		|| 
		Get.find<NfeInformacaoPagamentoController>().userMadeChanges
		|| 
		Get.find<NfeResponsavelTecnicoController>().userMadeChanges
		|| 
		Get.find<NfeCteReferenciadoController>().userMadeChanges
		|| 
		Get.find<NfeCupomFiscalReferenciadoController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_nfeCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_nfeCabecalhoModelList.add(_nfeCabecalhoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(nfeCabecalhoModel.viewPessoaClienteModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Cliente]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(nfeCabecalhoModel.viewPessoaColaboradorModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Colaborador]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(nfeCabecalhoModel.viewPessoaFornecedorModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Fornecedor]'); 
			return false; 
		}
		return true;
	}

	Future callVendaCabecalhoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Venda]'; 
		lookupController.route = '/venda-cabecalho/'; 
		lookupController.gridColumns = vendaCabecalhoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = VendaCabecalhoModel.aliasColumns; 
		lookupController.dbColumns = VendaCabecalhoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			nfeCabecalhoModel.idVendaCabecalho = plutoRowResult.cells['id']!.value; 
			nfeCabecalhoModel.vendaCabecalhoModel!.plutoRowToObject(plutoRowResult); 
			vendaCabecalhoModelController.text = nfeCabecalhoModel.vendaCabecalhoModel?.id?.toString() ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callTributOperacaoFiscalLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Operação Fiscal]'; 
		lookupController.route = '/tribut-operacao-fiscal/'; 
		lookupController.gridColumns = tributOperacaoFiscalGridColumns(isForLookup: true); 
		lookupController.aliasColumns = TributOperacaoFiscalModel.aliasColumns; 
		lookupController.dbColumns = TributOperacaoFiscalModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			nfeCabecalhoModel.idTributOperacaoFiscal = plutoRowResult.cells['id']!.value; 
			nfeCabecalhoModel.tributOperacaoFiscalModel!.plutoRowToObject(plutoRowResult); 
			tributOperacaoFiscalModelController.text = nfeCabecalhoModel.tributOperacaoFiscalModel?.descricao ?? ''; 
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
			nfeCabecalhoModel.idCliente = plutoRowResult.cells['id']!.value; 
			nfeCabecalhoModel.viewPessoaClienteModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaClienteModelController.text = nfeCabecalhoModel.viewPessoaClienteModel?.nome ?? ''; 
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
			nfeCabecalhoModel.idColaborador = plutoRowResult.cells['id']!.value; 
			nfeCabecalhoModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = nfeCabecalhoModel.viewPessoaColaboradorModel?.nome ?? ''; 
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
			nfeCabecalhoModel.idFornecedor = plutoRowResult.cells['id']!.value; 
			nfeCabecalhoModel.viewPessoaFornecedorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaFornecedorModelController.text = nfeCabecalhoModel.viewPessoaFornecedorModel?.nome ?? ''; 
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
		functionName = "nfe_cabecalho";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		codigoNumericoController.dispose();
		naturezaOperacaoController.dispose();
		serieController.dispose();
		numeroController.dispose();
		codigoMunicipioController.dispose();
		chaveAcessoController.dispose();
		digitoChaveAcessoController.dispose();
		versaoProcessoEmissaoController.dispose();
		justificativaContingenciaController.dispose();
		baseCalculoIcmsController.dispose();
		valorIcmsController.dispose();
		valorIcmsDesoneradoController.dispose();
		totalIcmsFcpUfDestinoController.dispose();
		totalIcmsInterestadualUfDestinoController.dispose();
		totalIcmsInterestadualUfRemetenteController.dispose();
		valorTotalFcpController.dispose();
		baseCalculoIcmsStController.dispose();
		valorIcmsStController.dispose();
		valorTotalFcpStController.dispose();
		valorTotalFcpStRetidoController.dispose();
		valorTotalProdutosController.dispose();
		valorFreteController.dispose();
		valorSeguroController.dispose();
		valorDescontoController.dispose();
		valorImpostoImportacaoController.dispose();
		valorIpiController.dispose();
		valorIpiDevolvidoController.dispose();
		valorPisController.dispose();
		valorCofinsController.dispose();
		valorDespesasAcessoriasController.dispose();
		valorTotalController.dispose();
		valorTotalTributosController.dispose();
		valorServicosController.dispose();
		baseCalculoIssqnController.dispose();
		valorIssqnController.dispose();
		valorPisIssqnController.dispose();
		valorCofinsIssqnController.dispose();
		valorDeducaoIssqnController.dispose();
		outrasRetencoesIssqnController.dispose();
		descontoIncondicionadoIssqnController.dispose();
		descontoCondicionadoIssqnController.dispose();
		totalRetencaoIssqnController.dispose();
		valorRetidoPisController.dispose();
		valorRetidoCofinsController.dispose();
		valorRetidoCsllController.dispose();
		baseCalculoIrrfController.dispose();
		valorRetidoIrrfController.dispose();
		baseCalculoPrevidenciaController.dispose();
		valorRetidoPrevidenciaController.dispose();
		informacoesAddFiscoController.dispose();
		informacoesAddContribuinteController.dispose();
		comexLocalEmbarqueController.dispose();
		comexLocalDespachoController.dispose();
		compraNotaEmpenhoController.dispose();
		compraPedidoController.dispose();
		compraContratoController.dispose();
		qrcodeController.dispose();
		urlChaveController.dispose();
		vendaCabecalhoModelController.dispose();
		tributOperacaoFiscalModelController.dispose();
		viewPessoaClienteModelController.dispose();
		viewPessoaColaboradorModelController.dispose();
		viewPessoaFornecedorModelController.dispose();
		super.onClose();
	}
}