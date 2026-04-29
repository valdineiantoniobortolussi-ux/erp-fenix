import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:mdfe/app/data/domain/domain_imports.dart';

class MdfeCabecalhoModel {
	int? id;
	String? uf;
	String? tipoAmbiente;
	String? tipoEmitente;
	String? tipoTransportadora;
	String? modelo;
	String? serie;
	String? numeroMdfe;
	String? codigoNumerico;
	String? chaveAcesso;
	int? digitoVerificador;
	String? modal;
	DateTime? dataHoraEmissao;
	String? tipoEmissao;
	String? processoEmissao;
	String? versaoProcessoEmissao;
	String? ufInicio;
	String? ufFim;
	DateTime? dataHoraPrevisaoViagem;
	int? quantidadeTotalCte;
	int? quantidadeTotalNfe;
	int? quantidadeTotalMdfe;
	String? codigoUnidadeMedida;
	double? pesoBrutoCarga;
	double? valorCarga;
	String? numeroProtocolo;
	List<MdfeLacreModel>? mdfeLacreModelList;
	List<MdfeMunicipioDescarregaModel>? mdfeMunicipioDescarregaModelList;
	List<MdfeEmitenteModel>? mdfeEmitenteModelList;
	List<MdfePercursoModel>? mdfePercursoModelList;
	List<MdfeMunicipioCarregamentoModel>? mdfeMunicipioCarregamentoModelList;
	List<MdfeRodoviarioModel>? mdfeRodoviarioModelList;
	List<MdfeInformacaoSeguroModel>? mdfeInformacaoSeguroModelList;

	MdfeCabecalhoModel({
		this.id,
		this.uf,
		this.tipoAmbiente,
		this.tipoEmitente,
		this.tipoTransportadora,
		this.modelo,
		this.serie,
		this.numeroMdfe,
		this.codigoNumerico,
		this.chaveAcesso,
		this.digitoVerificador,
		this.modal,
		this.dataHoraEmissao,
		this.tipoEmissao,
		this.processoEmissao,
		this.versaoProcessoEmissao,
		this.ufInicio,
		this.ufFim,
		this.dataHoraPrevisaoViagem,
		this.quantidadeTotalCte,
		this.quantidadeTotalNfe,
		this.quantidadeTotalMdfe,
		this.codigoUnidadeMedida,
		this.pesoBrutoCarga,
		this.valorCarga,
		this.numeroProtocolo,
		this.mdfeLacreModelList,
		this.mdfeMunicipioDescarregaModelList,
		this.mdfeEmitenteModelList,
		this.mdfePercursoModelList,
		this.mdfeMunicipioCarregamentoModelList,
		this.mdfeRodoviarioModelList,
		this.mdfeInformacaoSeguroModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'uf',
		'tipo_ambiente',
		'tipo_emitente',
		'tipo_transportadora',
		'modelo',
		'serie',
		'numero_mdfe',
		'codigo_numerico',
		'chave_acesso',
		'digito_verificador',
		'modal',
		'data_hora_emissao',
		'tipo_emissao',
		'processo_emissao',
		'versao_processo_emissao',
		'uf_inicio',
		'uf_fim',
		'data_hora_previsao_viagem',
		'quantidade_total_cte',
		'quantidade_total_nfe',
		'quantidade_total_mdfe',
		'codigo_unidade_medida',
		'peso_bruto_carga',
		'valor_carga',
		'numero_protocolo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Uf',
		'Tipo Ambiente',
		'Tipo Emitente',
		'Tipo Transportadora',
		'Modelo',
		'Serie',
		'Numero Mdfe',
		'Codigo Numerico',
		'Chave Acesso',
		'Digito Verificador',
		'Modal',
		'Data Hora Emissao',
		'Tipo Emissao',
		'Processo Emissao',
		'Versao Processo Emissao',
		'Uf Inicio',
		'Uf Fim',
		'Data Hora Previsao Viagem',
		'Quantidade Total Cte',
		'Quantidade Total Nfe',
		'Quantidade Total Mdfe',
		'Codigo Unidade Medida',
		'Peso Bruto Carga',
		'Valor Carga',
		'Numero Protocolo',
	];

	MdfeCabecalhoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		uf = MdfeCabecalhoDomain.getUf(jsonData['uf']);
		tipoAmbiente = MdfeCabecalhoDomain.getTipoAmbiente(jsonData['tipoAmbiente']);
		tipoEmitente = MdfeCabecalhoDomain.getTipoEmitente(jsonData['tipoEmitente']);
		tipoTransportadora = MdfeCabecalhoDomain.getTipoTransportadora(jsonData['tipoTransportadora']);
		modelo = MdfeCabecalhoDomain.getModelo(jsonData['modelo']);
		serie = jsonData['serie'];
		numeroMdfe = jsonData['numeroMdfe'];
		codigoNumerico = jsonData['codigoNumerico'];
		chaveAcesso = jsonData['chaveAcesso'];
		digitoVerificador = jsonData['digitoVerificador'];
		modal = MdfeCabecalhoDomain.getModal(jsonData['modal']);
		dataHoraEmissao = jsonData['dataHoraEmissao'] != null ? DateTime.tryParse(jsonData['dataHoraEmissao']) : null;
		tipoEmissao = MdfeCabecalhoDomain.getTipoEmissao(jsonData['tipoEmissao']);
		processoEmissao = MdfeCabecalhoDomain.getProcessoEmissao(jsonData['processoEmissao']);
		versaoProcessoEmissao = jsonData['versaoProcessoEmissao'];
		ufInicio = MdfeCabecalhoDomain.getUfInicio(jsonData['ufInicio']);
		ufFim = MdfeCabecalhoDomain.getUfFim(jsonData['ufFim']);
		dataHoraPrevisaoViagem = jsonData['dataHoraPrevisaoViagem'] != null ? DateTime.tryParse(jsonData['dataHoraPrevisaoViagem']) : null;
		quantidadeTotalCte = jsonData['quantidadeTotalCte'];
		quantidadeTotalNfe = jsonData['quantidadeTotalNfe'];
		quantidadeTotalMdfe = jsonData['quantidadeTotalMdfe'];
		codigoUnidadeMedida = MdfeCabecalhoDomain.getCodigoUnidadeMedida(jsonData['codigoUnidadeMedida']);
		pesoBrutoCarga = jsonData['pesoBrutoCarga']?.toDouble();
		valorCarga = jsonData['valorCarga']?.toDouble();
		numeroProtocolo = jsonData['numeroProtocolo'];
		mdfeLacreModelList = (jsonData['mdfeLacreModelList'] as Iterable?)?.map((m) => MdfeLacreModel.fromJson(m)).toList() ?? [];
		mdfeMunicipioDescarregaModelList = (jsonData['mdfeMunicipioDescarregaModelList'] as Iterable?)?.map((m) => MdfeMunicipioDescarregaModel.fromJson(m)).toList() ?? [];
		mdfeEmitenteModelList = (jsonData['mdfeEmitenteModelList'] as Iterable?)?.map((m) => MdfeEmitenteModel.fromJson(m)).toList() ?? [];
		mdfePercursoModelList = (jsonData['mdfePercursoModelList'] as Iterable?)?.map((m) => MdfePercursoModel.fromJson(m)).toList() ?? [];
		mdfeMunicipioCarregamentoModelList = (jsonData['mdfeMunicipioCarregamentoModelList'] as Iterable?)?.map((m) => MdfeMunicipioCarregamentoModel.fromJson(m)).toList() ?? [];
		mdfeRodoviarioModelList = (jsonData['mdfeRodoviarioModelList'] as Iterable?)?.map((m) => MdfeRodoviarioModel.fromJson(m)).toList() ?? [];
		mdfeInformacaoSeguroModelList = (jsonData['mdfeInformacaoSeguroModelList'] as Iterable?)?.map((m) => MdfeInformacaoSeguroModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['uf'] = MdfeCabecalhoDomain.setUf(uf);
		jsonData['tipoAmbiente'] = MdfeCabecalhoDomain.setTipoAmbiente(tipoAmbiente);
		jsonData['tipoEmitente'] = MdfeCabecalhoDomain.setTipoEmitente(tipoEmitente);
		jsonData['tipoTransportadora'] = MdfeCabecalhoDomain.setTipoTransportadora(tipoTransportadora);
		jsonData['modelo'] = MdfeCabecalhoDomain.setModelo(modelo);
		jsonData['serie'] = serie;
		jsonData['numeroMdfe'] = numeroMdfe;
		jsonData['codigoNumerico'] = codigoNumerico;
		jsonData['chaveAcesso'] = chaveAcesso;
		jsonData['digitoVerificador'] = digitoVerificador;
		jsonData['modal'] = MdfeCabecalhoDomain.setModal(modal);
		jsonData['dataHoraEmissao'] = dataHoraEmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataHoraEmissao!) : null;
		jsonData['tipoEmissao'] = MdfeCabecalhoDomain.setTipoEmissao(tipoEmissao);
		jsonData['processoEmissao'] = MdfeCabecalhoDomain.setProcessoEmissao(processoEmissao);
		jsonData['versaoProcessoEmissao'] = versaoProcessoEmissao;
		jsonData['ufInicio'] = MdfeCabecalhoDomain.setUfInicio(ufInicio);
		jsonData['ufFim'] = MdfeCabecalhoDomain.setUfFim(ufFim);
		jsonData['dataHoraPrevisaoViagem'] = dataHoraPrevisaoViagem != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataHoraPrevisaoViagem!) : null;
		jsonData['quantidadeTotalCte'] = quantidadeTotalCte;
		jsonData['quantidadeTotalNfe'] = quantidadeTotalNfe;
		jsonData['quantidadeTotalMdfe'] = quantidadeTotalMdfe;
		jsonData['codigoUnidadeMedida'] = MdfeCabecalhoDomain.setCodigoUnidadeMedida(codigoUnidadeMedida);
		jsonData['pesoBrutoCarga'] = pesoBrutoCarga;
		jsonData['valorCarga'] = valorCarga;
		jsonData['numeroProtocolo'] = numeroProtocolo;
		
		var mdfeLacreModelLocalList = []; 
		for (MdfeLacreModel object in mdfeLacreModelList ?? []) { 
			mdfeLacreModelLocalList.add(object.toJson); 
		}
		jsonData['mdfeLacreModelList'] = mdfeLacreModelLocalList;
		
		var mdfeMunicipioDescarregaModelLocalList = []; 
		for (MdfeMunicipioDescarregaModel object in mdfeMunicipioDescarregaModelList ?? []) { 
			mdfeMunicipioDescarregaModelLocalList.add(object.toJson); 
		}
		jsonData['mdfeMunicipioDescarregaModelList'] = mdfeMunicipioDescarregaModelLocalList;
		
		var mdfeEmitenteModelLocalList = []; 
		for (MdfeEmitenteModel object in mdfeEmitenteModelList ?? []) { 
			mdfeEmitenteModelLocalList.add(object.toJson); 
		}
		jsonData['mdfeEmitenteModelList'] = mdfeEmitenteModelLocalList;
		
		var mdfePercursoModelLocalList = []; 
		for (MdfePercursoModel object in mdfePercursoModelList ?? []) { 
			mdfePercursoModelLocalList.add(object.toJson); 
		}
		jsonData['mdfePercursoModelList'] = mdfePercursoModelLocalList;
		
		var mdfeMunicipioCarregamentoModelLocalList = []; 
		for (MdfeMunicipioCarregamentoModel object in mdfeMunicipioCarregamentoModelList ?? []) { 
			mdfeMunicipioCarregamentoModelLocalList.add(object.toJson); 
		}
		jsonData['mdfeMunicipioCarregamentoModelList'] = mdfeMunicipioCarregamentoModelLocalList;
		
		var mdfeRodoviarioModelLocalList = []; 
		for (MdfeRodoviarioModel object in mdfeRodoviarioModelList ?? []) { 
			mdfeRodoviarioModelLocalList.add(object.toJson); 
		}
		jsonData['mdfeRodoviarioModelList'] = mdfeRodoviarioModelLocalList;
		
		var mdfeInformacaoSeguroModelLocalList = []; 
		for (MdfeInformacaoSeguroModel object in mdfeInformacaoSeguroModelList ?? []) { 
			mdfeInformacaoSeguroModelLocalList.add(object.toJson); 
		}
		jsonData['mdfeInformacaoSeguroModelList'] = mdfeInformacaoSeguroModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		uf = plutoRow.cells['uf']?.value != '' ? plutoRow.cells['uf']?.value : 'AC';
		tipoAmbiente = plutoRow.cells['tipoAmbiente']?.value != '' ? plutoRow.cells['tipoAmbiente']?.value : '1-Produção';
		tipoEmitente = plutoRow.cells['tipoEmitente']?.value != '' ? plutoRow.cells['tipoEmitente']?.value : '1-Prestador de serviço de transporte';
		tipoTransportadora = plutoRow.cells['tipoTransportadora']?.value != '' ? plutoRow.cells['tipoTransportadora']?.value : 'ETC';
		modelo = plutoRow.cells['modelo']?.value != '' ? plutoRow.cells['modelo']?.value : '58';
		serie = plutoRow.cells['serie']?.value;
		numeroMdfe = plutoRow.cells['numeroMdfe']?.value;
		codigoNumerico = plutoRow.cells['codigoNumerico']?.value;
		chaveAcesso = plutoRow.cells['chaveAcesso']?.value;
		digitoVerificador = plutoRow.cells['digitoVerificador']?.value;
		modal = plutoRow.cells['modal']?.value != '' ? plutoRow.cells['modal']?.value : '1-Rodoviário';
		dataHoraEmissao = Util.stringToDate(plutoRow.cells['dataHoraEmissao']?.value);
		tipoEmissao = plutoRow.cells['tipoEmissao']?.value != '' ? plutoRow.cells['tipoEmissao']?.value : '1-Normal';
		processoEmissao = plutoRow.cells['processoEmissao']?.value != '' ? plutoRow.cells['processoEmissao']?.value : '0-Emissão de MDF-e com aplicativo do  contribuinte';
		versaoProcessoEmissao = plutoRow.cells['versaoProcessoEmissao']?.value;
		ufInicio = plutoRow.cells['ufInicio']?.value != '' ? plutoRow.cells['ufInicio']?.value : 'AC';
		ufFim = plutoRow.cells['ufFim']?.value != '' ? plutoRow.cells['ufFim']?.value : 'AC';
		dataHoraPrevisaoViagem = Util.stringToDate(plutoRow.cells['dataHoraPrevisaoViagem']?.value);
		quantidadeTotalCte = plutoRow.cells['quantidadeTotalCte']?.value;
		quantidadeTotalNfe = plutoRow.cells['quantidadeTotalNfe']?.value;
		quantidadeTotalMdfe = plutoRow.cells['quantidadeTotalMdfe']?.value;
		codigoUnidadeMedida = plutoRow.cells['codigoUnidadeMedida']?.value != '' ? plutoRow.cells['codigoUnidadeMedida']?.value : '01-KG';
		pesoBrutoCarga = plutoRow.cells['pesoBrutoCarga']?.value?.toDouble();
		valorCarga = plutoRow.cells['valorCarga']?.value?.toDouble();
		numeroProtocolo = plutoRow.cells['numeroProtocolo']?.value;
		mdfeLacreModelList = [];
		mdfeMunicipioDescarregaModelList = [];
		mdfeEmitenteModelList = [];
		mdfePercursoModelList = [];
		mdfeMunicipioCarregamentoModelList = [];
		mdfeRodoviarioModelList = [];
		mdfeInformacaoSeguroModelList = [];
	}	

	MdfeCabecalhoModel clone() {
		return MdfeCabecalhoModel(
			id: id,
			uf: uf,
			tipoAmbiente: tipoAmbiente,
			tipoEmitente: tipoEmitente,
			tipoTransportadora: tipoTransportadora,
			modelo: modelo,
			serie: serie,
			numeroMdfe: numeroMdfe,
			codigoNumerico: codigoNumerico,
			chaveAcesso: chaveAcesso,
			digitoVerificador: digitoVerificador,
			modal: modal,
			dataHoraEmissao: dataHoraEmissao,
			tipoEmissao: tipoEmissao,
			processoEmissao: processoEmissao,
			versaoProcessoEmissao: versaoProcessoEmissao,
			ufInicio: ufInicio,
			ufFim: ufFim,
			dataHoraPrevisaoViagem: dataHoraPrevisaoViagem,
			quantidadeTotalCte: quantidadeTotalCte,
			quantidadeTotalNfe: quantidadeTotalNfe,
			quantidadeTotalMdfe: quantidadeTotalMdfe,
			codigoUnidadeMedida: codigoUnidadeMedida,
			pesoBrutoCarga: pesoBrutoCarga,
			valorCarga: valorCarga,
			numeroProtocolo: numeroProtocolo,
			mdfeLacreModelList: mdfeLacreModelListClone(mdfeLacreModelList!),
			mdfeMunicipioDescarregaModelList: mdfeMunicipioDescarregaModelListClone(mdfeMunicipioDescarregaModelList!),
			mdfeEmitenteModelList: mdfeEmitenteModelListClone(mdfeEmitenteModelList!),
			mdfePercursoModelList: mdfePercursoModelListClone(mdfePercursoModelList!),
			mdfeMunicipioCarregamentoModelList: mdfeMunicipioCarregamentoModelListClone(mdfeMunicipioCarregamentoModelList!),
			mdfeRodoviarioModelList: mdfeRodoviarioModelListClone(mdfeRodoviarioModelList!),
			mdfeInformacaoSeguroModelList: mdfeInformacaoSeguroModelListClone(mdfeInformacaoSeguroModelList!),
		);			
	}

	mdfeLacreModelListClone(List<MdfeLacreModel> mdfeLacreModelList) { 
		List<MdfeLacreModel> resultList = [];
		for (var mdfeLacreModel in mdfeLacreModelList) {
			resultList.add(
				MdfeLacreModel(
					id: mdfeLacreModel.id,
					idMdfeCabecalho: mdfeLacreModel.idMdfeCabecalho,
					numeroLacre: mdfeLacreModel.numeroLacre,
				)
			);
		}
		return resultList;
	}

	mdfeMunicipioDescarregaModelListClone(List<MdfeMunicipioDescarregaModel> mdfeMunicipioDescarregaModelList) { 
		List<MdfeMunicipioDescarregaModel> resultList = [];
		for (var mdfeMunicipioDescarregaModel in mdfeMunicipioDescarregaModelList) {
			resultList.add(
				MdfeMunicipioDescarregaModel(
					id: mdfeMunicipioDescarregaModel.id,
					idMdfeCabecalho: mdfeMunicipioDescarregaModel.idMdfeCabecalho,
					codigoMunicipio: mdfeMunicipioDescarregaModel.codigoMunicipio,
					nomeMunicipio: mdfeMunicipioDescarregaModel.nomeMunicipio,
				)
			);
		}
		return resultList;
	}

	mdfeEmitenteModelListClone(List<MdfeEmitenteModel> mdfeEmitenteModelList) { 
		List<MdfeEmitenteModel> resultList = [];
		for (var mdfeEmitenteModel in mdfeEmitenteModelList) {
			resultList.add(
				MdfeEmitenteModel(
					id: mdfeEmitenteModel.id,
					idMdfeCabecalho: mdfeEmitenteModel.idMdfeCabecalho,
					nome: mdfeEmitenteModel.nome,
					fantasia: mdfeEmitenteModel.fantasia,
					cnpj: mdfeEmitenteModel.cnpj,
					ie: mdfeEmitenteModel.ie,
					logradouro: mdfeEmitenteModel.logradouro,
					numero: mdfeEmitenteModel.numero,
					complemento: mdfeEmitenteModel.complemento,
					bairro: mdfeEmitenteModel.bairro,
					codigoMunicipio: mdfeEmitenteModel.codigoMunicipio,
					nomeMunicipio: mdfeEmitenteModel.nomeMunicipio,
					cep: mdfeEmitenteModel.cep,
					uf: mdfeEmitenteModel.uf,
					telefone: mdfeEmitenteModel.telefone,
					email: mdfeEmitenteModel.email,
				)
			);
		}
		return resultList;
	}

	mdfePercursoModelListClone(List<MdfePercursoModel> mdfePercursoModelList) { 
		List<MdfePercursoModel> resultList = [];
		for (var mdfePercursoModel in mdfePercursoModelList) {
			resultList.add(
				MdfePercursoModel(
					id: mdfePercursoModel.id,
					idMdfeCabecalho: mdfePercursoModel.idMdfeCabecalho,
					ufPercurso: mdfePercursoModel.ufPercurso,
					dataInicioViagem: mdfePercursoModel.dataInicioViagem,
				)
			);
		}
		return resultList;
	}

	mdfeMunicipioCarregamentoModelListClone(List<MdfeMunicipioCarregamentoModel> mdfeMunicipioCarregamentoModelList) { 
		List<MdfeMunicipioCarregamentoModel> resultList = [];
		for (var mdfeMunicipioCarregamentoModel in mdfeMunicipioCarregamentoModelList) {
			resultList.add(
				MdfeMunicipioCarregamentoModel(
					id: mdfeMunicipioCarregamentoModel.id,
					idMdfeCabecalho: mdfeMunicipioCarregamentoModel.idMdfeCabecalho,
					codigoMunicipio: mdfeMunicipioCarregamentoModel.codigoMunicipio,
					nomeMunicipio: mdfeMunicipioCarregamentoModel.nomeMunicipio,
				)
			);
		}
		return resultList;
	}

	mdfeRodoviarioModelListClone(List<MdfeRodoviarioModel> mdfeRodoviarioModelList) { 
		List<MdfeRodoviarioModel> resultList = [];
		for (var mdfeRodoviarioModel in mdfeRodoviarioModelList) {
			resultList.add(
				MdfeRodoviarioModel(
					id: mdfeRodoviarioModel.id,
					idMdfeCabecalho: mdfeRodoviarioModel.idMdfeCabecalho,
					rntrc: mdfeRodoviarioModel.rntrc,
					codigoAgendamento: mdfeRodoviarioModel.codigoAgendamento,
				)
			);
		}
		return resultList;
	}

	mdfeInformacaoSeguroModelListClone(List<MdfeInformacaoSeguroModel> mdfeInformacaoSeguroModelList) { 
		List<MdfeInformacaoSeguroModel> resultList = [];
		for (var mdfeInformacaoSeguroModel in mdfeInformacaoSeguroModelList) {
			resultList.add(
				MdfeInformacaoSeguroModel(
					id: mdfeInformacaoSeguroModel.id,
					idMdfeCabecalho: mdfeInformacaoSeguroModel.idMdfeCabecalho,
					responsavel: mdfeInformacaoSeguroModel.responsavel,
					cnpjCpf: mdfeInformacaoSeguroModel.cnpjCpf,
					seguradora: mdfeInformacaoSeguroModel.seguradora,
					cnpjSeguradora: mdfeInformacaoSeguroModel.cnpjSeguradora,
					apolice: mdfeInformacaoSeguroModel.apolice,
					averbacao: mdfeInformacaoSeguroModel.averbacao,
				)
			);
		}
		return resultList;
	}

	
}