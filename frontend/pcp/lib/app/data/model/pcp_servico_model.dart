import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:pcp/app/infra/infra_imports.dart';
import 'package:pcp/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class PcpServicoModel {
	int? id;
	int? idPcpOpDetalhe;
	DateTime? inicioRealizado;
	DateTime? terminoRealizado;
	int? horasRealizado;
	int? minutosRealizado;
	int? segundosRealizado;
	double? custoRealizado;
	DateTime? inicioPrevisto;
	DateTime? terminoPrevisto;
	int? horasPrevisto;
	int? minutosPrevisto;
	int? segundosPrevisto;
	double? custoPrevisto;
	List<PcpServicoColaboradorModel>? pcpServicoColaboradorModelList;
	List<PcpServicoEquipamentoModel>? pcpServicoEquipamentoModelList;
	PcpOpDetalheModel? pcpOpDetalheModel;

	PcpServicoModel({
		this.id,
		this.idPcpOpDetalhe,
		this.inicioRealizado,
		this.terminoRealizado,
		this.horasRealizado,
		this.minutosRealizado,
		this.segundosRealizado,
		this.custoRealizado,
		this.inicioPrevisto,
		this.terminoPrevisto,
		this.horasPrevisto,
		this.minutosPrevisto,
		this.segundosPrevisto,
		this.custoPrevisto,
		this.pcpServicoColaboradorModelList,
		this.pcpServicoEquipamentoModelList,
		this.pcpOpDetalheModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'inicio_realizado',
		'termino_realizado',
		'horas_realizado',
		'minutos_realizado',
		'segundos_realizado',
		'custo_realizado',
		'inicio_previsto',
		'termino_previsto',
		'horas_previsto',
		'minutos_previsto',
		'segundos_previsto',
		'custo_previsto',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Inicio Realizado',
		'Termino Realizado',
		'Horas Realizado',
		'Minutos Realizado',
		'Segundos Realizado',
		'Custo Realizado',
		'Inicio Previsto',
		'Termino Previsto',
		'Horas Previsto',
		'Minutos Previsto',
		'Segundos Previsto',
		'Custo Previsto',
	];

	PcpServicoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPcpOpDetalhe = jsonData['idPcpOpDetalhe'];
		inicioRealizado = jsonData['inicioRealizado'] != null ? DateTime.tryParse(jsonData['inicioRealizado']) : null;
		terminoRealizado = jsonData['terminoRealizado'] != null ? DateTime.tryParse(jsonData['terminoRealizado']) : null;
		horasRealizado = jsonData['horasRealizado'];
		minutosRealizado = jsonData['minutosRealizado'];
		segundosRealizado = jsonData['segundosRealizado'];
		custoRealizado = jsonData['custoRealizado']?.toDouble();
		inicioPrevisto = jsonData['inicioPrevisto'] != null ? DateTime.tryParse(jsonData['inicioPrevisto']) : null;
		terminoPrevisto = jsonData['terminoPrevisto'] != null ? DateTime.tryParse(jsonData['terminoPrevisto']) : null;
		horasPrevisto = jsonData['horasPrevisto'];
		minutosPrevisto = jsonData['minutosPrevisto'];
		segundosPrevisto = jsonData['segundosPrevisto'];
		custoPrevisto = jsonData['custoPrevisto']?.toDouble();
		pcpServicoColaboradorModelList = (jsonData['pcpServicoColaboradorModelList'] as Iterable?)?.map((m) => PcpServicoColaboradorModel.fromJson(m)).toList() ?? [];
		pcpServicoEquipamentoModelList = (jsonData['pcpServicoEquipamentoModelList'] as Iterable?)?.map((m) => PcpServicoEquipamentoModel.fromJson(m)).toList() ?? [];
		pcpOpDetalheModel = jsonData['pcpOpDetalheModel'] == null ? PcpOpDetalheModel() : PcpOpDetalheModel.fromJson(jsonData['pcpOpDetalheModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPcpOpDetalhe'] = idPcpOpDetalhe != 0 ? idPcpOpDetalhe : null;
		jsonData['inicioRealizado'] = inicioRealizado != null ? DateFormat('yyyy-MM-ddT00:00:00').format(inicioRealizado!) : null;
		jsonData['terminoRealizado'] = terminoRealizado != null ? DateFormat('yyyy-MM-ddT00:00:00').format(terminoRealizado!) : null;
		jsonData['horasRealizado'] = horasRealizado;
		jsonData['minutosRealizado'] = minutosRealizado;
		jsonData['segundosRealizado'] = segundosRealizado;
		jsonData['custoRealizado'] = custoRealizado;
		jsonData['inicioPrevisto'] = inicioPrevisto != null ? DateFormat('yyyy-MM-ddT00:00:00').format(inicioPrevisto!) : null;
		jsonData['terminoPrevisto'] = terminoPrevisto != null ? DateFormat('yyyy-MM-ddT00:00:00').format(terminoPrevisto!) : null;
		jsonData['horasPrevisto'] = horasPrevisto;
		jsonData['minutosPrevisto'] = minutosPrevisto;
		jsonData['segundosPrevisto'] = segundosPrevisto;
		jsonData['custoPrevisto'] = custoPrevisto;
		
		var pcpServicoColaboradorModelLocalList = []; 
		for (PcpServicoColaboradorModel object in pcpServicoColaboradorModelList ?? []) { 
			pcpServicoColaboradorModelLocalList.add(object.toJson); 
		}
		jsonData['pcpServicoColaboradorModelList'] = pcpServicoColaboradorModelLocalList;
		
		var pcpServicoEquipamentoModelLocalList = []; 
		for (PcpServicoEquipamentoModel object in pcpServicoEquipamentoModelList ?? []) { 
			pcpServicoEquipamentoModelLocalList.add(object.toJson); 
		}
		jsonData['pcpServicoEquipamentoModelList'] = pcpServicoEquipamentoModelLocalList;
		jsonData['pcpOpDetalheModel'] = pcpOpDetalheModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPcpOpDetalhe = plutoRow.cells['idPcpOpDetalhe']?.value;
		inicioRealizado = Util.stringToDate(plutoRow.cells['inicioRealizado']?.value);
		terminoRealizado = Util.stringToDate(plutoRow.cells['terminoRealizado']?.value);
		horasRealizado = plutoRow.cells['horasRealizado']?.value;
		minutosRealizado = plutoRow.cells['minutosRealizado']?.value;
		segundosRealizado = plutoRow.cells['segundosRealizado']?.value;
		custoRealizado = plutoRow.cells['custoRealizado']?.value?.toDouble();
		inicioPrevisto = Util.stringToDate(plutoRow.cells['inicioPrevisto']?.value);
		terminoPrevisto = Util.stringToDate(plutoRow.cells['terminoPrevisto']?.value);
		horasPrevisto = plutoRow.cells['horasPrevisto']?.value;
		minutosPrevisto = plutoRow.cells['minutosPrevisto']?.value;
		segundosPrevisto = plutoRow.cells['segundosPrevisto']?.value;
		custoPrevisto = plutoRow.cells['custoPrevisto']?.value?.toDouble();
		pcpServicoColaboradorModelList = [];
		pcpServicoEquipamentoModelList = [];
		pcpOpDetalheModel = PcpOpDetalheModel();
		pcpOpDetalheModel?.id = plutoRow.cells['pcpOpDetalheModel']?.value;
	}	

	PcpServicoModel clone() {
		return PcpServicoModel(
			id: id,
			idPcpOpDetalhe: idPcpOpDetalhe,
			inicioRealizado: inicioRealizado,
			terminoRealizado: terminoRealizado,
			horasRealizado: horasRealizado,
			minutosRealizado: minutosRealizado,
			segundosRealizado: segundosRealizado,
			custoRealizado: custoRealizado,
			inicioPrevisto: inicioPrevisto,
			terminoPrevisto: terminoPrevisto,
			horasPrevisto: horasPrevisto,
			minutosPrevisto: minutosPrevisto,
			segundosPrevisto: segundosPrevisto,
			custoPrevisto: custoPrevisto,
			pcpServicoColaboradorModelList: pcpServicoColaboradorModelListClone(pcpServicoColaboradorModelList!),
			pcpServicoEquipamentoModelList: pcpServicoEquipamentoModelListClone(pcpServicoEquipamentoModelList!),
		);			
	}

	pcpServicoColaboradorModelListClone(List<PcpServicoColaboradorModel> pcpServicoColaboradorModelList) { 
		List<PcpServicoColaboradorModel> resultList = [];
		for (var pcpServicoColaboradorModel in pcpServicoColaboradorModelList) {
			resultList.add(
				PcpServicoColaboradorModel(
					id: pcpServicoColaboradorModel.id,
					idColaborador: pcpServicoColaboradorModel.idColaborador,
					idPcpServico: pcpServicoColaboradorModel.idPcpServico,
				)
			);
		}
		return resultList;
	}

	pcpServicoEquipamentoModelListClone(List<PcpServicoEquipamentoModel> pcpServicoEquipamentoModelList) { 
		List<PcpServicoEquipamentoModel> resultList = [];
		for (var pcpServicoEquipamentoModel in pcpServicoEquipamentoModelList) {
			resultList.add(
				PcpServicoEquipamentoModel(
					id: pcpServicoEquipamentoModel.id,
					idPcpServico: pcpServicoEquipamentoModel.idPcpServico,
					idPatrimBem: pcpServicoEquipamentoModel.idPatrimBem,
				)
			);
		}
		return resultList;
	}

	
}