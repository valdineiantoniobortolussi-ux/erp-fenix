import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class RegistroCartorioModel {
	int? id;
	String? nomeCartorio;
	DateTime? dataRegistro;
	int? numero;
	int? folha;
	int? livro;
	String? nire;

	RegistroCartorioModel({
		this.id,
		this.nomeCartorio,
		this.dataRegistro,
		this.numero,
		this.folha,
		this.livro,
		this.nire,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome_cartorio',
		'data_registro',
		'numero',
		'folha',
		'livro',
		'nire',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome Cartorio',
		'Data Registro',
		'Numero',
		'Folha',
		'Livro',
		'Nire',
	];

	RegistroCartorioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nomeCartorio = jsonData['nomeCartorio'];
		dataRegistro = jsonData['dataRegistro'] != null ? DateTime.tryParse(jsonData['dataRegistro']) : null;
		numero = jsonData['numero'];
		folha = jsonData['folha'];
		livro = jsonData['livro'];
		nire = jsonData['nire'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nomeCartorio'] = nomeCartorio;
		jsonData['dataRegistro'] = dataRegistro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataRegistro!) : null;
		jsonData['numero'] = numero;
		jsonData['folha'] = folha;
		jsonData['livro'] = livro;
		jsonData['nire'] = nire;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nomeCartorio = plutoRow.cells['nomeCartorio']?.value;
		dataRegistro = Util.stringToDate(plutoRow.cells['dataRegistro']?.value);
		numero = plutoRow.cells['numero']?.value;
		folha = plutoRow.cells['folha']?.value;
		livro = plutoRow.cells['livro']?.value;
		nire = plutoRow.cells['nire']?.value;
	}	

	RegistroCartorioModel clone() {
		return RegistroCartorioModel(
			id: id,
			nomeCartorio: nomeCartorio,
			dataRegistro: dataRegistro,
			numero: numero,
			folha: folha,
			livro: livro,
			nire: nire,
		);			
	}

	
}