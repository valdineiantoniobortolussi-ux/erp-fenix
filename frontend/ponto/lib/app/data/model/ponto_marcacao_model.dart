import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:ponto/app/data/domain/domain_imports.dart';

class PontoMarcacaoModel {
	int? id;
	int? idPontoRelogio;
	int? idColaborador;
	int? nsr;
	DateTime? dataMarcacao;
	String? horaMarcacao;
	String? tipoMarcacao;
	String? tipoRegistro;
	String? parEntradaSaida;
	String? justificativa;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;
	PontoRelogioModel? pontoRelogioModel;

	PontoMarcacaoModel({
		this.id,
		this.idPontoRelogio,
		this.idColaborador,
		this.nsr,
		this.dataMarcacao,
		this.horaMarcacao,
		this.tipoMarcacao,
		this.tipoRegistro,
		this.parEntradaSaida,
		this.justificativa,
		this.viewPessoaColaboradorModel,
		this.pontoRelogioModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nsr',
		'data_marcacao',
		'hora_marcacao',
		'tipo_marcacao',
		'tipo_registro',
		'par_entrada_saida',
		'justificativa',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nsr',
		'Data Marcacao',
		'Hora Marcacao',
		'Tipo Marcacao',
		'Tipo Registro',
		'Par Entrada Saida',
		'Justificativa',
	];

	PontoMarcacaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPontoRelogio = jsonData['idPontoRelogio'];
		idColaborador = jsonData['idColaborador'];
		nsr = jsonData['nsr'];
		dataMarcacao = jsonData['dataMarcacao'] != null ? DateTime.tryParse(jsonData['dataMarcacao']) : null;
		horaMarcacao = jsonData['horaMarcacao'];
		tipoMarcacao = PontoMarcacaoDomain.getTipoMarcacao(jsonData['tipoMarcacao']);
		tipoRegistro = PontoMarcacaoDomain.getTipoRegistro(jsonData['tipoRegistro']);
		parEntradaSaida = PontoMarcacaoDomain.getParEntradaSaida(jsonData['parEntradaSaida']);
		justificativa = jsonData['justificativa'];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
		pontoRelogioModel = jsonData['pontoRelogioModel'] == null ? PontoRelogioModel() : PontoRelogioModel.fromJson(jsonData['pontoRelogioModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPontoRelogio'] = idPontoRelogio != 0 ? idPontoRelogio : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['nsr'] = nsr;
		jsonData['dataMarcacao'] = dataMarcacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataMarcacao!) : null;
		jsonData['horaMarcacao'] = horaMarcacao;
		jsonData['tipoMarcacao'] = PontoMarcacaoDomain.setTipoMarcacao(tipoMarcacao);
		jsonData['tipoRegistro'] = PontoMarcacaoDomain.setTipoRegistro(tipoRegistro);
		jsonData['parEntradaSaida'] = PontoMarcacaoDomain.setParEntradaSaida(parEntradaSaida);
		jsonData['justificativa'] = justificativa;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
		jsonData['pontoRelogioModel'] = pontoRelogioModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPontoRelogio = plutoRow.cells['idPontoRelogio']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		nsr = plutoRow.cells['nsr']?.value;
		dataMarcacao = Util.stringToDate(plutoRow.cells['dataMarcacao']?.value);
		horaMarcacao = plutoRow.cells['horaMarcacao']?.value;
		tipoMarcacao = plutoRow.cells['tipoMarcacao']?.value != '' ? plutoRow.cells['tipoMarcacao']?.value : 'Entrada';
		tipoRegistro = plutoRow.cells['tipoRegistro']?.value != '' ? plutoRow.cells['tipoRegistro']?.value : '';
		parEntradaSaida = plutoRow.cells['parEntradaSaida']?.value != '' ? plutoRow.cells['parEntradaSaida']?.value : 'AAA';
		justificativa = plutoRow.cells['justificativa']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
		pontoRelogioModel = PontoRelogioModel();
		pontoRelogioModel?.numero_serie = plutoRow.cells['pontoRelogioModel']?.value;
	}	

	PontoMarcacaoModel clone() {
		return PontoMarcacaoModel(
			id: id,
			idPontoRelogio: idPontoRelogio,
			idColaborador: idColaborador,
			nsr: nsr,
			dataMarcacao: dataMarcacao,
			horaMarcacao: horaMarcacao,
			tipoMarcacao: tipoMarcacao,
			tipoRegistro: tipoRegistro,
			parEntradaSaida: parEntradaSaida,
			justificativa: justificativa,
		);			
	}

	
}