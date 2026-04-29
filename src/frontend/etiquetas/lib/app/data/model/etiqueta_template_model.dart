import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:etiquetas/app/data/domain/domain_imports.dart';

class EtiquetaTemplateModel {
	int? id;
	int? idEtiquetaLayout;
	String? tabela;
	String? campo;
	String? formato;
	int? quantidadeRepeticoes;
	String? filtro;

	EtiquetaTemplateModel({
		this.id,
		this.idEtiquetaLayout,
		this.tabela,
		this.campo,
		this.formato,
		this.quantidadeRepeticoes,
		this.filtro,
	});

	static List<String> dbColumns = <String>[
		'id',
		'tabela',
		'campo',
		'formato',
		'quantidade_repeticoes',
		'filtro',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Tabela',
		'Campo',
		'Formato',
		'Quantidade Repeticoes',
		'Filtro',
	];

	EtiquetaTemplateModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idEtiquetaLayout = jsonData['idEtiquetaLayout'];
		tabela = jsonData['tabela'];
		campo = jsonData['campo'];
		formato = EtiquetaTemplateDomain.getFormato(jsonData['formato']);
		quantidadeRepeticoes = jsonData['quantidadeRepeticoes'];
		filtro = jsonData['filtro'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idEtiquetaLayout'] = idEtiquetaLayout != 0 ? idEtiquetaLayout : null;
		jsonData['tabela'] = tabela;
		jsonData['campo'] = campo;
		jsonData['formato'] = EtiquetaTemplateDomain.setFormato(formato);
		jsonData['quantidadeRepeticoes'] = quantidadeRepeticoes;
		jsonData['filtro'] = filtro;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idEtiquetaLayout = plutoRow.cells['idEtiquetaLayout']?.value;
		tabela = plutoRow.cells['tabela']?.value;
		campo = plutoRow.cells['campo']?.value;
		formato = plutoRow.cells['formato']?.value != '' ? plutoRow.cells['formato']?.value : '0=EAN';
		quantidadeRepeticoes = plutoRow.cells['quantidadeRepeticoes']?.value;
		filtro = plutoRow.cells['filtro']?.value;
	}	

	EtiquetaTemplateModel clone() {
		return EtiquetaTemplateModel(
			id: id,
			idEtiquetaLayout: idEtiquetaLayout,
			tabela: tabela,
			campo: campo,
			formato: formato,
			quantidadeRepeticoes: quantidadeRepeticoes,
			filtro: filtro,
		);			
	}

	
}