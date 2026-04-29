import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:vendas/app/data/model/model_imports.dart';

class NotaFiscalTipoModel {
	int? id;
	int? idNotaFiscalModelo;
	String? nome;
	String? descricao;
	String? serie;
	String? serieScan;
	int? ultimoNumero;
	NotaFiscalModeloModel? notaFiscalModeloModel;

	NotaFiscalTipoModel({
		this.id,
		this.idNotaFiscalModelo,
		this.nome,
		this.descricao,
		this.serie,
		this.serieScan,
		this.ultimoNumero,
		this.notaFiscalModeloModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'descricao',
		'serie',
		'serie_scan',
		'ultimo_numero',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Descricao',
		'Serie',
		'Serie Scan',
		'Ultimo Numero',
	];

	NotaFiscalTipoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNotaFiscalModelo = jsonData['idNotaFiscalModelo'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		serie = jsonData['serie'];
		serieScan = jsonData['serieScan'];
		ultimoNumero = jsonData['ultimoNumero'];
		notaFiscalModeloModel = jsonData['notaFiscalModeloModel'] == null ? NotaFiscalModeloModel() : NotaFiscalModeloModel.fromJson(jsonData['notaFiscalModeloModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNotaFiscalModelo'] = idNotaFiscalModelo != 0 ? idNotaFiscalModelo : null;
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
		jsonData['serie'] = serie;
		jsonData['serieScan'] = serieScan;
		jsonData['ultimoNumero'] = ultimoNumero;
		jsonData['notaFiscalModeloModel'] = notaFiscalModeloModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNotaFiscalModelo = plutoRow.cells['idNotaFiscalModelo']?.value;
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		serie = plutoRow.cells['serie']?.value;
		serieScan = plutoRow.cells['serieScan']?.value;
		ultimoNumero = plutoRow.cells['ultimoNumero']?.value;
		notaFiscalModeloModel = NotaFiscalModeloModel();
		notaFiscalModeloModel?.modelo = plutoRow.cells['notaFiscalModeloModel']?.value;
	}	

	NotaFiscalTipoModel clone() {
		return NotaFiscalTipoModel(
			id: id,
			idNotaFiscalModelo: idNotaFiscalModelo,
			nome: nome,
			descricao: descricao,
			serie: serie,
			serieScan: serieScan,
			ultimoNumero: ultimoNumero,
		);			
	}

	
}