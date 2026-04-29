import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:wms/app/data/domain/domain_imports.dart';

class WmsRecebimentoCabecalhoModel {
	int? id;
	int? idWmsAgendamento;
	DateTime? dataRecebimento;
	String? horaInicio;
	String? horaFim;
	int? volumeRecebido;
	double? pesoRecebido;
	String? inconsistencia;
	String? observacao;
	List<WmsRecebimentoDetalheModel>? wmsRecebimentoDetalheModelList;
	WmsAgendamentoModel? wmsAgendamentoModel;

	WmsRecebimentoCabecalhoModel({
		this.id,
		this.idWmsAgendamento,
		this.dataRecebimento,
		this.horaInicio,
		this.horaFim,
		this.volumeRecebido,
		this.pesoRecebido,
		this.inconsistencia,
		this.observacao,
		this.wmsRecebimentoDetalheModelList,
		this.wmsAgendamentoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_recebimento',
		'hora_inicio',
		'hora_fim',
		'volume_recebido',
		'peso_recebido',
		'inconsistencia',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Recebimento',
		'Hora Inicio',
		'Hora Fim',
		'Volume Recebido',
		'Peso Recebido',
		'Inconsistencia',
		'Observacao',
	];

	WmsRecebimentoCabecalhoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idWmsAgendamento = jsonData['idWmsAgendamento'];
		dataRecebimento = jsonData['dataRecebimento'] != null ? DateTime.tryParse(jsonData['dataRecebimento']) : null;
		horaInicio = jsonData['horaInicio'];
		horaFim = jsonData['horaFim'];
		volumeRecebido = jsonData['volumeRecebido'];
		pesoRecebido = jsonData['pesoRecebido']?.toDouble();
		inconsistencia = WmsRecebimentoCabecalhoDomain.getInconsistencia(jsonData['inconsistencia']);
		observacao = jsonData['observacao'];
		wmsRecebimentoDetalheModelList = (jsonData['wmsRecebimentoDetalheModelList'] as Iterable?)?.map((m) => WmsRecebimentoDetalheModel.fromJson(m)).toList() ?? [];
		wmsAgendamentoModel = jsonData['wmsAgendamentoModel'] == null ? WmsAgendamentoModel() : WmsAgendamentoModel.fromJson(jsonData['wmsAgendamentoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idWmsAgendamento'] = idWmsAgendamento != 0 ? idWmsAgendamento : null;
		jsonData['dataRecebimento'] = dataRecebimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataRecebimento!) : null;
		jsonData['horaInicio'] = Util.removeMask(horaInicio);
		jsonData['horaFim'] = Util.removeMask(horaFim);
		jsonData['volumeRecebido'] = volumeRecebido;
		jsonData['pesoRecebido'] = pesoRecebido;
		jsonData['inconsistencia'] = WmsRecebimentoCabecalhoDomain.setInconsistencia(inconsistencia);
		jsonData['observacao'] = observacao;
		
		var wmsRecebimentoDetalheModelLocalList = []; 
		for (WmsRecebimentoDetalheModel object in wmsRecebimentoDetalheModelList ?? []) { 
			wmsRecebimentoDetalheModelLocalList.add(object.toJson); 
		}
		jsonData['wmsRecebimentoDetalheModelList'] = wmsRecebimentoDetalheModelLocalList;
		jsonData['wmsAgendamentoModel'] = wmsAgendamentoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idWmsAgendamento = plutoRow.cells['idWmsAgendamento']?.value;
		dataRecebimento = Util.stringToDate(plutoRow.cells['dataRecebimento']?.value);
		horaInicio = plutoRow.cells['horaInicio']?.value;
		horaFim = plutoRow.cells['horaFim']?.value;
		volumeRecebido = plutoRow.cells['volumeRecebido']?.value;
		pesoRecebido = plutoRow.cells['pesoRecebido']?.value?.toDouble();
		inconsistencia = plutoRow.cells['inconsistencia']?.value != '' ? plutoRow.cells['inconsistencia']?.value : 'S';
		observacao = plutoRow.cells['observacao']?.value;
		wmsRecebimentoDetalheModelList = [];
		wmsAgendamentoModel = WmsAgendamentoModel();
		wmsAgendamentoModel?.local_operacao = plutoRow.cells['wmsAgendamentoModel']?.value;
	}	

	WmsRecebimentoCabecalhoModel clone() {
		return WmsRecebimentoCabecalhoModel(
			id: id,
			idWmsAgendamento: idWmsAgendamento,
			dataRecebimento: dataRecebimento,
			horaInicio: horaInicio,
			horaFim: horaFim,
			volumeRecebido: volumeRecebido,
			pesoRecebido: pesoRecebido,
			inconsistencia: inconsistencia,
			observacao: observacao,
			wmsRecebimentoDetalheModelList: wmsRecebimentoDetalheModelListClone(wmsRecebimentoDetalheModelList!),
		);			
	}

	wmsRecebimentoDetalheModelListClone(List<WmsRecebimentoDetalheModel> wmsRecebimentoDetalheModelList) { 
		List<WmsRecebimentoDetalheModel> resultList = [];
		for (var wmsRecebimentoDetalheModel in wmsRecebimentoDetalheModelList) {
			resultList.add(
				WmsRecebimentoDetalheModel(
					id: wmsRecebimentoDetalheModel.id,
					idWmsRecebimentoCabecalho: wmsRecebimentoDetalheModel.idWmsRecebimentoCabecalho,
					idProduto: wmsRecebimentoDetalheModel.idProduto,
					quantidadeVolume: wmsRecebimentoDetalheModel.quantidadeVolume,
					quantidadeItemPorVolume: wmsRecebimentoDetalheModel.quantidadeItemPorVolume,
					quantidadeRecebida: wmsRecebimentoDetalheModel.quantidadeRecebida,
					destino: wmsRecebimentoDetalheModel.destino,
				)
			);
		}
		return resultList;
	}

	
}