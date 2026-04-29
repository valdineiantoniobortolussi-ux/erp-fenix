import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/data/domain/domain_imports.dart';

class FinConfiguracaoBoletoModel {
	int? id;
	int? idBancoContaCaixa;
	String? instrucao01;
	String? instrucao02;
	String? caminhoArquivoRemessa;
	String? caminhoArquivoRetorno;
	String? caminhoArquivoLogotipo;
	String? caminhoArquivoPdf;
	String? mensagem;
	String? localPagamento;
	String? layoutRemessa;
	String? aceite;
	String? especie;
	String? carteira;
	String? codigoConvenio;
	String? codigoCedente;
	double? taxaMulta;
	double? taxaJuro;
	int? diasProtesto;
	String? nossoNumeroAnterior;
	BancoContaCaixaModel? bancoContaCaixaModel;

	FinConfiguracaoBoletoModel({
		this.id,
		this.idBancoContaCaixa,
		this.instrucao01,
		this.instrucao02,
		this.caminhoArquivoRemessa,
		this.caminhoArquivoRetorno,
		this.caminhoArquivoLogotipo,
		this.caminhoArquivoPdf,
		this.mensagem,
		this.localPagamento,
		this.layoutRemessa,
		this.aceite,
		this.especie,
		this.carteira,
		this.codigoConvenio,
		this.codigoCedente,
		this.taxaMulta,
		this.taxaJuro,
		this.diasProtesto,
		this.nossoNumeroAnterior,
		this.bancoContaCaixaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'instrucao01',
		'instrucao02',
		'caminho_arquivo_remessa',
		'caminho_arquivo_retorno',
		'caminho_arquivo_logotipo',
		'caminho_arquivo_pdf',
		'mensagem',
		'local_pagamento',
		'layout_remessa',
		'aceite',
		'especie',
		'carteira',
		'codigo_convenio',
		'codigo_cedente',
		'taxa_multa',
		'taxa_juro',
		'dias_protesto',
		'nosso_numero_anterior',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Instrucao01',
		'Instrucao02',
		'Caminho Arquivo Remessa',
		'Caminho Arquivo Retorno',
		'Caminho Arquivo Logotipo',
		'Caminho Arquivo Pdf',
		'Mensagem',
		'Local Pagamento',
		'Layout Remessa',
		'Aceite',
		'Especie',
		'Carteira',
		'Codigo Convenio',
		'Codigo Cedente',
		'Taxa Multa',
		'Taxa Juro',
		'Dias Protesto',
		'Nosso Numero Anterior',
	];

	FinConfiguracaoBoletoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idBancoContaCaixa = jsonData['idBancoContaCaixa'];
		instrucao01 = jsonData['instrucao01'];
		instrucao02 = jsonData['instrucao02'];
		caminhoArquivoRemessa = jsonData['caminhoArquivoRemessa'];
		caminhoArquivoRetorno = jsonData['caminhoArquivoRetorno'];
		caminhoArquivoLogotipo = jsonData['caminhoArquivoLogotipo'];
		caminhoArquivoPdf = jsonData['caminhoArquivoPdf'];
		mensagem = jsonData['mensagem'];
		localPagamento = jsonData['localPagamento'];
		layoutRemessa = FinConfiguracaoBoletoDomain.getLayoutRemessa(jsonData['layoutRemessa']);
		aceite = FinConfiguracaoBoletoDomain.getAceite(jsonData['aceite']);
		especie = FinConfiguracaoBoletoDomain.getEspecie(jsonData['especie']);
		carteira = jsonData['carteira'];
		codigoConvenio = jsonData['codigoConvenio'];
		codigoCedente = jsonData['codigoCedente'];
		taxaMulta = jsonData['taxaMulta']?.toDouble();
		taxaJuro = jsonData['taxaJuro']?.toDouble();
		diasProtesto = jsonData['diasProtesto'];
		nossoNumeroAnterior = jsonData['nossoNumeroAnterior'];
		bancoContaCaixaModel = jsonData['bancoContaCaixaModel'] == null ? BancoContaCaixaModel() : BancoContaCaixaModel.fromJson(jsonData['bancoContaCaixaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idBancoContaCaixa'] = idBancoContaCaixa != 0 ? idBancoContaCaixa : null;
		jsonData['instrucao01'] = instrucao01;
		jsonData['instrucao02'] = instrucao02;
		jsonData['caminhoArquivoRemessa'] = caminhoArquivoRemessa;
		jsonData['caminhoArquivoRetorno'] = caminhoArquivoRetorno;
		jsonData['caminhoArquivoLogotipo'] = caminhoArquivoLogotipo;
		jsonData['caminhoArquivoPdf'] = caminhoArquivoPdf;
		jsonData['mensagem'] = mensagem;
		jsonData['localPagamento'] = localPagamento;
		jsonData['layoutRemessa'] = FinConfiguracaoBoletoDomain.setLayoutRemessa(layoutRemessa);
		jsonData['aceite'] = FinConfiguracaoBoletoDomain.setAceite(aceite);
		jsonData['especie'] = FinConfiguracaoBoletoDomain.setEspecie(especie);
		jsonData['carteira'] = carteira;
		jsonData['codigoConvenio'] = codigoConvenio;
		jsonData['codigoCedente'] = codigoCedente;
		jsonData['taxaMulta'] = taxaMulta;
		jsonData['taxaJuro'] = taxaJuro;
		jsonData['diasProtesto'] = diasProtesto;
		jsonData['nossoNumeroAnterior'] = nossoNumeroAnterior;
		jsonData['bancoContaCaixaModel'] = bancoContaCaixaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idBancoContaCaixa = plutoRow.cells['idBancoContaCaixa']?.value;
		instrucao01 = plutoRow.cells['instrucao01']?.value;
		instrucao02 = plutoRow.cells['instrucao02']?.value;
		caminhoArquivoRemessa = plutoRow.cells['caminhoArquivoRemessa']?.value;
		caminhoArquivoRetorno = plutoRow.cells['caminhoArquivoRetorno']?.value;
		caminhoArquivoLogotipo = plutoRow.cells['caminhoArquivoLogotipo']?.value;
		caminhoArquivoPdf = plutoRow.cells['caminhoArquivoPdf']?.value;
		mensagem = plutoRow.cells['mensagem']?.value;
		localPagamento = plutoRow.cells['localPagamento']?.value;
		layoutRemessa = plutoRow.cells['layoutRemessa']?.value != '' ? plutoRow.cells['layoutRemessa']?.value : 'CNAB 240';
		aceite = plutoRow.cells['aceite']?.value != '' ? plutoRow.cells['aceite']?.value : 'S';
		especie = plutoRow.cells['especie']?.value != '' ? plutoRow.cells['especie']?.value : 'DM-Duplicata Mercantil';
		carteira = plutoRow.cells['carteira']?.value;
		codigoConvenio = plutoRow.cells['codigoConvenio']?.value;
		codigoCedente = plutoRow.cells['codigoCedente']?.value;
		taxaMulta = plutoRow.cells['taxaMulta']?.value?.toDouble();
		taxaJuro = plutoRow.cells['taxaJuro']?.value?.toDouble();
		diasProtesto = plutoRow.cells['diasProtesto']?.value;
		nossoNumeroAnterior = plutoRow.cells['nossoNumeroAnterior']?.value;
		bancoContaCaixaModel = BancoContaCaixaModel();
		bancoContaCaixaModel?.nome = plutoRow.cells['bancoContaCaixaModel']?.value;
	}	

	FinConfiguracaoBoletoModel clone() {
		return FinConfiguracaoBoletoModel(
			id: id,
			idBancoContaCaixa: idBancoContaCaixa,
			instrucao01: instrucao01,
			instrucao02: instrucao02,
			caminhoArquivoRemessa: caminhoArquivoRemessa,
			caminhoArquivoRetorno: caminhoArquivoRetorno,
			caminhoArquivoLogotipo: caminhoArquivoLogotipo,
			caminhoArquivoPdf: caminhoArquivoPdf,
			mensagem: mensagem,
			localPagamento: localPagamento,
			layoutRemessa: layoutRemessa,
			aceite: aceite,
			especie: especie,
			carteira: carteira,
			codigoConvenio: codigoConvenio,
			codigoCedente: codigoCedente,
			taxaMulta: taxaMulta,
			taxaJuro: taxaJuro,
			diasProtesto: diasProtesto,
			nossoNumeroAnterior: nossoNumeroAnterior,
		);			
	}

	
}