import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class FeriadosModel {
	int? id;
	String? ano;
	String? nome;
	String? abrangencia;
	String? uf;
	int? municipioIbge;
	String? tipo;
	DateTime? dataFeriado;

	FeriadosModel({
		this.id,
		this.ano,
		this.nome,
		this.abrangencia,
		this.uf,
		this.municipioIbge,
		this.tipo,
		this.dataFeriado,
	});

	static List<String> dbColumns = <String>[
		'id',
		'ano',
		'nome',
		'abrangencia',
		'uf',
		'municipio_ibge',
		'tipo',
		'data_feriado',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Ano',
		'Nome',
		'Abrangencia',
		'Uf',
		'Municipio Ibge',
		'Tipo',
		'Data Feriado',
	];

	FeriadosModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		ano = jsonData['ano'];
		nome = jsonData['nome'];
		abrangencia = FeriadosDomain.getAbrangencia(jsonData['abrangencia']);
		uf = FeriadosDomain.getUf(jsonData['uf']);
		municipioIbge = jsonData['municipioIbge'];
		tipo = FeriadosDomain.getTipo(jsonData['tipo']);
		dataFeriado = jsonData['dataFeriado'] != null ? DateTime.tryParse(jsonData['dataFeriado']) : null;
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['ano'] = ano;
		jsonData['nome'] = nome;
		jsonData['abrangencia'] = FeriadosDomain.setAbrangencia(abrangencia);
		jsonData['uf'] = FeriadosDomain.setUf(uf);
		jsonData['municipioIbge'] = municipioIbge;
		jsonData['tipo'] = FeriadosDomain.setTipo(tipo);
		jsonData['dataFeriado'] = dataFeriado != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFeriado!) : null;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		ano = plutoRow.cells['ano']?.value;
		nome = plutoRow.cells['nome']?.value;
		abrangencia = plutoRow.cells['abrangencia']?.value != '' ? plutoRow.cells['abrangencia']?.value : 'Federal';
		uf = plutoRow.cells['uf']?.value != '' ? plutoRow.cells['uf']?.value : 'AC';
		municipioIbge = plutoRow.cells['municipioIbge']?.value;
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Fixo.Movel';
		dataFeriado = Util.stringToDate(plutoRow.cells['dataFeriado']?.value);
	}	

	FeriadosModel clone() {
		return FeriadosModel(
			id: id,
			ano: ano,
			nome: nome,
			abrangencia: abrangencia,
			uf: uf,
			municipioIbge: municipioIbge,
			tipo: tipo,
			dataFeriado: dataFeriado,
		);			
	}

	
}