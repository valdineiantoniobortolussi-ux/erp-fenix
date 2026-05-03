import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfse/app/infra/infra_imports.dart';
import 'package:nfse/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:nfse/app/data/domain/domain_imports.dart';

class NfseCabecalhoModel {
	int? id;
	int? idCliente;
	int? idOsAbertura;
	String? numero;
	String? codigoVerificacao;
	DateTime? dataHoraEmissao;
	String? competencia;
	String? numeroSubstituida;
	String? naturezaOperacao;
	String? regimeEspecialTributacao;
	String? optanteSimplesNacional;
	String? incentivadorCultural;
	String? numeroRps;
	String? serieRps;
	String? tipoRps;
	DateTime? dataEmissaoRps;
	String? outrasInformacoes;
	List<NfseDetalheModel>? nfseDetalheModelList;
	List<NfseIntermediarioModel>? nfseIntermediarioModelList;
	ViewPessoaClienteModel? viewPessoaClienteModel;
	OsAberturaModel? osAberturaModel;

	NfseCabecalhoModel({
		this.id,
		this.idCliente,
		this.idOsAbertura,
		this.numero,
		this.codigoVerificacao,
		this.dataHoraEmissao,
		this.competencia,
		this.numeroSubstituida,
		this.naturezaOperacao,
		this.regimeEspecialTributacao,
		this.optanteSimplesNacional,
		this.incentivadorCultural,
		this.numeroRps,
		this.serieRps,
		this.tipoRps,
		this.dataEmissaoRps,
		this.outrasInformacoes,
		this.nfseDetalheModelList,
		this.nfseIntermediarioModelList,
		this.viewPessoaClienteModel,
		this.osAberturaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero',
		'codigo_verificacao',
		'data_hora_emissao',
		'competencia',
		'numero_substituida',
		'natureza_operacao',
		'regime_especial_nfse',
		'optante_simples_nacional',
		'incentivador_cultural',
		'numero_rps',
		'serie_rps',
		'tipo_rps',
		'data_emissao_rps',
		'outras_informacoes',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero',
		'Codigo Verificacao',
		'Data Hora Emissao',
		'Competencia',
		'Numero Substituida',
		'Natureza Operacao',
		'Regime Especial Tributacao',
		'Optante Simples Nacional',
		'Incentivador Cultural',
		'Numero Rps',
		'Serie Rps',
		'Tipo Rps',
		'Data Emissao Rps',
		'Outras Informacoes',
	];

	NfseCabecalhoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCliente = jsonData['idCliente'];
		idOsAbertura = jsonData['idOsAbertura'];
		numero = jsonData['numero'];
		codigoVerificacao = jsonData['codigoVerificacao'];
		dataHoraEmissao = jsonData['dataHoraEmissao'] != null ? DateTime.tryParse(jsonData['dataHoraEmissao']) : null;
		competencia = jsonData['competencia'];
		numeroSubstituida = jsonData['numeroSubstituida'];
		naturezaOperacao = NfseCabecalhoDomain.getNaturezaOperacao(jsonData['naturezaOperacao']);
		regimeEspecialTributacao = NfseCabecalhoDomain.getRegimeEspecialTributacao(jsonData['regimeEspecialTributacao']);
		optanteSimplesNacional = NfseCabecalhoDomain.getOptanteSimplesNacional(jsonData['optanteSimplesNacional']);
		incentivadorCultural = NfseCabecalhoDomain.getIncentivadorCultural(jsonData['incentivadorCultural']);
		numeroRps = jsonData['numeroRps'];
		serieRps = jsonData['serieRps'];
		tipoRps = NfseCabecalhoDomain.getTipoRps(jsonData['tipoRps']);
		dataEmissaoRps = jsonData['dataEmissaoRps'] != null ? DateTime.tryParse(jsonData['dataEmissaoRps']) : null;
		outrasInformacoes = jsonData['outrasInformacoes'];
		nfseDetalheModelList = (jsonData['nfseDetalheModelList'] as Iterable?)?.map((m) => NfseDetalheModel.fromJson(m)).toList() ?? [];
		nfseIntermediarioModelList = (jsonData['nfseIntermediarioModelList'] as Iterable?)?.map((m) => NfseIntermediarioModel.fromJson(m)).toList() ?? [];
		viewPessoaClienteModel = jsonData['viewPessoaClienteModel'] == null ? ViewPessoaClienteModel() : ViewPessoaClienteModel.fromJson(jsonData['viewPessoaClienteModel']);
		osAberturaModel = jsonData['osAberturaModel'] == null ? OsAberturaModel() : OsAberturaModel.fromJson(jsonData['osAberturaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCliente'] = idCliente != 0 ? idCliente : null;
		jsonData['idOsAbertura'] = idOsAbertura != 0 ? idOsAbertura : null;
		jsonData['numero'] = numero;
		jsonData['codigoVerificacao'] = codigoVerificacao;
		jsonData['dataHoraEmissao'] = dataHoraEmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataHoraEmissao!) : null;
		jsonData['competencia'] = Util.removeMask(competencia);
		jsonData['numeroSubstituida'] = numeroSubstituida;
		jsonData['naturezaOperacao'] = NfseCabecalhoDomain.setNaturezaOperacao(naturezaOperacao);
		jsonData['regimeEspecialTributacao'] = NfseCabecalhoDomain.setRegimeEspecialTributacao(regimeEspecialTributacao);
		jsonData['optanteSimplesNacional'] = NfseCabecalhoDomain.setOptanteSimplesNacional(optanteSimplesNacional);
		jsonData['incentivadorCultural'] = NfseCabecalhoDomain.setIncentivadorCultural(incentivadorCultural);
		jsonData['numeroRps'] = numeroRps;
		jsonData['serieRps'] = serieRps;
		jsonData['tipoRps'] = NfseCabecalhoDomain.setTipoRps(tipoRps);
		jsonData['dataEmissaoRps'] = dataEmissaoRps != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEmissaoRps!) : null;
		jsonData['outrasInformacoes'] = outrasInformacoes;
		
		var nfseDetalheModelLocalList = []; 
		for (NfseDetalheModel object in nfseDetalheModelList ?? []) { 
			nfseDetalheModelLocalList.add(object.toJson); 
		}
		jsonData['nfseDetalheModelList'] = nfseDetalheModelLocalList;
		
		var nfseIntermediarioModelLocalList = []; 
		for (NfseIntermediarioModel object in nfseIntermediarioModelList ?? []) { 
			nfseIntermediarioModelLocalList.add(object.toJson); 
		}
		jsonData['nfseIntermediarioModelList'] = nfseIntermediarioModelLocalList;
		jsonData['viewPessoaClienteModel'] = viewPessoaClienteModel?.toJson;
		jsonData['osAberturaModel'] = osAberturaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCliente = plutoRow.cells['idCliente']?.value;
		idOsAbertura = plutoRow.cells['idOsAbertura']?.value;
		numero = plutoRow.cells['numero']?.value;
		codigoVerificacao = plutoRow.cells['codigoVerificacao']?.value;
		dataHoraEmissao = Util.stringToDate(plutoRow.cells['dataHoraEmissao']?.value);
		competencia = plutoRow.cells['competencia']?.value;
		numeroSubstituida = plutoRow.cells['numeroSubstituida']?.value;
		naturezaOperacao = plutoRow.cells['naturezaOperacao']?.value != '' ? plutoRow.cells['naturezaOperacao']?.value : '1=Tributação no município';
		regimeEspecialTributacao = plutoRow.cells['regimeEspecialTributacao']?.value != '' ? plutoRow.cells['regimeEspecialTributacao']?.value : '1=Microempresa Municipal';
		optanteSimplesNacional = plutoRow.cells['optanteSimplesNacional']?.value != '' ? plutoRow.cells['optanteSimplesNacional']?.value : 'S';
		incentivadorCultural = plutoRow.cells['incentivadorCultural']?.value != '' ? plutoRow.cells['incentivadorCultural']?.value : 'S';
		numeroRps = plutoRow.cells['numeroRps']?.value;
		serieRps = plutoRow.cells['serieRps']?.value;
		tipoRps = plutoRow.cells['tipoRps']?.value != '' ? plutoRow.cells['tipoRps']?.value : '1=Recibo Provisório de Serviços';
		dataEmissaoRps = Util.stringToDate(plutoRow.cells['dataEmissaoRps']?.value);
		outrasInformacoes = plutoRow.cells['outrasInformacoes']?.value;
		nfseDetalheModelList = [];
		nfseIntermediarioModelList = [];
		viewPessoaClienteModel = ViewPessoaClienteModel();
		viewPessoaClienteModel?.nome = plutoRow.cells['viewPessoaClienteModel']?.value;
		osAberturaModel = OsAberturaModel();
		osAberturaModel?.numero = plutoRow.cells['osAberturaModel']?.value;
	}	

	NfseCabecalhoModel clone() {
		return NfseCabecalhoModel(
			id: id,
			idCliente: idCliente,
			idOsAbertura: idOsAbertura,
			numero: numero,
			codigoVerificacao: codigoVerificacao,
			dataHoraEmissao: dataHoraEmissao,
			competencia: competencia,
			numeroSubstituida: numeroSubstituida,
			naturezaOperacao: naturezaOperacao,
			regimeEspecialTributacao: regimeEspecialTributacao,
			optanteSimplesNacional: optanteSimplesNacional,
			incentivadorCultural: incentivadorCultural,
			numeroRps: numeroRps,
			serieRps: serieRps,
			tipoRps: tipoRps,
			dataEmissaoRps: dataEmissaoRps,
			outrasInformacoes: outrasInformacoes,
			nfseDetalheModelList: nfseDetalheModelListClone(nfseDetalheModelList!),
			nfseIntermediarioModelList: nfseIntermediarioModelListClone(nfseIntermediarioModelList!),
		);			
	}

	nfseDetalheModelListClone(List<NfseDetalheModel> nfseDetalheModelList) { 
		List<NfseDetalheModel> resultList = [];
		for (var nfseDetalheModel in nfseDetalheModelList) {
			resultList.add(
				NfseDetalheModel(
					id: nfseDetalheModel.id,
					idNfseCabecalho: nfseDetalheModel.idNfseCabecalho,
					idNfseListaServico: nfseDetalheModel.idNfseListaServico,
					codigoCnae: nfseDetalheModel.codigoCnae,
					codigoTributacaoMunicipio: nfseDetalheModel.codigoTributacaoMunicipio,
					valorServicos: nfseDetalheModel.valorServicos,
					valorDeducoes: nfseDetalheModel.valorDeducoes,
					valorPis: nfseDetalheModel.valorPis,
					valorCofins: nfseDetalheModel.valorCofins,
					valorInss: nfseDetalheModel.valorInss,
					valorIr: nfseDetalheModel.valorIr,
					valorCsll: nfseDetalheModel.valorCsll,
					valorBaseCalculo: nfseDetalheModel.valorBaseCalculo,
					aliquota: nfseDetalheModel.aliquota,
					valorIss: nfseDetalheModel.valorIss,
					valorLiquido: nfseDetalheModel.valorLiquido,
					outrasRetencoes: nfseDetalheModel.outrasRetencoes,
					valorCredito: nfseDetalheModel.valorCredito,
					issRetido: nfseDetalheModel.issRetido,
					valorIssRetido: nfseDetalheModel.valorIssRetido,
					valorDescontoCondicionado: nfseDetalheModel.valorDescontoCondicionado,
					valorDescontoIncondicionado: nfseDetalheModel.valorDescontoIncondicionado,
					municipioPrestacao: nfseDetalheModel.municipioPrestacao,
					discriminacao: nfseDetalheModel.discriminacao,
				)
			);
		}
		return resultList;
	}

	nfseIntermediarioModelListClone(List<NfseIntermediarioModel> nfseIntermediarioModelList) { 
		List<NfseIntermediarioModel> resultList = [];
		for (var nfseIntermediarioModel in nfseIntermediarioModelList) {
			resultList.add(
				NfseIntermediarioModel(
					id: nfseIntermediarioModel.id,
					idNfseCabecalho: nfseIntermediarioModel.idNfseCabecalho,
					cnpj: nfseIntermediarioModel.cnpj,
					inscricaoMunicipal: nfseIntermediarioModel.inscricaoMunicipal,
					razao: nfseIntermediarioModel.razao,
				)
			);
		}
		return resultList;
	}

	
}