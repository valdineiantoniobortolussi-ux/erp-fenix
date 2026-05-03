import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:pcp/app/data/model/model_imports.dart';

class PcpServicoColaboradorModel {
	int? id;
	int? idPcpServico;
	int? idColaborador;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	PcpServicoColaboradorModel({
		this.id,
		this.idPcpServico,
		this.idColaborador,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
	];

	PcpServicoColaboradorModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPcpServico = jsonData['idPcpServico'];
		idColaborador = jsonData['idColaborador'];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPcpServico'] = idPcpServico != 0 ? idPcpServico : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPcpServico = plutoRow.cells['idPcpServico']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	PcpServicoColaboradorModel clone() {
		return PcpServicoColaboradorModel(
			id: id,
			idPcpServico: idPcpServico,
			idColaborador: idColaborador,
		);			
	}

	
}