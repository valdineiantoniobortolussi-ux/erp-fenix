import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteInformacaoNfOutrosModel {
	int? id;
	int? idCteCabecalho;
	String? numeroRomaneio;
	String? numeroPedido;
	String? chaveAcessoNfe;
	String? codigoModelo;
	String? serie;
	String? numero;
	DateTime? dataEmissao;
	int? ufEmitente;
	double? baseCalculoIcms;
	double? valorIcms;
	double? baseCalculoIcmsSt;
	double? valorIcmsSt;
	double? valorTotalProdutos;
	double? valorTotal;
	int? cfopPredominante;
	double? pesoTotalKg;
	int? pinSuframa;
	DateTime? dataPrevistaEntrega;
	String? outroTipoDocOrig;
	String? outroDescricao;
	double? outroValorDocumento;

	CteInformacaoNfOutrosModel({
		this.id,
		this.idCteCabecalho,
		this.numeroRomaneio,
		this.numeroPedido,
		this.chaveAcessoNfe,
		this.codigoModelo,
		this.serie,
		this.numero,
		this.dataEmissao,
		this.ufEmitente,
		this.baseCalculoIcms,
		this.valorIcms,
		this.baseCalculoIcmsSt,
		this.valorIcmsSt,
		this.valorTotalProdutos,
		this.valorTotal,
		this.cfopPredominante,
		this.pesoTotalKg,
		this.pinSuframa,
		this.dataPrevistaEntrega,
		this.outroTipoDocOrig,
		this.outroDescricao,
		this.outroValorDocumento,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero_romaneio',
		'numero_pedido',
		'chave_acesso_nfe',
		'codigo_modelo',
		'serie',
		'numero',
		'data_emissao',
		'uf_emitente',
		'base_calculo_icms',
		'valor_icms',
		'base_calculo_icms_st',
		'valor_icms_st',
		'valor_total_produtos',
		'valor_total',
		'cfop_predominante',
		'peso_total_kg',
		'pin_suframa',
		'data_prevista_entrega',
		'outro_tipo_doc_orig',
		'outro_descricao',
		'outro_valor_documento',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero Romaneio',
		'Numero Pedido',
		'Chave Acesso Nfe',
		'Codigo Modelo',
		'Serie',
		'Numero',
		'Data Emissao',
		'Uf Emitente',
		'Base Calculo Icms',
		'Valor Icms',
		'Base Calculo Icms St',
		'Valor Icms St',
		'Valor Total Produtos',
		'Valor Total',
		'Cfop Predominante',
		'Peso Total Kg',
		'Pin Suframa',
		'Data Prevista Entrega',
		'Outro Tipo Doc Orig',
		'Outro Descricao',
		'Outro Valor Documento',
	];

	CteInformacaoNfOutrosModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteCabecalho = jsonData['idCteCabecalho'];
		numeroRomaneio = jsonData['numeroRomaneio'];
		numeroPedido = jsonData['numeroPedido'];
		chaveAcessoNfe = jsonData['chaveAcessoNfe'];
		codigoModelo = CteInformacaoNfOutrosDomain.getCodigoModelo(jsonData['codigoModelo']);
		serie = CteInformacaoNfOutrosDomain.getSerie(jsonData['serie']);
		numero = jsonData['numero'];
		dataEmissao = jsonData['dataEmissao'] != null ? DateTime.tryParse(jsonData['dataEmissao']) : null;
		ufEmitente = jsonData['ufEmitente'];
		baseCalculoIcms = jsonData['baseCalculoIcms']?.toDouble();
		valorIcms = jsonData['valorIcms']?.toDouble();
		baseCalculoIcmsSt = jsonData['baseCalculoIcmsSt']?.toDouble();
		valorIcmsSt = jsonData['valorIcmsSt']?.toDouble();
		valorTotalProdutos = jsonData['valorTotalProdutos']?.toDouble();
		valorTotal = jsonData['valorTotal']?.toDouble();
		cfopPredominante = jsonData['cfopPredominante'];
		pesoTotalKg = jsonData['pesoTotalKg']?.toDouble();
		pinSuframa = jsonData['pinSuframa'];
		dataPrevistaEntrega = jsonData['dataPrevistaEntrega'] != null ? DateTime.tryParse(jsonData['dataPrevistaEntrega']) : null;
		outroTipoDocOrig = CteInformacaoNfOutrosDomain.getOutroTipoDocOrig(jsonData['outroTipoDocOrig']);
		outroDescricao = jsonData['outroDescricao'];
		outroValorDocumento = jsonData['outroValorDocumento']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteCabecalho'] = idCteCabecalho != 0 ? idCteCabecalho : null;
		jsonData['numeroRomaneio'] = numeroRomaneio;
		jsonData['numeroPedido'] = numeroPedido;
		jsonData['chaveAcessoNfe'] = chaveAcessoNfe;
		jsonData['codigoModelo'] = CteInformacaoNfOutrosDomain.setCodigoModelo(codigoModelo);
		jsonData['serie'] = CteInformacaoNfOutrosDomain.setSerie(serie);
		jsonData['numero'] = numero;
		jsonData['dataEmissao'] = dataEmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEmissao!) : null;
		jsonData['ufEmitente'] = ufEmitente;
		jsonData['baseCalculoIcms'] = baseCalculoIcms;
		jsonData['valorIcms'] = valorIcms;
		jsonData['baseCalculoIcmsSt'] = baseCalculoIcmsSt;
		jsonData['valorIcmsSt'] = valorIcmsSt;
		jsonData['valorTotalProdutos'] = valorTotalProdutos;
		jsonData['valorTotal'] = valorTotal;
		jsonData['cfopPredominante'] = cfopPredominante;
		jsonData['pesoTotalKg'] = pesoTotalKg;
		jsonData['pinSuframa'] = pinSuframa;
		jsonData['dataPrevistaEntrega'] = dataPrevistaEntrega != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataPrevistaEntrega!) : null;
		jsonData['outroTipoDocOrig'] = CteInformacaoNfOutrosDomain.setOutroTipoDocOrig(outroTipoDocOrig);
		jsonData['outroDescricao'] = outroDescricao;
		jsonData['outroValorDocumento'] = outroValorDocumento;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteCabecalho = plutoRow.cells['idCteCabecalho']?.value;
		numeroRomaneio = plutoRow.cells['numeroRomaneio']?.value;
		numeroPedido = plutoRow.cells['numeroPedido']?.value;
		chaveAcessoNfe = plutoRow.cells['chaveAcessoNfe']?.value;
		codigoModelo = plutoRow.cells['codigoModelo']?.value != '' ? plutoRow.cells['codigoModelo']?.value : 'AAA';
		serie = plutoRow.cells['serie']?.value != '' ? plutoRow.cells['serie']?.value : 'AAA';
		numero = plutoRow.cells['numero']?.value;
		dataEmissao = Util.stringToDate(plutoRow.cells['dataEmissao']?.value);
		ufEmitente = plutoRow.cells['ufEmitente']?.value;
		baseCalculoIcms = plutoRow.cells['baseCalculoIcms']?.value?.toDouble();
		valorIcms = plutoRow.cells['valorIcms']?.value?.toDouble();
		baseCalculoIcmsSt = plutoRow.cells['baseCalculoIcmsSt']?.value?.toDouble();
		valorIcmsSt = plutoRow.cells['valorIcmsSt']?.value?.toDouble();
		valorTotalProdutos = plutoRow.cells['valorTotalProdutos']?.value?.toDouble();
		valorTotal = plutoRow.cells['valorTotal']?.value?.toDouble();
		cfopPredominante = plutoRow.cells['cfopPredominante']?.value;
		pesoTotalKg = plutoRow.cells['pesoTotalKg']?.value?.toDouble();
		pinSuframa = plutoRow.cells['pinSuframa']?.value;
		dataPrevistaEntrega = Util.stringToDate(plutoRow.cells['dataPrevistaEntrega']?.value);
		outroTipoDocOrig = plutoRow.cells['outroTipoDocOrig']?.value != '' ? plutoRow.cells['outroTipoDocOrig']?.value : 'AAA';
		outroDescricao = plutoRow.cells['outroDescricao']?.value;
		outroValorDocumento = plutoRow.cells['outroValorDocumento']?.value?.toDouble();
	}	

	CteInformacaoNfOutrosModel clone() {
		return CteInformacaoNfOutrosModel(
			id: id,
			idCteCabecalho: idCteCabecalho,
			numeroRomaneio: numeroRomaneio,
			numeroPedido: numeroPedido,
			chaveAcessoNfe: chaveAcessoNfe,
			codigoModelo: codigoModelo,
			serie: serie,
			numero: numero,
			dataEmissao: dataEmissao,
			ufEmitente: ufEmitente,
			baseCalculoIcms: baseCalculoIcms,
			valorIcms: valorIcms,
			baseCalculoIcmsSt: baseCalculoIcmsSt,
			valorIcmsSt: valorIcmsSt,
			valorTotalProdutos: valorTotalProdutos,
			valorTotal: valorTotal,
			cfopPredominante: cfopPredominante,
			pesoTotalKg: pesoTotalKg,
			pinSuframa: pinSuframa,
			dataPrevistaEntrega: dataPrevistaEntrega,
			outroTipoDocOrig: outroTipoDocOrig,
			outroDescricao: outroDescricao,
			outroValorDocumento: outroValorDocumento,
		);			
	}

	
}