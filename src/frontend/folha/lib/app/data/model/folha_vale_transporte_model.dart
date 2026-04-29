import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/data/model/model_imports.dart';

class FolhaValeTransporteModel {
	int? id;
	int? idColaborador;
	int? idEmpresaTranspItin;
	int? quantidade;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;
	EmpresaTransporteItinerarioModel? empresaTransporteItinerarioModel;

	FolhaValeTransporteModel({
		this.id,
		this.idColaborador,
		this.idEmpresaTranspItin,
		this.quantidade,
		this.viewPessoaColaboradorModel,
		this.empresaTransporteItinerarioModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'quantidade',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Quantidade',
	];

	FolhaValeTransporteModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idColaborador = jsonData['idColaborador'];
		idEmpresaTranspItin = jsonData['idEmpresaTranspItin'];
		quantidade = jsonData['quantidade'];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
		empresaTransporteItinerarioModel = jsonData['empresaTransporteItinerarioModel'] == null ? EmpresaTransporteItinerarioModel() : EmpresaTransporteItinerarioModel.fromJson(jsonData['empresaTransporteItinerarioModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['idEmpresaTranspItin'] = idEmpresaTranspItin != 0 ? idEmpresaTranspItin : null;
		jsonData['quantidade'] = quantidade;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
		jsonData['empresaTransporteItinerarioModel'] = empresaTransporteItinerarioModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		idEmpresaTranspItin = plutoRow.cells['idEmpresaTranspItin']?.value;
		quantidade = plutoRow.cells['quantidade']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
		empresaTransporteItinerarioModel = EmpresaTransporteItinerarioModel();
		empresaTransporteItinerarioModel?.nome = plutoRow.cells['empresaTransporteItinerarioModel']?.value;
	}	

	FolhaValeTransporteModel clone() {
		return FolhaValeTransporteModel(
			id: id,
			idColaborador: idColaborador,
			idEmpresaTranspItin: idEmpresaTranspItin,
			quantidade: quantidade,
		);			
	}

	
}