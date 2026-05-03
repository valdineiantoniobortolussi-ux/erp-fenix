import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contratos/app/infra/infra_imports.dart';
import 'package:contratos/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class ContratoModel {
	int? id;
	int? idSolicitacaoServico;
	int? idTipoContrato;
	String? numero;
	String? nome;
	String? descricao;
	DateTime? dataCadastro;
	DateTime? dataInicioVigencia;
	DateTime? dataFimVigencia;
	String? diaFaturamento;
	double? valor;
	int? quantidadeParcelas;
	int? intervaloEntreParcelas;
	String? classificacaoContabilConta;
	String? observacao;
	List<ContratoHistoricoReajusteModel>? contratoHistoricoReajusteModelList;
	List<ContratoPrevFaturamentoModel>? contratoPrevFaturamentoModelList;
	List<ContratoHistFaturamentoModel>? contratoHistFaturamentoModelList;
	TipoContratoModel? tipoContratoModel;
	ContratoSolicitacaoServicoModel? contratoSolicitacaoServicoModel;

	ContratoModel({
		this.id,
		this.idSolicitacaoServico,
		this.idTipoContrato,
		this.numero,
		this.nome,
		this.descricao,
		this.dataCadastro,
		this.dataInicioVigencia,
		this.dataFimVigencia,
		this.diaFaturamento,
		this.valor,
		this.quantidadeParcelas,
		this.intervaloEntreParcelas,
		this.classificacaoContabilConta,
		this.observacao,
		this.contratoHistoricoReajusteModelList,
		this.contratoPrevFaturamentoModelList,
		this.contratoHistFaturamentoModelList,
		this.tipoContratoModel,
		this.contratoSolicitacaoServicoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero',
		'nome',
		'descricao',
		'data_cadastro',
		'data_inicio_vigencia',
		'data_fim_vigencia',
		'dia_faturamento',
		'valor',
		'quantidade_parcelas',
		'intervalo_entre_parcelas',
		'classificacao_contabil_conta',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero',
		'Nome',
		'Descricao',
		'Data Cadastro',
		'Data Inicio Vigencia',
		'Data Fim Vigencia',
		'Dia Faturamento',
		'Valor',
		'Quantidade Parcelas',
		'Intervalo Entre Parcelas',
		'Classificacao Contabil Conta',
		'Observacao',
	];

	ContratoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idSolicitacaoServico = jsonData['idSolicitacaoServico'];
		idTipoContrato = jsonData['idTipoContrato'];
		numero = jsonData['numero'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		dataCadastro = jsonData['dataCadastro'] != null ? DateTime.tryParse(jsonData['dataCadastro']) : null;
		dataInicioVigencia = jsonData['dataInicioVigencia'] != null ? DateTime.tryParse(jsonData['dataInicioVigencia']) : null;
		dataFimVigencia = jsonData['dataFimVigencia'] != null ? DateTime.tryParse(jsonData['dataFimVigencia']) : null;
		diaFaturamento = jsonData['diaFaturamento'];
		valor = jsonData['valor']?.toDouble();
		quantidadeParcelas = jsonData['quantidadeParcelas'];
		intervaloEntreParcelas = jsonData['intervaloEntreParcelas'];
		classificacaoContabilConta = jsonData['classificacaoContabilConta'];
		observacao = jsonData['observacao'];
		contratoHistoricoReajusteModelList = (jsonData['contratoHistoricoReajusteModelList'] as Iterable?)?.map((m) => ContratoHistoricoReajusteModel.fromJson(m)).toList() ?? [];
		contratoPrevFaturamentoModelList = (jsonData['contratoPrevFaturamentoModelList'] as Iterable?)?.map((m) => ContratoPrevFaturamentoModel.fromJson(m)).toList() ?? [];
		contratoHistFaturamentoModelList = (jsonData['contratoHistFaturamentoModelList'] as Iterable?)?.map((m) => ContratoHistFaturamentoModel.fromJson(m)).toList() ?? [];
		tipoContratoModel = jsonData['tipoContratoModel'] == null ? TipoContratoModel() : TipoContratoModel.fromJson(jsonData['tipoContratoModel']);
		contratoSolicitacaoServicoModel = jsonData['contratoSolicitacaoServicoModel'] == null ? ContratoSolicitacaoServicoModel() : ContratoSolicitacaoServicoModel.fromJson(jsonData['contratoSolicitacaoServicoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idSolicitacaoServico'] = idSolicitacaoServico != 0 ? idSolicitacaoServico : null;
		jsonData['idTipoContrato'] = idTipoContrato != 0 ? idTipoContrato : null;
		jsonData['numero'] = numero;
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
		jsonData['dataCadastro'] = dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCadastro!) : null;
		jsonData['dataInicioVigencia'] = dataInicioVigencia != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicioVigencia!) : null;
		jsonData['dataFimVigencia'] = dataFimVigencia != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFimVigencia!) : null;
		jsonData['diaFaturamento'] = diaFaturamento;
		jsonData['valor'] = valor;
		jsonData['quantidadeParcelas'] = quantidadeParcelas;
		jsonData['intervaloEntreParcelas'] = intervaloEntreParcelas;
		jsonData['classificacaoContabilConta'] = classificacaoContabilConta;
		jsonData['observacao'] = observacao;
		
		var contratoHistoricoReajusteModelLocalList = []; 
		for (ContratoHistoricoReajusteModel object in contratoHistoricoReajusteModelList ?? []) { 
			contratoHistoricoReajusteModelLocalList.add(object.toJson); 
		}
		jsonData['contratoHistoricoReajusteModelList'] = contratoHistoricoReajusteModelLocalList;
		
		var contratoPrevFaturamentoModelLocalList = []; 
		for (ContratoPrevFaturamentoModel object in contratoPrevFaturamentoModelList ?? []) { 
			contratoPrevFaturamentoModelLocalList.add(object.toJson); 
		}
		jsonData['contratoPrevFaturamentoModelList'] = contratoPrevFaturamentoModelLocalList;
		
		var contratoHistFaturamentoModelLocalList = []; 
		for (ContratoHistFaturamentoModel object in contratoHistFaturamentoModelList ?? []) { 
			contratoHistFaturamentoModelLocalList.add(object.toJson); 
		}
		jsonData['contratoHistFaturamentoModelList'] = contratoHistFaturamentoModelLocalList;
		jsonData['tipoContratoModel'] = tipoContratoModel?.toJson;
		jsonData['contratoSolicitacaoServicoModel'] = contratoSolicitacaoServicoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idSolicitacaoServico = plutoRow.cells['idSolicitacaoServico']?.value;
		idTipoContrato = plutoRow.cells['idTipoContrato']?.value;
		numero = plutoRow.cells['numero']?.value;
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		dataCadastro = Util.stringToDate(plutoRow.cells['dataCadastro']?.value);
		dataInicioVigencia = Util.stringToDate(plutoRow.cells['dataInicioVigencia']?.value);
		dataFimVigencia = Util.stringToDate(plutoRow.cells['dataFimVigencia']?.value);
		diaFaturamento = plutoRow.cells['diaFaturamento']?.value;
		valor = plutoRow.cells['valor']?.value?.toDouble();
		quantidadeParcelas = plutoRow.cells['quantidadeParcelas']?.value;
		intervaloEntreParcelas = plutoRow.cells['intervaloEntreParcelas']?.value;
		classificacaoContabilConta = plutoRow.cells['classificacaoContabilConta']?.value;
		observacao = plutoRow.cells['observacao']?.value;
		contratoHistoricoReajusteModelList = [];
		contratoPrevFaturamentoModelList = [];
		contratoHistFaturamentoModelList = [];
		tipoContratoModel = TipoContratoModel();
		tipoContratoModel?.nome = plutoRow.cells['tipoContratoModel']?.value;
		contratoSolicitacaoServicoModel = ContratoSolicitacaoServicoModel();
		contratoSolicitacaoServicoModel?.descricao = plutoRow.cells['contratoSolicitacaoServicoModel']?.value;
	}	

	ContratoModel clone() {
		return ContratoModel(
			id: id,
			idSolicitacaoServico: idSolicitacaoServico,
			idTipoContrato: idTipoContrato,
			numero: numero,
			nome: nome,
			descricao: descricao,
			dataCadastro: dataCadastro,
			dataInicioVigencia: dataInicioVigencia,
			dataFimVigencia: dataFimVigencia,
			diaFaturamento: diaFaturamento,
			valor: valor,
			quantidadeParcelas: quantidadeParcelas,
			intervaloEntreParcelas: intervaloEntreParcelas,
			classificacaoContabilConta: classificacaoContabilConta,
			observacao: observacao,
			contratoHistoricoReajusteModelList: contratoHistoricoReajusteModelListClone(contratoHistoricoReajusteModelList!),
			contratoPrevFaturamentoModelList: contratoPrevFaturamentoModelListClone(contratoPrevFaturamentoModelList!),
			contratoHistFaturamentoModelList: contratoHistFaturamentoModelListClone(contratoHistFaturamentoModelList!),
		);			
	}

	contratoHistoricoReajusteModelListClone(List<ContratoHistoricoReajusteModel> contratoHistoricoReajusteModelList) { 
		List<ContratoHistoricoReajusteModel> resultList = [];
		for (var contratoHistoricoReajusteModel in contratoHistoricoReajusteModelList) {
			resultList.add(
				ContratoHistoricoReajusteModel(
					id: contratoHistoricoReajusteModel.id,
					idContrato: contratoHistoricoReajusteModel.idContrato,
					indice: contratoHistoricoReajusteModel.indice,
					valorAnterior: contratoHistoricoReajusteModel.valorAnterior,
					valorAtual: contratoHistoricoReajusteModel.valorAtual,
					dataReajuste: contratoHistoricoReajusteModel.dataReajuste,
					observacao: contratoHistoricoReajusteModel.observacao,
				)
			);
		}
		return resultList;
	}

	contratoPrevFaturamentoModelListClone(List<ContratoPrevFaturamentoModel> contratoPrevFaturamentoModelList) { 
		List<ContratoPrevFaturamentoModel> resultList = [];
		for (var contratoPrevFaturamentoModel in contratoPrevFaturamentoModelList) {
			resultList.add(
				ContratoPrevFaturamentoModel(
					id: contratoPrevFaturamentoModel.id,
					idContrato: contratoPrevFaturamentoModel.idContrato,
					dataPrevista: contratoPrevFaturamentoModel.dataPrevista,
					valor: contratoPrevFaturamentoModel.valor,
				)
			);
		}
		return resultList;
	}

	contratoHistFaturamentoModelListClone(List<ContratoHistFaturamentoModel> contratoHistFaturamentoModelList) { 
		List<ContratoHistFaturamentoModel> resultList = [];
		for (var contratoHistFaturamentoModel in contratoHistFaturamentoModelList) {
			resultList.add(
				ContratoHistFaturamentoModel(
					id: contratoHistFaturamentoModel.id,
					idContrato: contratoHistFaturamentoModel.idContrato,
					dataFatura: contratoHistFaturamentoModel.dataFatura,
					valor: contratoHistFaturamentoModel.valor,
				)
			);
		}
		return resultList;
	}

	
}