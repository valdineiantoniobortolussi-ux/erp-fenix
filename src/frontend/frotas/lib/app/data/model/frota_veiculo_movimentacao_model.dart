import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class FrotaVeiculoMovimentacaoModel {
	int? id;
	int? idFrotaVeiculo;
	int? idFrotaMotorista;
	DateTime? dataSaida;
	String? horaSaida;
	DateTime? dataEntrada;
	String? horaEntrada;
	String? observacao;
	FrotaMotoristaModel? frotaMotoristaModel;

	FrotaVeiculoMovimentacaoModel({
		this.id,
		this.idFrotaVeiculo,
		this.idFrotaMotorista,
		this.dataSaida,
		this.horaSaida,
		this.dataEntrada,
		this.horaEntrada,
		this.observacao,
		this.frotaMotoristaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_saida',
		'hora_saida',
		'data_entrada',
		'hora_entrada',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Saida',
		'Hora Saida',
		'Data Entrada',
		'Hora Entrada',
		'Observacao',
	];

	FrotaVeiculoMovimentacaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFrotaVeiculo = jsonData['idFrotaVeiculo'];
		idFrotaMotorista = jsonData['idFrotaMotorista'];
		dataSaida = jsonData['dataSaida'] != null ? DateTime.tryParse(jsonData['dataSaida']) : null;
		horaSaida = jsonData['horaSaida'];
		dataEntrada = jsonData['dataEntrada'] != null ? DateTime.tryParse(jsonData['dataEntrada']) : null;
		horaEntrada = jsonData['horaEntrada'];
		observacao = jsonData['observacao'];
		frotaMotoristaModel = jsonData['frotaMotoristaModel'] == null ? FrotaMotoristaModel() : FrotaMotoristaModel.fromJson(jsonData['frotaMotoristaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFrotaVeiculo'] = idFrotaVeiculo != 0 ? idFrotaVeiculo : null;
		jsonData['idFrotaMotorista'] = idFrotaMotorista != 0 ? idFrotaMotorista : null;
		jsonData['dataSaida'] = dataSaida != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataSaida!) : null;
		jsonData['horaSaida'] = Util.removeMask(horaSaida);
		jsonData['dataEntrada'] = dataEntrada != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEntrada!) : null;
		jsonData['horaEntrada'] = Util.removeMask(horaEntrada);
		jsonData['observacao'] = observacao;
		jsonData['frotaMotoristaModel'] = frotaMotoristaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idFrotaVeiculo = plutoRow.cells['idFrotaVeiculo']?.value;
		idFrotaMotorista = plutoRow.cells['idFrotaMotorista']?.value;
		dataSaida = Util.stringToDate(plutoRow.cells['dataSaida']?.value);
		horaSaida = plutoRow.cells['horaSaida']?.value;
		dataEntrada = Util.stringToDate(plutoRow.cells['dataEntrada']?.value);
		horaEntrada = plutoRow.cells['horaEntrada']?.value;
		observacao = plutoRow.cells['observacao']?.value;
		frotaMotoristaModel = FrotaMotoristaModel();
		frotaMotoristaModel?.nome = plutoRow.cells['frotaMotoristaModel']?.value;
	}	

	FrotaVeiculoMovimentacaoModel clone() {
		return FrotaVeiculoMovimentacaoModel(
			id: id,
			idFrotaVeiculo: idFrotaVeiculo,
			idFrotaMotorista: idFrotaMotorista,
			dataSaida: dataSaida,
			horaSaida: horaSaida,
			dataEntrada: dataEntrada,
			horaEntrada: horaEntrada,
			observacao: observacao,
		);			
	}

	
}