import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class ViewControleAcessoModel {
	int? id;
	int? idPessoa;
	String? pessoaNome;
	int? idColaborador;
	int? idUsuario;
	String? administrador;
	int? idPapel;
	String? papelNome;
	String? papelDescricao;
	int? idFuncao;
	String? funcaoNome;
	String? funcaoDescricao;
	int? idPapelFuncao;
	String? habilitado;
	String? podeInserir;
	String? podeAlterar;
	String? podeExcluir;

	ViewControleAcessoModel({
		this.id,
		this.idPessoa,
		this.pessoaNome,
		this.idColaborador,
		this.idUsuario,
		this.administrador,
		this.idPapel,
		this.papelNome,
		this.papelDescricao,
		this.idFuncao,
		this.funcaoNome,
		this.funcaoDescricao,
		this.idPapelFuncao,
		this.habilitado,
		this.podeInserir,
		this.podeAlterar,
		this.podeExcluir,
	});

	static List<String> dbColumns = <String>[
		'id',
		'id_pessoa',
		'pessoa_nome',
		'id_colaborador',
		'id_usuario',
		'administrador',
		'id_papel',
		'papel_nome',
		'papel_descricao',
		'id_funcao',
		'funcao_nome',
		'funcao_descricao',
		'id_papel_funcao',
		'habilitado',
		'pode_inserir',
		'pode_alterar',
		'pode_excluir',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Id Pessoa',
		'Pessoa Nome',
		'Id Colaborador',
		'Id Usuario',
		'Administrador',
		'Id Papel',
		'Papel Nome',
		'Papel Descricao',
		'Id Funcao',
		'Funcao Nome',
		'Funcao Descricao',
		'Id Papel Funcao',
		'Habilitado',
		'Pode Inserir',
		'Pode Alterar',
		'Pode Excluir',
	];

	ViewControleAcessoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPessoa = jsonData['idPessoa'];
		pessoaNome = jsonData['pessoaNome'];
		idColaborador = jsonData['idColaborador'];
		idUsuario = jsonData['idUsuario'];
		administrador = jsonData['administrador'];
		idPapel = jsonData['idPapel'];
		papelNome = jsonData['papelNome'];
		papelDescricao = jsonData['papelDescricao'];
		idFuncao = jsonData['idFuncao'];
		funcaoNome = jsonData['funcaoNome'];
		funcaoDescricao = jsonData['funcaoDescricao'];
		idPapelFuncao = jsonData['idPapelFuncao'];
		habilitado = jsonData['habilitado'];
		podeInserir = jsonData['podeInserir'];
		podeAlterar = jsonData['podeAlterar'];
		podeExcluir = jsonData['podeExcluir'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPessoa'] = idPessoa;
		jsonData['pessoaNome'] = pessoaNome;
		jsonData['idColaborador'] = idColaborador;
		jsonData['idUsuario'] = idUsuario;
		jsonData['administrador'] = administrador;
		jsonData['idPapel'] = idPapel;
		jsonData['papelNome'] = papelNome;
		jsonData['papelDescricao'] = papelDescricao;
		jsonData['idFuncao'] = idFuncao;
		jsonData['funcaoNome'] = funcaoNome;
		jsonData['funcaoDescricao'] = funcaoDescricao;
		jsonData['idPapelFuncao'] = idPapelFuncao;
		jsonData['habilitado'] = habilitado;
		jsonData['podeInserir'] = podeInserir;
		jsonData['podeAlterar'] = podeAlterar;
		jsonData['podeExcluir'] = podeExcluir;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPessoa = plutoRow.cells['idPessoa']?.value;
		pessoaNome = plutoRow.cells['pessoaNome']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		idUsuario = plutoRow.cells['idUsuario']?.value;
		administrador = plutoRow.cells['administrador']?.value;
		idPapel = plutoRow.cells['idPapel']?.value;
		papelNome = plutoRow.cells['papelNome']?.value;
		papelDescricao = plutoRow.cells['papelDescricao']?.value;
		idFuncao = plutoRow.cells['idFuncao']?.value;
		funcaoNome = plutoRow.cells['funcaoNome']?.value;
		funcaoDescricao = plutoRow.cells['funcaoDescricao']?.value;
		idPapelFuncao = plutoRow.cells['idPapelFuncao']?.value;
		habilitado = plutoRow.cells['habilitado']?.value;
		podeInserir = plutoRow.cells['podeInserir']?.value;
		podeAlterar = plutoRow.cells['podeAlterar']?.value;
		podeExcluir = plutoRow.cells['podeExcluir']?.value;
	}	

	ViewControleAcessoModel clone() {
		return ViewControleAcessoModel(
			id: id,
			idPessoa: idPessoa,
			pessoaNome: pessoaNome,
			idColaborador: idColaborador,
			idUsuario: idUsuario,
			administrador: administrador,
			idPapel: idPapel,
			papelNome: papelNome,
			papelDescricao: papelDescricao,
			idFuncao: idFuncao,
			funcaoNome: funcaoNome,
			funcaoDescricao: funcaoDescricao,
			idPapelFuncao: idPapelFuncao,
			habilitado: habilitado,
			podeInserir: podeInserir,
			podeAlterar: podeAlterar,
			podeExcluir: podeExcluir,
		);			
	}

	
}