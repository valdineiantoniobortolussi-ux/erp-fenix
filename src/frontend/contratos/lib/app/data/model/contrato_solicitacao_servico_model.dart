import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contratos/app/infra/infra_imports.dart';
import 'package:contratos/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:contratos/app/data/domain/domain_imports.dart';

class ContratoSolicitacaoServicoModel {
	int? id;
	int? idContratoTipoServico;
	int? idSetor;
	int? idColaborador;
	int? idCliente;
	int? idFornecedor;
	DateTime? dataSolicitacao;
	DateTime? dataDesejadaInicio;
	String? urgente;
	String? statusSolicitacao;
	String? descricao;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;
	ViewPessoaClienteModel? viewPessoaClienteModel;
	ViewPessoaFornecedorModel? viewPessoaFornecedorModel;
	SetorModel? setorModel;
	ContratoTipoServicoModel? contratoTipoServicoModel;

	ContratoSolicitacaoServicoModel({
		this.id,
		this.idContratoTipoServico,
		this.idSetor,
		this.idColaborador,
		this.idCliente,
		this.idFornecedor,
		this.dataSolicitacao,
		this.dataDesejadaInicio,
		this.urgente,
		this.statusSolicitacao,
		this.descricao,
		this.viewPessoaColaboradorModel,
		this.viewPessoaClienteModel,
		this.viewPessoaFornecedorModel,
		this.setorModel,
		this.contratoTipoServicoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_solicitacao',
		'data_desejada_inicio',
		'urgente',
		'status_solicitacao',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Solicitacao',
		'Data Desejada Inicio',
		'Urgente',
		'Status Solicitacao',
		'Descricao',
	];

	ContratoSolicitacaoServicoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idContratoTipoServico = jsonData['idContratoTipoServico'];
		idSetor = jsonData['idSetor'];
		idColaborador = jsonData['idColaborador'];
		idCliente = jsonData['idCliente'];
		idFornecedor = jsonData['idFornecedor'];
		dataSolicitacao = jsonData['dataSolicitacao'] != null ? DateTime.tryParse(jsonData['dataSolicitacao']) : null;
		dataDesejadaInicio = jsonData['dataDesejadaInicio'] != null ? DateTime.tryParse(jsonData['dataDesejadaInicio']) : null;
		urgente = ContratoSolicitacaoServicoDomain.getUrgente(jsonData['urgente']);
		statusSolicitacao = ContratoSolicitacaoServicoDomain.getStatusSolicitacao(jsonData['statusSolicitacao']);
		descricao = jsonData['descricao'];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
		viewPessoaClienteModel = jsonData['viewPessoaClienteModel'] == null ? ViewPessoaClienteModel() : ViewPessoaClienteModel.fromJson(jsonData['viewPessoaClienteModel']);
		viewPessoaFornecedorModel = jsonData['viewPessoaFornecedorModel'] == null ? ViewPessoaFornecedorModel() : ViewPessoaFornecedorModel.fromJson(jsonData['viewPessoaFornecedorModel']);
		setorModel = jsonData['setorModel'] == null ? SetorModel() : SetorModel.fromJson(jsonData['setorModel']);
		contratoTipoServicoModel = jsonData['contratoTipoServicoModel'] == null ? ContratoTipoServicoModel() : ContratoTipoServicoModel.fromJson(jsonData['contratoTipoServicoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idContratoTipoServico'] = idContratoTipoServico != 0 ? idContratoTipoServico : null;
		jsonData['idSetor'] = idSetor != 0 ? idSetor : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['idCliente'] = idCliente != 0 ? idCliente : null;
		jsonData['idFornecedor'] = idFornecedor != 0 ? idFornecedor : null;
		jsonData['dataSolicitacao'] = dataSolicitacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataSolicitacao!) : null;
		jsonData['dataDesejadaInicio'] = dataDesejadaInicio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataDesejadaInicio!) : null;
		jsonData['urgente'] = ContratoSolicitacaoServicoDomain.setUrgente(urgente);
		jsonData['statusSolicitacao'] = ContratoSolicitacaoServicoDomain.setStatusSolicitacao(statusSolicitacao);
		jsonData['descricao'] = descricao;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
		jsonData['viewPessoaClienteModel'] = viewPessoaClienteModel?.toJson;
		jsonData['viewPessoaFornecedorModel'] = viewPessoaFornecedorModel?.toJson;
		jsonData['setorModel'] = setorModel?.toJson;
		jsonData['contratoTipoServicoModel'] = contratoTipoServicoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idContratoTipoServico = plutoRow.cells['idContratoTipoServico']?.value;
		idSetor = plutoRow.cells['idSetor']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		idCliente = plutoRow.cells['idCliente']?.value;
		idFornecedor = plutoRow.cells['idFornecedor']?.value;
		dataSolicitacao = Util.stringToDate(plutoRow.cells['dataSolicitacao']?.value);
		dataDesejadaInicio = Util.stringToDate(plutoRow.cells['dataDesejadaInicio']?.value);
		urgente = plutoRow.cells['urgente']?.value != '' ? plutoRow.cells['urgente']?.value : 'S';
		statusSolicitacao = plutoRow.cells['statusSolicitacao']?.value != '' ? plutoRow.cells['statusSolicitacao']?.value : 'Aguardando';
		descricao = plutoRow.cells['descricao']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
		viewPessoaClienteModel = ViewPessoaClienteModel();
		viewPessoaClienteModel?.nome = plutoRow.cells['viewPessoaClienteModel']?.value;
		viewPessoaFornecedorModel = ViewPessoaFornecedorModel();
		viewPessoaFornecedorModel?.nome = plutoRow.cells['viewPessoaFornecedorModel']?.value;
		setorModel = SetorModel();
		setorModel?.nome = plutoRow.cells['setorModel']?.value;
		contratoTipoServicoModel = ContratoTipoServicoModel();
		contratoTipoServicoModel?.nome = plutoRow.cells['contratoTipoServicoModel']?.value;
	}	

	ContratoSolicitacaoServicoModel clone() {
		return ContratoSolicitacaoServicoModel(
			id: id,
			idContratoTipoServico: idContratoTipoServico,
			idSetor: idSetor,
			idColaborador: idColaborador,
			idCliente: idCliente,
			idFornecedor: idFornecedor,
			dataSolicitacao: dataSolicitacao,
			dataDesejadaInicio: dataDesejadaInicio,
			urgente: urgente,
			statusSolicitacao: statusSolicitacao,
			descricao: descricao,
		);			
	}

	
}