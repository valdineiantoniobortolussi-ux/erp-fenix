import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class AidfAimdfModel {
	int? id;
	int? numero;
	DateTime? dataValidade;
	DateTime? dataAutorizacao;
	String? numeroAutorizacao;
	String? formularioDisponivel;

	AidfAimdfModel({
		this.id,
		this.numero,
		this.dataValidade,
		this.dataAutorizacao,
		this.numeroAutorizacao,
		this.formularioDisponivel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero',
		'data_validade',
		'data_autorizacao',
		'numero_autorizacao',
		'formulario_disponivel',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero',
		'Data Validade',
		'Data Autorizacao',
		'Numero Autorizacao',
		'Formulario Disponivel',
	];

	AidfAimdfModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		numero = jsonData['numero'];
		dataValidade = jsonData['dataValidade'] != null ? DateTime.tryParse(jsonData['dataValidade']) : null;
		dataAutorizacao = jsonData['dataAutorizacao'] != null ? DateTime.tryParse(jsonData['dataAutorizacao']) : null;
		numeroAutorizacao = jsonData['numeroAutorizacao'];
		formularioDisponivel = AidfAimdfDomain.getFormularioDisponivel(jsonData['formularioDisponivel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['numero'] = numero;
		jsonData['dataValidade'] = dataValidade != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataValidade!) : null;
		jsonData['dataAutorizacao'] = dataAutorizacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataAutorizacao!) : null;
		jsonData['numeroAutorizacao'] = numeroAutorizacao;
		jsonData['formularioDisponivel'] = AidfAimdfDomain.setFormularioDisponivel(formularioDisponivel);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		numero = plutoRow.cells['numero']?.value;
		dataValidade = Util.stringToDate(plutoRow.cells['dataValidade']?.value);
		dataAutorizacao = Util.stringToDate(plutoRow.cells['dataAutorizacao']?.value);
		numeroAutorizacao = plutoRow.cells['numeroAutorizacao']?.value;
		formularioDisponivel = plutoRow.cells['formularioDisponivel']?.value != '' ? plutoRow.cells['formularioDisponivel']?.value : 'Sim';
	}	

	AidfAimdfModel clone() {
		return AidfAimdfModel(
			id: id,
			numero: numero,
			dataValidade: dataValidade,
			dataAutorizacao: dataAutorizacao,
			numeroAutorizacao: numeroAutorizacao,
			formularioDisponivel: formularioDisponivel,
		);			
	}

	
}