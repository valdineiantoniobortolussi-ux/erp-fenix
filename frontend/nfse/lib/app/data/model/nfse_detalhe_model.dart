import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfse/app/data/model/model_imports.dart';
import 'package:nfse/app/data/domain/domain_imports.dart';

class NfseDetalheModel {
	int? id;
	int? idNfseCabecalho;
	int? idNfseListaServico;
	String? codigoCnae;
	String? codigoTributacaoMunicipio;
	double? valorServicos;
	double? valorDeducoes;
	double? valorPis;
	double? valorCofins;
	double? valorInss;
	double? valorIr;
	double? valorCsll;
	double? valorBaseCalculo;
	double? aliquota;
	double? valorIss;
	double? valorLiquido;
	double? outrasRetencoes;
	double? valorCredito;
	String? issRetido;
	double? valorIssRetido;
	double? valorDescontoCondicionado;
	double? valorDescontoIncondicionado;
	int? municipioPrestacao;
	String? discriminacao;
	NfseListaServicoModel? nfseListaServicoModel;

	NfseDetalheModel({
		this.id,
		this.idNfseCabecalho,
		this.idNfseListaServico,
		this.codigoCnae,
		this.codigoTributacaoMunicipio,
		this.valorServicos,
		this.valorDeducoes,
		this.valorPis,
		this.valorCofins,
		this.valorInss,
		this.valorIr,
		this.valorCsll,
		this.valorBaseCalculo,
		this.aliquota,
		this.valorIss,
		this.valorLiquido,
		this.outrasRetencoes,
		this.valorCredito,
		this.issRetido,
		this.valorIssRetido,
		this.valorDescontoCondicionado,
		this.valorDescontoIncondicionado,
		this.municipioPrestacao,
		this.discriminacao,
		this.nfseListaServicoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo_cnae',
		'codigo_nfse_municipio',
		'valor_servicos',
		'valor_deducoes',
		'valor_pis',
		'valor_cofins',
		'valor_inss',
		'valor_ir',
		'valor_csll',
		'valor_base_calculo',
		'aliquota',
		'valor_iss',
		'valor_liquido',
		'outras_retencoes',
		'valor_credito',
		'iss_retido',
		'valor_iss_retido',
		'valor_desconto_condicionado',
		'valor_desconto_incondicionado',
		'municipio_prestacao',
		'discriminacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo Cnae',
		'Codigo Tributacao Municipio',
		'Valor Servicos',
		'Valor Deducoes',
		'Valor Pis',
		'Valor Cofins',
		'Valor Inss',
		'Valor Ir',
		'Valor Csll',
		'Valor Base Calculo',
		'Aliquota',
		'Valor Iss',
		'Valor Liquido',
		'Outras Retencoes',
		'Valor Credito',
		'Iss Retido',
		'Valor Iss Retido',
		'Valor Desconto Condicionado',
		'Valor Desconto Incondicionado',
		'Municipio Prestacao',
		'Discriminacao',
	];

	NfseDetalheModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfseCabecalho = jsonData['idNfseCabecalho'];
		idNfseListaServico = jsonData['idNfseListaServico'];
		codigoCnae = jsonData['codigoCnae'];
		codigoTributacaoMunicipio = jsonData['codigoTributacaoMunicipio'];
		valorServicos = jsonData['valorServicos']?.toDouble();
		valorDeducoes = jsonData['valorDeducoes']?.toDouble();
		valorPis = jsonData['valorPis']?.toDouble();
		valorCofins = jsonData['valorCofins']?.toDouble();
		valorInss = jsonData['valorInss']?.toDouble();
		valorIr = jsonData['valorIr']?.toDouble();
		valorCsll = jsonData['valorCsll']?.toDouble();
		valorBaseCalculo = jsonData['valorBaseCalculo']?.toDouble();
		aliquota = jsonData['aliquota']?.toDouble();
		valorIss = jsonData['valorIss']?.toDouble();
		valorLiquido = jsonData['valorLiquido']?.toDouble();
		outrasRetencoes = jsonData['outrasRetencoes']?.toDouble();
		valorCredito = jsonData['valorCredito']?.toDouble();
		issRetido = NfseDetalheDomain.getIssRetido(jsonData['issRetido']);
		valorIssRetido = jsonData['valorIssRetido']?.toDouble();
		valorDescontoCondicionado = jsonData['valorDescontoCondicionado']?.toDouble();
		valorDescontoIncondicionado = jsonData['valorDescontoIncondicionado']?.toDouble();
		municipioPrestacao = jsonData['municipioPrestacao'];
		discriminacao = jsonData['discriminacao'];
		nfseListaServicoModel = jsonData['nfseListaServicoModel'] == null ? NfseListaServicoModel() : NfseListaServicoModel.fromJson(jsonData['nfseListaServicoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfseCabecalho'] = idNfseCabecalho != 0 ? idNfseCabecalho : null;
		jsonData['idNfseListaServico'] = idNfseListaServico != 0 ? idNfseListaServico : null;
		jsonData['codigoCnae'] = codigoCnae;
		jsonData['codigoTributacaoMunicipio'] = codigoTributacaoMunicipio;
		jsonData['valorServicos'] = valorServicos;
		jsonData['valorDeducoes'] = valorDeducoes;
		jsonData['valorPis'] = valorPis;
		jsonData['valorCofins'] = valorCofins;
		jsonData['valorInss'] = valorInss;
		jsonData['valorIr'] = valorIr;
		jsonData['valorCsll'] = valorCsll;
		jsonData['valorBaseCalculo'] = valorBaseCalculo;
		jsonData['aliquota'] = aliquota;
		jsonData['valorIss'] = valorIss;
		jsonData['valorLiquido'] = valorLiquido;
		jsonData['outrasRetencoes'] = outrasRetencoes;
		jsonData['valorCredito'] = valorCredito;
		jsonData['issRetido'] = NfseDetalheDomain.setIssRetido(issRetido);
		jsonData['valorIssRetido'] = valorIssRetido;
		jsonData['valorDescontoCondicionado'] = valorDescontoCondicionado;
		jsonData['valorDescontoIncondicionado'] = valorDescontoIncondicionado;
		jsonData['municipioPrestacao'] = municipioPrestacao;
		jsonData['discriminacao'] = discriminacao;
		jsonData['nfseListaServicoModel'] = nfseListaServicoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfseCabecalho = plutoRow.cells['idNfseCabecalho']?.value;
		idNfseListaServico = plutoRow.cells['idNfseListaServico']?.value;
		codigoCnae = plutoRow.cells['codigoCnae']?.value;
		codigoTributacaoMunicipio = plutoRow.cells['codigoTributacaoMunicipio']?.value;
		valorServicos = plutoRow.cells['valorServicos']?.value?.toDouble();
		valorDeducoes = plutoRow.cells['valorDeducoes']?.value?.toDouble();
		valorPis = plutoRow.cells['valorPis']?.value?.toDouble();
		valorCofins = plutoRow.cells['valorCofins']?.value?.toDouble();
		valorInss = plutoRow.cells['valorInss']?.value?.toDouble();
		valorIr = plutoRow.cells['valorIr']?.value?.toDouble();
		valorCsll = plutoRow.cells['valorCsll']?.value?.toDouble();
		valorBaseCalculo = plutoRow.cells['valorBaseCalculo']?.value?.toDouble();
		aliquota = plutoRow.cells['aliquota']?.value?.toDouble();
		valorIss = plutoRow.cells['valorIss']?.value?.toDouble();
		valorLiquido = plutoRow.cells['valorLiquido']?.value?.toDouble();
		outrasRetencoes = plutoRow.cells['outrasRetencoes']?.value?.toDouble();
		valorCredito = plutoRow.cells['valorCredito']?.value?.toDouble();
		issRetido = plutoRow.cells['issRetido']?.value != '' ? plutoRow.cells['issRetido']?.value : 'S';
		valorIssRetido = plutoRow.cells['valorIssRetido']?.value?.toDouble();
		valorDescontoCondicionado = plutoRow.cells['valorDescontoCondicionado']?.value?.toDouble();
		valorDescontoIncondicionado = plutoRow.cells['valorDescontoIncondicionado']?.value?.toDouble();
		municipioPrestacao = plutoRow.cells['municipioPrestacao']?.value;
		discriminacao = plutoRow.cells['discriminacao']?.value;
		nfseListaServicoModel = NfseListaServicoModel();
		nfseListaServicoModel?.descricao = plutoRow.cells['nfseListaServicoModel']?.value;
	}	

	NfseDetalheModel clone() {
		return NfseDetalheModel(
			id: id,
			idNfseCabecalho: idNfseCabecalho,
			idNfseListaServico: idNfseListaServico,
			codigoCnae: codigoCnae,
			codigoTributacaoMunicipio: codigoTributacaoMunicipio,
			valorServicos: valorServicos,
			valorDeducoes: valorDeducoes,
			valorPis: valorPis,
			valorCofins: valorCofins,
			valorInss: valorInss,
			valorIr: valorIr,
			valorCsll: valorCsll,
			valorBaseCalculo: valorBaseCalculo,
			aliquota: aliquota,
			valorIss: valorIss,
			valorLiquido: valorLiquido,
			outrasRetencoes: outrasRetencoes,
			valorCredito: valorCredito,
			issRetido: issRetido,
			valorIssRetido: valorIssRetido,
			valorDescontoCondicionado: valorDescontoCondicionado,
			valorDescontoIncondicionado: valorDescontoIncondicionado,
			municipioPrestacao: municipioPrestacao,
			discriminacao: discriminacao,
		);			
	}

	
}