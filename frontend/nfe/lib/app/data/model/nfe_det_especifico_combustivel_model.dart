import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeDetEspecificoCombustivelModel {
	int? id;
	int? idNfeDetalhe;
	int? codigoAnp;
	String? descricaoAnp;
	double? percentualGlp;
	double? percentualGasNacional;
	double? percentualGasImportado;
	double? valorPartida;
	String? codif;
	double? quantidadeTempAmbiente;
	String? ufConsumo;
	double? cideBaseCalculo;
	double? cideAliquota;
	double? cideValor;
	int? encerranteBico;
	int? encerranteBomba;
	int? encerranteTanque;
	double? encerranteValorInicio;
	double? encerranteValorFim;

	NfeDetEspecificoCombustivelModel({
		this.id,
		this.idNfeDetalhe,
		this.codigoAnp,
		this.descricaoAnp,
		this.percentualGlp,
		this.percentualGasNacional,
		this.percentualGasImportado,
		this.valorPartida,
		this.codif,
		this.quantidadeTempAmbiente,
		this.ufConsumo,
		this.cideBaseCalculo,
		this.cideAliquota,
		this.cideValor,
		this.encerranteBico,
		this.encerranteBomba,
		this.encerranteTanque,
		this.encerranteValorInicio,
		this.encerranteValorFim,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo_anp',
		'descricao_anp',
		'percentual_glp',
		'percentual_gas_nacional',
		'percentual_gas_importado',
		'valor_partida',
		'codif',
		'quantidade_temp_ambiente',
		'uf_consumo',
		'cide_base_calculo',
		'cide_aliquota',
		'cide_valor',
		'encerrante_bico',
		'encerrante_bomba',
		'encerrante_tanque',
		'encerrante_valor_inicio',
		'encerrante_valor_fim',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo Anp',
		'Descricao Anp',
		'Percentual Glp',
		'Percentual Gas Nacional',
		'Percentual Gas Importado',
		'Valor Partida',
		'Codif',
		'Quantidade Temp Ambiente',
		'Uf Consumo',
		'Cide Base Calculo',
		'Cide Aliquota',
		'Cide Valor',
		'Encerrante Bico',
		'Encerrante Bomba',
		'Encerrante Tanque',
		'Encerrante Valor Inicio',
		'Encerrante Valor Fim',
	];

	NfeDetEspecificoCombustivelModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeDetalhe = jsonData['idNfeDetalhe'];
		codigoAnp = jsonData['codigoAnp'];
		descricaoAnp = jsonData['descricaoAnp'];
		percentualGlp = jsonData['percentualGlp']?.toDouble();
		percentualGasNacional = jsonData['percentualGasNacional']?.toDouble();
		percentualGasImportado = jsonData['percentualGasImportado']?.toDouble();
		valorPartida = jsonData['valorPartida']?.toDouble();
		codif = jsonData['codif'];
		quantidadeTempAmbiente = jsonData['quantidadeTempAmbiente']?.toDouble();
		ufConsumo = NfeDetEspecificoCombustivelDomain.getUfConsumo(jsonData['ufConsumo']);
		cideBaseCalculo = jsonData['cideBaseCalculo']?.toDouble();
		cideAliquota = jsonData['cideAliquota']?.toDouble();
		cideValor = jsonData['cideValor']?.toDouble();
		encerranteBico = jsonData['encerranteBico'];
		encerranteBomba = jsonData['encerranteBomba'];
		encerranteTanque = jsonData['encerranteTanque'];
		encerranteValorInicio = jsonData['encerranteValorInicio']?.toDouble();
		encerranteValorFim = jsonData['encerranteValorFim']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeDetalhe'] = idNfeDetalhe != 0 ? idNfeDetalhe : null;
		jsonData['codigoAnp'] = codigoAnp;
		jsonData['descricaoAnp'] = descricaoAnp;
		jsonData['percentualGlp'] = percentualGlp;
		jsonData['percentualGasNacional'] = percentualGasNacional;
		jsonData['percentualGasImportado'] = percentualGasImportado;
		jsonData['valorPartida'] = valorPartida;
		jsonData['codif'] = codif;
		jsonData['quantidadeTempAmbiente'] = quantidadeTempAmbiente;
		jsonData['ufConsumo'] = NfeDetEspecificoCombustivelDomain.setUfConsumo(ufConsumo);
		jsonData['cideBaseCalculo'] = cideBaseCalculo;
		jsonData['cideAliquota'] = cideAliquota;
		jsonData['cideValor'] = cideValor;
		jsonData['encerranteBico'] = encerranteBico;
		jsonData['encerranteBomba'] = encerranteBomba;
		jsonData['encerranteTanque'] = encerranteTanque;
		jsonData['encerranteValorInicio'] = encerranteValorInicio;
		jsonData['encerranteValorFim'] = encerranteValorFim;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeDetalhe = plutoRow.cells['idNfeDetalhe']?.value;
		codigoAnp = plutoRow.cells['codigoAnp']?.value;
		descricaoAnp = plutoRow.cells['descricaoAnp']?.value;
		percentualGlp = plutoRow.cells['percentualGlp']?.value?.toDouble();
		percentualGasNacional = plutoRow.cells['percentualGasNacional']?.value?.toDouble();
		percentualGasImportado = plutoRow.cells['percentualGasImportado']?.value?.toDouble();
		valorPartida = plutoRow.cells['valorPartida']?.value?.toDouble();
		codif = plutoRow.cells['codif']?.value;
		quantidadeTempAmbiente = plutoRow.cells['quantidadeTempAmbiente']?.value?.toDouble();
		ufConsumo = plutoRow.cells['ufConsumo']?.value != '' ? plutoRow.cells['ufConsumo']?.value : 'AC';
		cideBaseCalculo = plutoRow.cells['cideBaseCalculo']?.value?.toDouble();
		cideAliquota = plutoRow.cells['cideAliquota']?.value?.toDouble();
		cideValor = plutoRow.cells['cideValor']?.value?.toDouble();
		encerranteBico = plutoRow.cells['encerranteBico']?.value;
		encerranteBomba = plutoRow.cells['encerranteBomba']?.value;
		encerranteTanque = plutoRow.cells['encerranteTanque']?.value;
		encerranteValorInicio = plutoRow.cells['encerranteValorInicio']?.value?.toDouble();
		encerranteValorFim = plutoRow.cells['encerranteValorFim']?.value?.toDouble();
	}	

	NfeDetEspecificoCombustivelModel clone() {
		return NfeDetEspecificoCombustivelModel(
			id: id,
			idNfeDetalhe: idNfeDetalhe,
			codigoAnp: codigoAnp,
			descricaoAnp: descricaoAnp,
			percentualGlp: percentualGlp,
			percentualGasNacional: percentualGasNacional,
			percentualGasImportado: percentualGasImportado,
			valorPartida: valorPartida,
			codif: codif,
			quantidadeTempAmbiente: quantidadeTempAmbiente,
			ufConsumo: ufConsumo,
			cideBaseCalculo: cideBaseCalculo,
			cideAliquota: cideAliquota,
			cideValor: cideValor,
			encerranteBico: encerranteBico,
			encerranteBomba: encerranteBomba,
			encerranteTanque: encerranteTanque,
			encerranteValorInicio: encerranteValorInicio,
			encerranteValorFim: encerranteValorFim,
		);			
	}

	
}