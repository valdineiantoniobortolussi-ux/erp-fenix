import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:frotas/app/data/model/model_imports.dart';
import 'package:frotas/app/data/domain/domain_imports.dart';

class FrotaMotoristaModel {
	int? id;
	int? idColaborador;
	String? nome;
	String? numeroCnh;
	String? cnhCategoria;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	FrotaMotoristaModel({
		this.id,
		this.idColaborador,
		this.nome,
		this.numeroCnh,
		this.cnhCategoria,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'numero_cnh',
		'cnh_categoria',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Numero Cnh',
		'Cnh Categoria',
	];

	FrotaMotoristaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idColaborador = jsonData['idColaborador'];
		nome = jsonData['nome'];
		numeroCnh = jsonData['numeroCnh'];
		cnhCategoria = FrotaMotoristaDomain.getCnhCategoria(jsonData['cnhCategoria']);
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['nome'] = nome;
		jsonData['numeroCnh'] = numeroCnh;
		jsonData['cnhCategoria'] = FrotaMotoristaDomain.setCnhCategoria(cnhCategoria);
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		nome = plutoRow.cells['nome']?.value;
		numeroCnh = plutoRow.cells['numeroCnh']?.value;
		cnhCategoria = plutoRow.cells['cnhCategoria']?.value != '' ? plutoRow.cells['cnhCategoria']?.value : 'A';
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	FrotaMotoristaModel clone() {
		return FrotaMotoristaModel(
			id: id,
			idColaborador: idColaborador,
			nome: nome,
			numeroCnh: numeroCnh,
			cnhCategoria: cnhCategoria,
		);			
	}

	
}