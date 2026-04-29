import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ordem_servico/app/infra/infra_imports.dart';
import 'package:ordem_servico/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class OsAberturaModel {
	int? id;
	int? idOsStatus;
	int? idColaborador;
	int? idCliente;
	String? numero;
	DateTime? dataInicio;
	String? horaInicio;
	DateTime? dataPrevisao;
	String? horaPrevisao;
	DateTime? dataFim;
	String? horaFim;
	String? nomeContato;
	String? foneContato;
	String? observacaoCliente;
	String? observacaoAbertura;
	List<OsAberturaEquipamentoModel>? osAberturaEquipamentoModelList;
	List<OsProdutoServicoModel>? osProdutoServicoModelList;
	List<OsEvolucaoModel>? osEvolucaoModelList;
	ViewPessoaClienteModel? viewPessoaClienteModel;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;
	OsStatusModel? osStatusModel;

	OsAberturaModel({
		this.id,
		this.idOsStatus,
		this.idColaborador,
		this.idCliente,
		this.numero,
		this.dataInicio,
		this.horaInicio,
		this.dataPrevisao,
		this.horaPrevisao,
		this.dataFim,
		this.horaFim,
		this.nomeContato,
		this.foneContato,
		this.observacaoCliente,
		this.observacaoAbertura,
		this.osAberturaEquipamentoModelList,
		this.osProdutoServicoModelList,
		this.osEvolucaoModelList,
		this.viewPessoaClienteModel,
		this.viewPessoaColaboradorModel,
		this.osStatusModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero',
		'data_inicio',
		'hora_inicio',
		'data_previsao',
		'hora_previsao',
		'data_fim',
		'hora_fim',
		'nome_contato',
		'fone_contato',
		'observacao_cliente',
		'observacao_abertura',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero',
		'Data Inicio',
		'Hora Inicio',
		'Data Previsao',
		'Hora Previsao',
		'Data Fim',
		'Hora Fim',
		'Nome Contato',
		'Fone Contato',
		'Observacao Cliente',
		'Observacao Abertura',
	];

	OsAberturaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idOsStatus = jsonData['idOsStatus'];
		idColaborador = jsonData['idColaborador'];
		idCliente = jsonData['idCliente'];
		numero = jsonData['numero'];
		dataInicio = jsonData['dataInicio'] != null ? DateTime.tryParse(jsonData['dataInicio']) : null;
		horaInicio = jsonData['horaInicio'];
		dataPrevisao = jsonData['dataPrevisao'] != null ? DateTime.tryParse(jsonData['dataPrevisao']) : null;
		horaPrevisao = jsonData['horaPrevisao'];
		dataFim = jsonData['dataFim'] != null ? DateTime.tryParse(jsonData['dataFim']) : null;
		horaFim = jsonData['horaFim'];
		nomeContato = jsonData['nomeContato'];
		foneContato = jsonData['foneContato'];
		observacaoCliente = jsonData['observacaoCliente'];
		observacaoAbertura = jsonData['observacaoAbertura'];
		osAberturaEquipamentoModelList = (jsonData['osAberturaEquipamentoModelList'] as Iterable?)?.map((m) => OsAberturaEquipamentoModel.fromJson(m)).toList() ?? [];
		osProdutoServicoModelList = (jsonData['osProdutoServicoModelList'] as Iterable?)?.map((m) => OsProdutoServicoModel.fromJson(m)).toList() ?? [];
		osEvolucaoModelList = (jsonData['osEvolucaoModelList'] as Iterable?)?.map((m) => OsEvolucaoModel.fromJson(m)).toList() ?? [];
		viewPessoaClienteModel = jsonData['viewPessoaClienteModel'] == null ? ViewPessoaClienteModel() : ViewPessoaClienteModel.fromJson(jsonData['viewPessoaClienteModel']);
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
		osStatusModel = jsonData['osStatusModel'] == null ? OsStatusModel() : OsStatusModel.fromJson(jsonData['osStatusModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idOsStatus'] = idOsStatus != 0 ? idOsStatus : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['idCliente'] = idCliente != 0 ? idCliente : null;
		jsonData['numero'] = numero;
		jsonData['dataInicio'] = dataInicio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicio!) : null;
		jsonData['horaInicio'] = horaInicio;
		jsonData['dataPrevisao'] = dataPrevisao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataPrevisao!) : null;
		jsonData['horaPrevisao'] = Util.removeMask(horaPrevisao);
		jsonData['dataFim'] = dataFim != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFim!) : null;
		jsonData['horaFim'] = Util.removeMask(horaFim);
		jsonData['nomeContato'] = nomeContato;
		jsonData['foneContato'] = Util.removeMask(foneContato);
		jsonData['observacaoCliente'] = observacaoCliente;
		jsonData['observacaoAbertura'] = observacaoAbertura;
		
		var osAberturaEquipamentoModelLocalList = []; 
		for (OsAberturaEquipamentoModel object in osAberturaEquipamentoModelList ?? []) { 
			osAberturaEquipamentoModelLocalList.add(object.toJson); 
		}
		jsonData['osAberturaEquipamentoModelList'] = osAberturaEquipamentoModelLocalList;
		
		var osProdutoServicoModelLocalList = []; 
		for (OsProdutoServicoModel object in osProdutoServicoModelList ?? []) { 
			osProdutoServicoModelLocalList.add(object.toJson); 
		}
		jsonData['osProdutoServicoModelList'] = osProdutoServicoModelLocalList;
		
		var osEvolucaoModelLocalList = []; 
		for (OsEvolucaoModel object in osEvolucaoModelList ?? []) { 
			osEvolucaoModelLocalList.add(object.toJson); 
		}
		jsonData['osEvolucaoModelList'] = osEvolucaoModelLocalList;
		jsonData['viewPessoaClienteModel'] = viewPessoaClienteModel?.toJson;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
		jsonData['osStatusModel'] = osStatusModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idOsStatus = plutoRow.cells['idOsStatus']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		idCliente = plutoRow.cells['idCliente']?.value;
		numero = plutoRow.cells['numero']?.value;
		dataInicio = Util.stringToDate(plutoRow.cells['dataInicio']?.value);
		horaInicio = plutoRow.cells['horaInicio']?.value;
		dataPrevisao = Util.stringToDate(plutoRow.cells['dataPrevisao']?.value);
		horaPrevisao = plutoRow.cells['horaPrevisao']?.value;
		dataFim = Util.stringToDate(plutoRow.cells['dataFim']?.value);
		horaFim = plutoRow.cells['horaFim']?.value;
		nomeContato = plutoRow.cells['nomeContato']?.value;
		foneContato = plutoRow.cells['foneContato']?.value;
		observacaoCliente = plutoRow.cells['observacaoCliente']?.value;
		observacaoAbertura = plutoRow.cells['observacaoAbertura']?.value;
		osAberturaEquipamentoModelList = [];
		osProdutoServicoModelList = [];
		osEvolucaoModelList = [];
		viewPessoaClienteModel = ViewPessoaClienteModel();
		viewPessoaClienteModel?.nome = plutoRow.cells['viewPessoaClienteModel']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
		osStatusModel = OsStatusModel();
		osStatusModel?.nome = plutoRow.cells['osStatusModel']?.value;
	}	

	OsAberturaModel clone() {
		return OsAberturaModel(
			id: id,
			idOsStatus: idOsStatus,
			idColaborador: idColaborador,
			idCliente: idCliente,
			numero: numero,
			dataInicio: dataInicio,
			horaInicio: horaInicio,
			dataPrevisao: dataPrevisao,
			horaPrevisao: horaPrevisao,
			dataFim: dataFim,
			horaFim: horaFim,
			nomeContato: nomeContato,
			foneContato: foneContato,
			observacaoCliente: observacaoCliente,
			observacaoAbertura: observacaoAbertura,
			osAberturaEquipamentoModelList: osAberturaEquipamentoModelListClone(osAberturaEquipamentoModelList!),
			osProdutoServicoModelList: osProdutoServicoModelListClone(osProdutoServicoModelList!),
			osEvolucaoModelList: osEvolucaoModelListClone(osEvolucaoModelList!),
		);			
	}

	osAberturaEquipamentoModelListClone(List<OsAberturaEquipamentoModel> osAberturaEquipamentoModelList) { 
		List<OsAberturaEquipamentoModel> resultList = [];
		for (var osAberturaEquipamentoModel in osAberturaEquipamentoModelList) {
			resultList.add(
				OsAberturaEquipamentoModel(
					id: osAberturaEquipamentoModel.id,
					idOsAbertura: osAberturaEquipamentoModel.idOsAbertura,
					idOsEquipamento: osAberturaEquipamentoModel.idOsEquipamento,
					tipoCobertura: osAberturaEquipamentoModel.tipoCobertura,
					numeroSerie: osAberturaEquipamentoModel.numeroSerie,
				)
			);
		}
		return resultList;
	}

	osProdutoServicoModelListClone(List<OsProdutoServicoModel> osProdutoServicoModelList) { 
		List<OsProdutoServicoModel> resultList = [];
		for (var osProdutoServicoModel in osProdutoServicoModelList) {
			resultList.add(
				OsProdutoServicoModel(
					id: osProdutoServicoModel.id,
					idOsAbertura: osProdutoServicoModel.idOsAbertura,
					idProduto: osProdutoServicoModel.idProduto,
					tipo: osProdutoServicoModel.tipo,
					complemento: osProdutoServicoModel.complemento,
					quantidade: osProdutoServicoModel.quantidade,
					valorUnitario: osProdutoServicoModel.valorUnitario,
					valorSubtotal: osProdutoServicoModel.valorSubtotal,
					taxaDesconto: osProdutoServicoModel.taxaDesconto,
					valorDesconto: osProdutoServicoModel.valorDesconto,
					valorTotal: osProdutoServicoModel.valorTotal,
				)
			);
		}
		return resultList;
	}

	osEvolucaoModelListClone(List<OsEvolucaoModel> osEvolucaoModelList) { 
		List<OsEvolucaoModel> resultList = [];
		for (var osEvolucaoModel in osEvolucaoModelList) {
			resultList.add(
				OsEvolucaoModel(
					id: osEvolucaoModel.id,
					idOsAbertura: osEvolucaoModel.idOsAbertura,
					dataRegistro: osEvolucaoModel.dataRegistro,
					horaRegistro: osEvolucaoModel.horaRegistro,
					enviarEmail: osEvolucaoModel.enviarEmail,
					observacao: osEvolucaoModel.observacao,
				)
			);
		}
		return resultList;
	}

	
}