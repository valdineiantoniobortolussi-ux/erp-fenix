import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/controller/controller_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/page/grid_columns/grid_columns_imports.dart';
import 'package:cte/app/page/page_imports.dart';

import 'package:cte/app/routes/app_routes.dart';
import 'package:cte/app/data/repository/cte_cabecalho_repository.dart';
import 'package:cte/app/page/shared_page/shared_page_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';
import 'package:cte/app/mixin/controller_base_mixin.dart';

class CteCabecalhoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final CteCabecalhoRepository cteCabecalhoRepository;
	CteCabecalhoController({required this.cteCabecalhoRepository});

	// general
	final _dbColumns = CteCabecalhoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = CteCabecalhoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = cteCabecalhoGridColumns();
	
	var _cteCabecalhoModelList = <CteCabecalhoModel>[];

	var _cteCabecalhoModelOld = CteCabecalhoModel();

	final _cteCabecalhoModel = CteCabecalhoModel().obs;
	CteCabecalhoModel get cteCabecalhoModel => _cteCabecalhoModel.value;
	set cteCabecalhoModel(value) => _cteCabecalhoModel.value = value ?? CteCabecalhoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'CT-e', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Emitente', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Local Coleta', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Tomador', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Passagem', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Remetente', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Expedidor', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Recebedor', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Destinatário', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Local Entrega', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Componente', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Carga', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'NF Outros', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Seguro', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Perigoso', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Veículo Novo', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Fatura', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Duplicata', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Rodoviário', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Aéreo', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Aquaviário', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Ferroviário', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Dutoviário', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Multimodal', 
		),
	];

	List<Widget> tabPages() {
		return [
			CteCabecalhoEditPage(),
			const CteEmitenteListPage(),
			const CteLocalColetaListPage(),
			const CteTomadorListPage(),
			const CtePassagemListPage(),
			const CteRemetenteListPage(),
			const CteExpedidorListPage(),
			const CteRecebedorListPage(),
			const CteDestinatarioListPage(),
			const CteLocalEntregaListPage(),
			const CteComponenteListPage(),
			const CteCargaListPage(),
			const CteInformacaoNfOutrosListPage(),
			const CteSeguroListPage(),
			const CtePerigosoListPage(),
			const CteVeiculoNovoListPage(),
			const CteFaturaListPage(),
			const CteDuplicataListPage(),
			const CteRodoviarioListPage(),
			const CteAereoListPage(),
			const CteAquaviarioListPage(),
			const CteFerroviarioListPage(),
			const CteDutoviarioListPage(),
			const CteMultimodalListPage(),
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
		for (var cteCabecalhoModel in _cteCabecalhoModelList) {
			plutoRowList.add(_getPlutoRow(cteCabecalhoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CteCabecalhoModel cteCabecalhoModel) {
		return PlutoRow(
			cells: _getPlutoCells(cteCabecalhoModel: cteCabecalhoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CteCabecalhoModel? cteCabecalhoModel}) {
		return {
			"id": PlutoCell(value: cteCabecalhoModel?.id ?? 0),
			"naturezaOperacao": PlutoCell(value: cteCabecalhoModel?.naturezaOperacao ?? ''),
			"chaveAcesso": PlutoCell(value: cteCabecalhoModel?.chaveAcesso ?? ''),
			"digitoChaveAcesso": PlutoCell(value: cteCabecalhoModel?.digitoChaveAcesso ?? ''),
			"codigoNumerico": PlutoCell(value: cteCabecalhoModel?.codigoNumerico ?? ''),
			"serie": PlutoCell(value: cteCabecalhoModel?.serie ?? ''),
			"numero": PlutoCell(value: cteCabecalhoModel?.numero ?? ''),
			"dataHoraEmissao": PlutoCell(value: cteCabecalhoModel?.dataHoraEmissao ?? ''),
			"ufEmitente": PlutoCell(value: cteCabecalhoModel?.ufEmitente ?? ''),
			"cfop": PlutoCell(value: cteCabecalhoModel?.cfop ?? 0),
			"formaPagamento": PlutoCell(value: cteCabecalhoModel?.formaPagamento ?? ''),
			"modelo": PlutoCell(value: cteCabecalhoModel?.modelo ?? ''),
			"formatoImpressaoDacte": PlutoCell(value: cteCabecalhoModel?.formatoImpressaoDacte ?? ''),
			"tipoEmissao": PlutoCell(value: cteCabecalhoModel?.tipoEmissao ?? ''),
			"ambiente": PlutoCell(value: cteCabecalhoModel?.ambiente ?? ''),
			"tipoCte": PlutoCell(value: cteCabecalhoModel?.tipoCte ?? ''),
			"processoEmissao": PlutoCell(value: cteCabecalhoModel?.processoEmissao ?? ''),
			"versaoProcessoEmissao": PlutoCell(value: cteCabecalhoModel?.versaoProcessoEmissao ?? ''),
			"chaveReferenciado": PlutoCell(value: cteCabecalhoModel?.chaveReferenciado ?? ''),
			"codigoMunicipioEnvio": PlutoCell(value: cteCabecalhoModel?.codigoMunicipioEnvio ?? 0),
			"nomeMunicipioEnvio": PlutoCell(value: cteCabecalhoModel?.nomeMunicipioEnvio ?? ''),
			"ufEnvio": PlutoCell(value: cteCabecalhoModel?.ufEnvio ?? ''),
			"modal": PlutoCell(value: cteCabecalhoModel?.modal ?? ''),
			"tipoServico": PlutoCell(value: cteCabecalhoModel?.tipoServico ?? ''),
			"codigoMunicipioIniPrestacao": PlutoCell(value: cteCabecalhoModel?.codigoMunicipioIniPrestacao ?? 0),
			"nomeMunicipioIniPrestacao": PlutoCell(value: cteCabecalhoModel?.nomeMunicipioIniPrestacao ?? ''),
			"ufIniPrestacao": PlutoCell(value: cteCabecalhoModel?.ufIniPrestacao ?? ''),
			"codigoMunicipioFimPrestacao": PlutoCell(value: cteCabecalhoModel?.codigoMunicipioFimPrestacao ?? 0),
			"nomeMunicipioFimPrestacao": PlutoCell(value: cteCabecalhoModel?.nomeMunicipioFimPrestacao ?? ''),
			"ufFimPrestacao": PlutoCell(value: cteCabecalhoModel?.ufFimPrestacao ?? ''),
			"retira": PlutoCell(value: cteCabecalhoModel?.retira ?? ''),
			"retiraDetalhe": PlutoCell(value: cteCabecalhoModel?.retiraDetalhe ?? ''),
			"tomador": PlutoCell(value: cteCabecalhoModel?.tomador ?? ''),
			"dataEntradaContingencia": PlutoCell(value: cteCabecalhoModel?.dataEntradaContingencia ?? ''),
			"justificativaContingencia": PlutoCell(value: cteCabecalhoModel?.justificativaContingencia ?? ''),
			"caracAdicionalTransporte": PlutoCell(value: cteCabecalhoModel?.caracAdicionalTransporte ?? ''),
			"caracAdicionalServico": PlutoCell(value: cteCabecalhoModel?.caracAdicionalServico ?? ''),
			"funcionarioEmissor": PlutoCell(value: cteCabecalhoModel?.funcionarioEmissor ?? ''),
			"fluxoOrigem": PlutoCell(value: cteCabecalhoModel?.fluxoOrigem ?? ''),
			"entregaTipoPeriodo": PlutoCell(value: cteCabecalhoModel?.entregaTipoPeriodo ?? ''),
			"entregaDataProgramada": PlutoCell(value: cteCabecalhoModel?.entregaDataProgramada ?? ''),
			"entregaDataInicial": PlutoCell(value: cteCabecalhoModel?.entregaDataInicial ?? ''),
			"entregaDataFinal": PlutoCell(value: cteCabecalhoModel?.entregaDataFinal ?? ''),
			"entregaTipoHora": PlutoCell(value: cteCabecalhoModel?.entregaTipoHora ?? ''),
			"entregaHoraProgramada": PlutoCell(value: cteCabecalhoModel?.entregaHoraProgramada ?? ''),
			"entregaHoraInicial": PlutoCell(value: cteCabecalhoModel?.entregaHoraInicial ?? ''),
			"entregaHoraFinal": PlutoCell(value: cteCabecalhoModel?.entregaHoraFinal ?? ''),
			"municipioOrigemCalculo": PlutoCell(value: cteCabecalhoModel?.municipioOrigemCalculo ?? ''),
			"municipioDestinoCalculo": PlutoCell(value: cteCabecalhoModel?.municipioDestinoCalculo ?? ''),
			"observacoesGerais": PlutoCell(value: cteCabecalhoModel?.observacoesGerais ?? ''),
			"valorTotalServico": PlutoCell(value: cteCabecalhoModel?.valorTotalServico ?? 0),
			"valorReceber": PlutoCell(value: cteCabecalhoModel?.valorReceber ?? 0),
			"cst": PlutoCell(value: cteCabecalhoModel?.cst ?? ''),
			"baseCalculoIcms": PlutoCell(value: cteCabecalhoModel?.baseCalculoIcms ?? 0),
			"aliquotaIcms": PlutoCell(value: cteCabecalhoModel?.aliquotaIcms ?? 0),
			"valorIcms": PlutoCell(value: cteCabecalhoModel?.valorIcms ?? 0),
			"percentualReducaoBcIcms": PlutoCell(value: cteCabecalhoModel?.percentualReducaoBcIcms ?? 0),
			"valorBcIcmsStRetido": PlutoCell(value: cteCabecalhoModel?.valorBcIcmsStRetido ?? 0),
			"valorIcmsStRetido": PlutoCell(value: cteCabecalhoModel?.valorIcmsStRetido ?? 0),
			"aliquotaIcmsStRetido": PlutoCell(value: cteCabecalhoModel?.aliquotaIcmsStRetido ?? 0),
			"valorCreditoPresumidoIcms": PlutoCell(value: cteCabecalhoModel?.valorCreditoPresumidoIcms ?? 0),
			"percentualBcIcmsOutraUf": PlutoCell(value: cteCabecalhoModel?.percentualBcIcmsOutraUf ?? 0),
			"valorBcIcmsOutraUf": PlutoCell(value: cteCabecalhoModel?.valorBcIcmsOutraUf ?? 0),
			"aliquotaIcmsOutraUf": PlutoCell(value: cteCabecalhoModel?.aliquotaIcmsOutraUf ?? 0),
			"valorIcmsOutraUf": PlutoCell(value: cteCabecalhoModel?.valorIcmsOutraUf ?? 0),
			"simplesNacionalIndicador": PlutoCell(value: cteCabecalhoModel?.simplesNacionalIndicador ?? ''),
			"simplesNacionalTotal": PlutoCell(value: cteCabecalhoModel?.simplesNacionalTotal ?? 0),
			"informacoesAddFisco": PlutoCell(value: cteCabecalhoModel?.informacoesAddFisco ?? ''),
			"valorTotalCarga": PlutoCell(value: cteCabecalhoModel?.valorTotalCarga ?? 0),
			"produtoPredominante": PlutoCell(value: cteCabecalhoModel?.produtoPredominante ?? ''),
			"cargaOutrasCaracteristicas": PlutoCell(value: cteCabecalhoModel?.cargaOutrasCaracteristicas ?? ''),
			"modalVersaoLayout": PlutoCell(value: cteCabecalhoModel?.modalVersaoLayout ?? 0),
			"chaveCteSubstituido": PlutoCell(value: cteCabecalhoModel?.chaveCteSubstituido ?? ''),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _cteCabecalhoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			cteCabecalhoModel.plutoRowToObject(plutoRow);
		} else {
			cteCabecalhoModel = modelFromRow[0];
			_cteCabecalhoModelOld = cteCabecalhoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [CT-e]';
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
		await Get.find<CteCabecalhoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await cteCabecalhoRepository.getList(filter: filter).then( (data){ _cteCabecalhoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'CT-e',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			naturezaOperacaoController.text = currentRow.cells['naturezaOperacao']?.value ?? '';
			chaveAcessoController.text = currentRow.cells['chaveAcesso']?.value ?? '';
			digitoChaveAcessoController.text = currentRow.cells['digitoChaveAcesso']?.value ?? '';
			codigoNumericoController.text = currentRow.cells['codigoNumerico']?.value ?? '';
			serieController.text = currentRow.cells['serie']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			cfopController.text = currentRow.cells['cfop']?.value?.toString() ?? '';
			versaoProcessoEmissaoController.text = currentRow.cells['versaoProcessoEmissao']?.value ?? '';
			chaveReferenciadoController.text = currentRow.cells['chaveReferenciado']?.value ?? '';
			codigoMunicipioEnvioController.text = currentRow.cells['codigoMunicipioEnvio']?.value?.toString() ?? '';
			nomeMunicipioEnvioController.text = currentRow.cells['nomeMunicipioEnvio']?.value ?? '';
			codigoMunicipioIniPrestacaoController.text = currentRow.cells['codigoMunicipioIniPrestacao']?.value?.toString() ?? '';
			nomeMunicipioIniPrestacaoController.text = currentRow.cells['nomeMunicipioIniPrestacao']?.value ?? '';
			codigoMunicipioFimPrestacaoController.text = currentRow.cells['codigoMunicipioFimPrestacao']?.value?.toString() ?? '';
			nomeMunicipioFimPrestacaoController.text = currentRow.cells['nomeMunicipioFimPrestacao']?.value ?? '';
			retiraDetalheController.text = currentRow.cells['retiraDetalhe']?.value ?? '';
			justificativaContingenciaController.text = currentRow.cells['justificativaContingencia']?.value ?? '';
			caracAdicionalTransporteController.text = currentRow.cells['caracAdicionalTransporte']?.value ?? '';
			caracAdicionalServicoController.text = currentRow.cells['caracAdicionalServico']?.value ?? '';
			funcionarioEmissorController.text = currentRow.cells['funcionarioEmissor']?.value ?? '';
			fluxoOrigemController.text = currentRow.cells['fluxoOrigem']?.value ?? '';
			entregaHoraProgramadaController.text = currentRow.cells['entregaHoraProgramada']?.value ?? '';
			entregaHoraInicialController.text = currentRow.cells['entregaHoraInicial']?.value ?? '';
			entregaHoraFinalController.text = currentRow.cells['entregaHoraFinal']?.value ?? '';
			municipioOrigemCalculoController.text = currentRow.cells['municipioOrigemCalculo']?.value ?? '';
			municipioDestinoCalculoController.text = currentRow.cells['municipioDestinoCalculo']?.value ?? '';
			observacoesGeraisController.text = currentRow.cells['observacoesGerais']?.value ?? '';
			valorTotalServicoController.text = currentRow.cells['valorTotalServico']?.value?.toStringAsFixed(2) ?? '';
			valorReceberController.text = currentRow.cells['valorReceber']?.value?.toStringAsFixed(2) ?? '';
			cstController.text = currentRow.cells['cst']?.value ?? '';
			baseCalculoIcmsController.text = currentRow.cells['baseCalculoIcms']?.value?.toStringAsFixed(2) ?? '';
			aliquotaIcmsController.text = currentRow.cells['aliquotaIcms']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsController.text = currentRow.cells['valorIcms']?.value?.toStringAsFixed(2) ?? '';
			percentualReducaoBcIcmsController.text = currentRow.cells['percentualReducaoBcIcms']?.value?.toStringAsFixed(2) ?? '';
			valorBcIcmsStRetidoController.text = currentRow.cells['valorBcIcmsStRetido']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsStRetidoController.text = currentRow.cells['valorIcmsStRetido']?.value?.toStringAsFixed(2) ?? '';
			aliquotaIcmsStRetidoController.text = currentRow.cells['aliquotaIcmsStRetido']?.value?.toStringAsFixed(2) ?? '';
			valorCreditoPresumidoIcmsController.text = currentRow.cells['valorCreditoPresumidoIcms']?.value?.toStringAsFixed(2) ?? '';
			percentualBcIcmsOutraUfController.text = currentRow.cells['percentualBcIcmsOutraUf']?.value?.toStringAsFixed(2) ?? '';
			valorBcIcmsOutraUfController.text = currentRow.cells['valorBcIcmsOutraUf']?.value?.toStringAsFixed(2) ?? '';
			aliquotaIcmsOutraUfController.text = currentRow.cells['aliquotaIcmsOutraUf']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsOutraUfController.text = currentRow.cells['valorIcmsOutraUf']?.value?.toStringAsFixed(2) ?? '';
			simplesNacionalTotalController.text = currentRow.cells['simplesNacionalTotal']?.value?.toStringAsFixed(2) ?? '';
			informacoesAddFiscoController.text = currentRow.cells['informacoesAddFisco']?.value ?? '';
			valorTotalCargaController.text = currentRow.cells['valorTotalCarga']?.value?.toStringAsFixed(2) ?? '';
			produtoPredominanteController.text = currentRow.cells['produtoPredominante']?.value ?? '';
			cargaOutrasCaracteristicasController.text = currentRow.cells['cargaOutrasCaracteristicas']?.value ?? '';
			modalVersaoLayoutController.text = currentRow.cells['modalVersaoLayout']?.value?.toString() ?? '';
			chaveCteSubstituidoController.text = currentRow.cells['chaveCteSubstituido']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Emitente
			Get.put<CteEmitenteController>(CteEmitenteController()); 
			final cteEmitenteController = Get.find<CteEmitenteController>(); 
			cteEmitenteController.cteEmitenteModelList = cteCabecalhoModel.cteEmitenteModelList!; 
			cteEmitenteController.userMadeChanges = false; 

			//Local Coleta
			Get.put<CteLocalColetaController>(CteLocalColetaController()); 
			final cteLocalColetaController = Get.find<CteLocalColetaController>(); 
			cteLocalColetaController.cteLocalColetaModelList = cteCabecalhoModel.cteLocalColetaModelList!; 
			cteLocalColetaController.userMadeChanges = false; 

			//Tomador
			Get.put<CteTomadorController>(CteTomadorController()); 
			final cteTomadorController = Get.find<CteTomadorController>(); 
			cteTomadorController.cteTomadorModelList = cteCabecalhoModel.cteTomadorModelList!; 
			cteTomadorController.userMadeChanges = false; 

			//Passagem
			Get.put<CtePassagemController>(CtePassagemController()); 
			final ctePassagemController = Get.find<CtePassagemController>(); 
			ctePassagemController.ctePassagemModelList = cteCabecalhoModel.ctePassagemModelList!; 
			ctePassagemController.userMadeChanges = false; 

			//Remetente
			Get.put<CteRemetenteController>(CteRemetenteController()); 
			final cteRemetenteController = Get.find<CteRemetenteController>(); 
			cteRemetenteController.cteRemetenteModelList = cteCabecalhoModel.cteRemetenteModelList!; 
			cteRemetenteController.userMadeChanges = false; 

			//Expedidor
			Get.put<CteExpedidorController>(CteExpedidorController()); 
			final cteExpedidorController = Get.find<CteExpedidorController>(); 
			cteExpedidorController.cteExpedidorModelList = cteCabecalhoModel.cteExpedidorModelList!; 
			cteExpedidorController.userMadeChanges = false; 

			//Recebedor
			Get.put<CteRecebedorController>(CteRecebedorController()); 
			final cteRecebedorController = Get.find<CteRecebedorController>(); 
			cteRecebedorController.cteRecebedorModelList = cteCabecalhoModel.cteRecebedorModelList!; 
			cteRecebedorController.userMadeChanges = false; 

			//Destinatário
			Get.put<CteDestinatarioController>(CteDestinatarioController()); 
			final cteDestinatarioController = Get.find<CteDestinatarioController>(); 
			cteDestinatarioController.cteDestinatarioModelList = cteCabecalhoModel.cteDestinatarioModelList!; 
			cteDestinatarioController.userMadeChanges = false; 

			//Local Entrega
			Get.put<CteLocalEntregaController>(CteLocalEntregaController()); 
			final cteLocalEntregaController = Get.find<CteLocalEntregaController>(); 
			cteLocalEntregaController.cteLocalEntregaModelList = cteCabecalhoModel.cteLocalEntregaModelList!; 
			cteLocalEntregaController.userMadeChanges = false; 

			//Componente
			Get.put<CteComponenteController>(CteComponenteController()); 
			final cteComponenteController = Get.find<CteComponenteController>(); 
			cteComponenteController.cteComponenteModelList = cteCabecalhoModel.cteComponenteModelList!; 
			cteComponenteController.userMadeChanges = false; 

			//Carga
			Get.put<CteCargaController>(CteCargaController()); 
			final cteCargaController = Get.find<CteCargaController>(); 
			cteCargaController.cteCargaModelList = cteCabecalhoModel.cteCargaModelList!; 
			cteCargaController.userMadeChanges = false; 

			//NF Outros
			Get.put<CteInformacaoNfOutrosController>(CteInformacaoNfOutrosController()); 
			final cteInformacaoNfOutrosController = Get.find<CteInformacaoNfOutrosController>(); 
			cteInformacaoNfOutrosController.cteInformacaoNfOutrosModelList = cteCabecalhoModel.cteInformacaoNfOutrosModelList!; 
			cteInformacaoNfOutrosController.userMadeChanges = false; 

			//Seguro
			Get.put<CteSeguroController>(CteSeguroController()); 
			final cteSeguroController = Get.find<CteSeguroController>(); 
			cteSeguroController.cteSeguroModelList = cteCabecalhoModel.cteSeguroModelList!; 
			cteSeguroController.userMadeChanges = false; 

			//Perigoso
			Get.put<CtePerigosoController>(CtePerigosoController()); 
			final ctePerigosoController = Get.find<CtePerigosoController>(); 
			ctePerigosoController.ctePerigosoModelList = cteCabecalhoModel.ctePerigosoModelList!; 
			ctePerigosoController.userMadeChanges = false; 

			//Veículo Novo
			Get.put<CteVeiculoNovoController>(CteVeiculoNovoController()); 
			final cteVeiculoNovoController = Get.find<CteVeiculoNovoController>(); 
			cteVeiculoNovoController.cteVeiculoNovoModelList = cteCabecalhoModel.cteVeiculoNovoModelList!; 
			cteVeiculoNovoController.userMadeChanges = false; 

			//Fatura
			Get.put<CteFaturaController>(CteFaturaController()); 
			final cteFaturaController = Get.find<CteFaturaController>(); 
			cteFaturaController.cteFaturaModelList = cteCabecalhoModel.cteFaturaModelList!; 
			cteFaturaController.userMadeChanges = false; 

			//Duplicata
			Get.put<CteDuplicataController>(CteDuplicataController()); 
			final cteDuplicataController = Get.find<CteDuplicataController>(); 
			cteDuplicataController.cteDuplicataModelList = cteCabecalhoModel.cteDuplicataModelList!; 
			cteDuplicataController.userMadeChanges = false; 

			//Rodoviário
			Get.put<CteRodoviarioController>(CteRodoviarioController()); 
			final cteRodoviarioController = Get.find<CteRodoviarioController>(); 
			cteRodoviarioController.cteRodoviarioModelList = cteCabecalhoModel.cteRodoviarioModelList!; 
			cteRodoviarioController.userMadeChanges = false; 

			//Aéreo
			Get.put<CteAereoController>(CteAereoController()); 
			final cteAereoController = Get.find<CteAereoController>(); 
			cteAereoController.cteAereoModelList = cteCabecalhoModel.cteAereoModelList!; 
			cteAereoController.userMadeChanges = false; 

			//Aquaviário
			Get.put<CteAquaviarioController>(CteAquaviarioController()); 
			final cteAquaviarioController = Get.find<CteAquaviarioController>(); 
			cteAquaviarioController.cteAquaviarioModelList = cteCabecalhoModel.cteAquaviarioModelList!; 
			cteAquaviarioController.userMadeChanges = false; 

			//Ferroviário
			Get.put<CteFerroviarioController>(CteFerroviarioController()); 
			final cteFerroviarioController = Get.find<CteFerroviarioController>(); 
			cteFerroviarioController.cteFerroviarioModelList = cteCabecalhoModel.cteFerroviarioModelList!; 
			cteFerroviarioController.userMadeChanges = false; 

			//Dutoviário
			Get.put<CteDutoviarioController>(CteDutoviarioController()); 
			final cteDutoviarioController = Get.find<CteDutoviarioController>(); 
			cteDutoviarioController.cteDutoviarioModelList = cteCabecalhoModel.cteDutoviarioModelList!; 
			cteDutoviarioController.userMadeChanges = false; 

			//Multimodal
			Get.put<CteMultimodalController>(CteMultimodalController()); 
			final cteMultimodalController = Get.find<CteMultimodalController>(); 
			cteMultimodalController.cteMultimodalModelList = cteCabecalhoModel.cteMultimodalModelList!; 
			cteMultimodalController.userMadeChanges = false; 


			Get.toNamed(Routes.cteCabecalhoTabPage)!.then((value) {
				if (cteCabecalhoModel.id == 0) {
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
		cteCabecalhoModel = CteCabecalhoModel();
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
				if (await cteCabecalhoRepository.delete(id: currentRow.cells['id']!.value)) {
					_cteCabecalhoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final naturezaOperacaoController = TextEditingController();
	final chaveAcessoController = TextEditingController();
	final digitoChaveAcessoController = TextEditingController();
	final codigoNumericoController = TextEditingController();
	final serieController = TextEditingController();
	final numeroController = TextEditingController();
	final cfopController = TextEditingController();
	final versaoProcessoEmissaoController = TextEditingController();
	final chaveReferenciadoController = TextEditingController();
	final codigoMunicipioEnvioController = TextEditingController();
	final nomeMunicipioEnvioController = TextEditingController();
	final codigoMunicipioIniPrestacaoController = TextEditingController();
	final nomeMunicipioIniPrestacaoController = TextEditingController();
	final codigoMunicipioFimPrestacaoController = TextEditingController();
	final nomeMunicipioFimPrestacaoController = TextEditingController();
	final retiraDetalheController = TextEditingController();
	final justificativaContingenciaController = TextEditingController();
	final caracAdicionalTransporteController = TextEditingController();
	final caracAdicionalServicoController = TextEditingController();
	final funcionarioEmissorController = TextEditingController();
	final fluxoOrigemController = TextEditingController();
	final entregaHoraProgramadaController = TextEditingController();
	final entregaHoraInicialController = TextEditingController();
	final entregaHoraFinalController = TextEditingController();
	final municipioOrigemCalculoController = TextEditingController();
	final municipioDestinoCalculoController = TextEditingController();
	final observacoesGeraisController = TextEditingController();
	final valorTotalServicoController = MoneyMaskedTextController();
	final valorReceberController = MoneyMaskedTextController();
	final cstController = TextEditingController();
	final baseCalculoIcmsController = MoneyMaskedTextController();
	final aliquotaIcmsController = MoneyMaskedTextController();
	final valorIcmsController = MoneyMaskedTextController();
	final percentualReducaoBcIcmsController = MoneyMaskedTextController();
	final valorBcIcmsStRetidoController = MoneyMaskedTextController();
	final valorIcmsStRetidoController = MoneyMaskedTextController();
	final aliquotaIcmsStRetidoController = MoneyMaskedTextController();
	final valorCreditoPresumidoIcmsController = MoneyMaskedTextController();
	final percentualBcIcmsOutraUfController = MoneyMaskedTextController();
	final valorBcIcmsOutraUfController = MoneyMaskedTextController();
	final aliquotaIcmsOutraUfController = MoneyMaskedTextController();
	final valorIcmsOutraUfController = MoneyMaskedTextController();
	final simplesNacionalTotalController = MoneyMaskedTextController();
	final informacoesAddFiscoController = TextEditingController();
	final valorTotalCargaController = MoneyMaskedTextController();
	final produtoPredominanteController = TextEditingController();
	final cargaOutrasCaracteristicasController = TextEditingController();
	final modalVersaoLayoutController = TextEditingController();
	final chaveCteSubstituidoController = TextEditingController();

	final cteCabecalhoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final cteCabecalhoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final cteCabecalhoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteCabecalhoModel.id;
		plutoRow.cells['naturezaOperacao']?.value = cteCabecalhoModel.naturezaOperacao;
		plutoRow.cells['chaveAcesso']?.value = cteCabecalhoModel.chaveAcesso;
		plutoRow.cells['digitoChaveAcesso']?.value = cteCabecalhoModel.digitoChaveAcesso;
		plutoRow.cells['codigoNumerico']?.value = cteCabecalhoModel.codigoNumerico;
		plutoRow.cells['serie']?.value = cteCabecalhoModel.serie;
		plutoRow.cells['numero']?.value = cteCabecalhoModel.numero;
		plutoRow.cells['dataHoraEmissao']?.value = Util.formatDate(cteCabecalhoModel.dataHoraEmissao);
		plutoRow.cells['ufEmitente']?.value = cteCabecalhoModel.ufEmitente;
		plutoRow.cells['cfop']?.value = cteCabecalhoModel.cfop;
		plutoRow.cells['formaPagamento']?.value = cteCabecalhoModel.formaPagamento;
		plutoRow.cells['modelo']?.value = cteCabecalhoModel.modelo;
		plutoRow.cells['formatoImpressaoDacte']?.value = cteCabecalhoModel.formatoImpressaoDacte;
		plutoRow.cells['tipoEmissao']?.value = cteCabecalhoModel.tipoEmissao;
		plutoRow.cells['ambiente']?.value = cteCabecalhoModel.ambiente;
		plutoRow.cells['tipoCte']?.value = cteCabecalhoModel.tipoCte;
		plutoRow.cells['processoEmissao']?.value = cteCabecalhoModel.processoEmissao;
		plutoRow.cells['versaoProcessoEmissao']?.value = cteCabecalhoModel.versaoProcessoEmissao;
		plutoRow.cells['chaveReferenciado']?.value = cteCabecalhoModel.chaveReferenciado;
		plutoRow.cells['codigoMunicipioEnvio']?.value = cteCabecalhoModel.codigoMunicipioEnvio;
		plutoRow.cells['nomeMunicipioEnvio']?.value = cteCabecalhoModel.nomeMunicipioEnvio;
		plutoRow.cells['ufEnvio']?.value = cteCabecalhoModel.ufEnvio;
		plutoRow.cells['modal']?.value = cteCabecalhoModel.modal;
		plutoRow.cells['tipoServico']?.value = cteCabecalhoModel.tipoServico;
		plutoRow.cells['codigoMunicipioIniPrestacao']?.value = cteCabecalhoModel.codigoMunicipioIniPrestacao;
		plutoRow.cells['nomeMunicipioIniPrestacao']?.value = cteCabecalhoModel.nomeMunicipioIniPrestacao;
		plutoRow.cells['ufIniPrestacao']?.value = cteCabecalhoModel.ufIniPrestacao;
		plutoRow.cells['codigoMunicipioFimPrestacao']?.value = cteCabecalhoModel.codigoMunicipioFimPrestacao;
		plutoRow.cells['nomeMunicipioFimPrestacao']?.value = cteCabecalhoModel.nomeMunicipioFimPrestacao;
		plutoRow.cells['ufFimPrestacao']?.value = cteCabecalhoModel.ufFimPrestacao;
		plutoRow.cells['retira']?.value = cteCabecalhoModel.retira;
		plutoRow.cells['retiraDetalhe']?.value = cteCabecalhoModel.retiraDetalhe;
		plutoRow.cells['tomador']?.value = cteCabecalhoModel.tomador;
		plutoRow.cells['dataEntradaContingencia']?.value = Util.formatDate(cteCabecalhoModel.dataEntradaContingencia);
		plutoRow.cells['justificativaContingencia']?.value = cteCabecalhoModel.justificativaContingencia;
		plutoRow.cells['caracAdicionalTransporte']?.value = cteCabecalhoModel.caracAdicionalTransporte;
		plutoRow.cells['caracAdicionalServico']?.value = cteCabecalhoModel.caracAdicionalServico;
		plutoRow.cells['funcionarioEmissor']?.value = cteCabecalhoModel.funcionarioEmissor;
		plutoRow.cells['fluxoOrigem']?.value = cteCabecalhoModel.fluxoOrigem;
		plutoRow.cells['entregaTipoPeriodo']?.value = cteCabecalhoModel.entregaTipoPeriodo;
		plutoRow.cells['entregaDataProgramada']?.value = Util.formatDate(cteCabecalhoModel.entregaDataProgramada);
		plutoRow.cells['entregaDataInicial']?.value = Util.formatDate(cteCabecalhoModel.entregaDataInicial);
		plutoRow.cells['entregaDataFinal']?.value = Util.formatDate(cteCabecalhoModel.entregaDataFinal);
		plutoRow.cells['entregaTipoHora']?.value = cteCabecalhoModel.entregaTipoHora;
		plutoRow.cells['entregaHoraProgramada']?.value = cteCabecalhoModel.entregaHoraProgramada;
		plutoRow.cells['entregaHoraInicial']?.value = cteCabecalhoModel.entregaHoraInicial;
		plutoRow.cells['entregaHoraFinal']?.value = cteCabecalhoModel.entregaHoraFinal;
		plutoRow.cells['municipioOrigemCalculo']?.value = cteCabecalhoModel.municipioOrigemCalculo;
		plutoRow.cells['municipioDestinoCalculo']?.value = cteCabecalhoModel.municipioDestinoCalculo;
		plutoRow.cells['observacoesGerais']?.value = cteCabecalhoModel.observacoesGerais;
		plutoRow.cells['valorTotalServico']?.value = cteCabecalhoModel.valorTotalServico;
		plutoRow.cells['valorReceber']?.value = cteCabecalhoModel.valorReceber;
		plutoRow.cells['cst']?.value = cteCabecalhoModel.cst;
		plutoRow.cells['baseCalculoIcms']?.value = cteCabecalhoModel.baseCalculoIcms;
		plutoRow.cells['aliquotaIcms']?.value = cteCabecalhoModel.aliquotaIcms;
		plutoRow.cells['valorIcms']?.value = cteCabecalhoModel.valorIcms;
		plutoRow.cells['percentualReducaoBcIcms']?.value = cteCabecalhoModel.percentualReducaoBcIcms;
		plutoRow.cells['valorBcIcmsStRetido']?.value = cteCabecalhoModel.valorBcIcmsStRetido;
		plutoRow.cells['valorIcmsStRetido']?.value = cteCabecalhoModel.valorIcmsStRetido;
		plutoRow.cells['aliquotaIcmsStRetido']?.value = cteCabecalhoModel.aliquotaIcmsStRetido;
		plutoRow.cells['valorCreditoPresumidoIcms']?.value = cteCabecalhoModel.valorCreditoPresumidoIcms;
		plutoRow.cells['percentualBcIcmsOutraUf']?.value = cteCabecalhoModel.percentualBcIcmsOutraUf;
		plutoRow.cells['valorBcIcmsOutraUf']?.value = cteCabecalhoModel.valorBcIcmsOutraUf;
		plutoRow.cells['aliquotaIcmsOutraUf']?.value = cteCabecalhoModel.aliquotaIcmsOutraUf;
		plutoRow.cells['valorIcmsOutraUf']?.value = cteCabecalhoModel.valorIcmsOutraUf;
		plutoRow.cells['simplesNacionalIndicador']?.value = cteCabecalhoModel.simplesNacionalIndicador;
		plutoRow.cells['simplesNacionalTotal']?.value = cteCabecalhoModel.simplesNacionalTotal;
		plutoRow.cells['informacoesAddFisco']?.value = cteCabecalhoModel.informacoesAddFisco;
		plutoRow.cells['valorTotalCarga']?.value = cteCabecalhoModel.valorTotalCarga;
		plutoRow.cells['produtoPredominante']?.value = cteCabecalhoModel.produtoPredominante;
		plutoRow.cells['cargaOutrasCaracteristicas']?.value = cteCabecalhoModel.cargaOutrasCaracteristicas;
		plutoRow.cells['modalVersaoLayout']?.value = cteCabecalhoModel.modalVersaoLayout;
		plutoRow.cells['chaveCteSubstituido']?.value = cteCabecalhoModel.chaveCteSubstituido;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await cteCabecalhoRepository.save(cteCabecalhoModel: cteCabecalhoModel); 
				if (result != null) {
					cteCabecalhoModel = result;
					if (_isInserting) {
						_cteCabecalhoModelList.add(cteCabecalhoModel);
						_isInserting = false;
					} else {
            _cteCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _cteCabecalhoModelList.add(cteCabecalhoModel);
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
		Get.find<CteEmitenteController>().userMadeChanges
		|| 
		Get.find<CteLocalColetaController>().userMadeChanges
		|| 
		Get.find<CteTomadorController>().userMadeChanges
		|| 
		Get.find<CtePassagemController>().userMadeChanges
		|| 
		Get.find<CteRemetenteController>().userMadeChanges
		|| 
		Get.find<CteExpedidorController>().userMadeChanges
		|| 
		Get.find<CteRecebedorController>().userMadeChanges
		|| 
		Get.find<CteDestinatarioController>().userMadeChanges
		|| 
		Get.find<CteLocalEntregaController>().userMadeChanges
		|| 
		Get.find<CteComponenteController>().userMadeChanges
		|| 
		Get.find<CteCargaController>().userMadeChanges
		|| 
		Get.find<CteInformacaoNfOutrosController>().userMadeChanges
		|| 
		Get.find<CteSeguroController>().userMadeChanges
		|| 
		Get.find<CtePerigosoController>().userMadeChanges
		|| 
		Get.find<CteVeiculoNovoController>().userMadeChanges
		|| 
		Get.find<CteFaturaController>().userMadeChanges
		|| 
		Get.find<CteDuplicataController>().userMadeChanges
		|| 
		Get.find<CteRodoviarioController>().userMadeChanges
		|| 
		Get.find<CteAereoController>().userMadeChanges
		|| 
		Get.find<CteAquaviarioController>().userMadeChanges
		|| 
		Get.find<CteFerroviarioController>().userMadeChanges
		|| 
		Get.find<CteDutoviarioController>().userMadeChanges
		|| 
		Get.find<CteMultimodalController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_cteCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_cteCabecalhoModelList.add(_cteCabecalhoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
		return true;
	}


	// override
	@override
	void onInit() {
		bootstrapGridParameters(
			gutterSize: Constants.flutterBootstrapGutterSize,
		);
		tabController = TabController(vsync: this, length: tabItems.length);
		functionName = "cte_cabecalho";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		naturezaOperacaoController.dispose();
		chaveAcessoController.dispose();
		digitoChaveAcessoController.dispose();
		codigoNumericoController.dispose();
		serieController.dispose();
		numeroController.dispose();
		cfopController.dispose();
		versaoProcessoEmissaoController.dispose();
		chaveReferenciadoController.dispose();
		codigoMunicipioEnvioController.dispose();
		nomeMunicipioEnvioController.dispose();
		codigoMunicipioIniPrestacaoController.dispose();
		nomeMunicipioIniPrestacaoController.dispose();
		codigoMunicipioFimPrestacaoController.dispose();
		nomeMunicipioFimPrestacaoController.dispose();
		retiraDetalheController.dispose();
		justificativaContingenciaController.dispose();
		caracAdicionalTransporteController.dispose();
		caracAdicionalServicoController.dispose();
		funcionarioEmissorController.dispose();
		fluxoOrigemController.dispose();
		entregaHoraProgramadaController.dispose();
		entregaHoraInicialController.dispose();
		entregaHoraFinalController.dispose();
		municipioOrigemCalculoController.dispose();
		municipioDestinoCalculoController.dispose();
		observacoesGeraisController.dispose();
		valorTotalServicoController.dispose();
		valorReceberController.dispose();
		cstController.dispose();
		baseCalculoIcmsController.dispose();
		aliquotaIcmsController.dispose();
		valorIcmsController.dispose();
		percentualReducaoBcIcmsController.dispose();
		valorBcIcmsStRetidoController.dispose();
		valorIcmsStRetidoController.dispose();
		aliquotaIcmsStRetidoController.dispose();
		valorCreditoPresumidoIcmsController.dispose();
		percentualBcIcmsOutraUfController.dispose();
		valorBcIcmsOutraUfController.dispose();
		aliquotaIcmsOutraUfController.dispose();
		valorIcmsOutraUfController.dispose();
		simplesNacionalTotalController.dispose();
		informacoesAddFiscoController.dispose();
		valorTotalCargaController.dispose();
		produtoPredominanteController.dispose();
		cargaOutrasCaracteristicasController.dispose();
		modalVersaoLayoutController.dispose();
		chaveCteSubstituidoController.dispose();
		super.onClose();
	}
}