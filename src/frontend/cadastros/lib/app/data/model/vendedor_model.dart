import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/data/model/model_imports.dart';

class VendedorModel {
	int? id;
	int? idColaborador;
	int? idComissaoPerfil;
	double? comissao;
	double? metaVenda;
	ComissaoPerfilModel? comissaoPerfilModel;

	VendedorModel({
		this.id,
		this.idColaborador,
		this.idComissaoPerfil,
		this.comissao,
		this.metaVenda,
		this.comissaoPerfilModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'comissao',
		'meta_venda',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Comissao',
		'Meta Venda',
	];

	VendedorModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idColaborador = jsonData['idColaborador'];
		idComissaoPerfil = jsonData['idComissaoPerfil'];
		comissao = jsonData['comissao']?.toDouble();
		metaVenda = jsonData['metaVenda']?.toDouble();
		comissaoPerfilModel = jsonData['comissaoPerfilModel'] == null ? ComissaoPerfilModel() : ComissaoPerfilModel.fromJson(jsonData['comissaoPerfilModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['idComissaoPerfil'] = idComissaoPerfil != 0 ? idComissaoPerfil : null;
		jsonData['comissao'] = comissao;
		jsonData['metaVenda'] = metaVenda;
		jsonData['comissaoPerfilModel'] = comissaoPerfilModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		idComissaoPerfil = plutoRow.cells['idComissaoPerfil']?.value;
		comissao = plutoRow.cells['comissao']?.value?.toDouble();
		metaVenda = plutoRow.cells['metaVenda']?.value?.toDouble();
		comissaoPerfilModel = ComissaoPerfilModel();
		comissaoPerfilModel?.nome = plutoRow.cells['comissaoPerfilModel']?.value;
	}	

	VendedorModel clone() {
		return VendedorModel(
			id: id,
			idColaborador: idColaborador,
			idComissaoPerfil: idComissaoPerfil,
			comissao: comissao,
			metaVenda: metaVenda,
		);			
	}

	
}