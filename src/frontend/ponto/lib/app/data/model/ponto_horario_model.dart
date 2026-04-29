import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/domain/domain_imports.dart';

class PontoHorarioModel {
	int? id;
	String? tipo;
	String? codigo;
	String? nome;
	String? tipoTrabalho;
	String? cargaHoraria;
	String? entrada01;
	String? saida01;
	String? entrada02;
	String? saida02;
	String? entrada03;
	String? saida03;
	String? entrada04;
	String? saida04;
	String? entrada05;
	String? saida05;
	String? horaInicioJornada;
	String? horaFimJornada;

	PontoHorarioModel({
		this.id,
		this.tipo,
		this.codigo,
		this.nome,
		this.tipoTrabalho,
		this.cargaHoraria,
		this.entrada01,
		this.saida01,
		this.entrada02,
		this.saida02,
		this.entrada03,
		this.saida03,
		this.entrada04,
		this.saida04,
		this.entrada05,
		this.saida05,
		this.horaInicioJornada,
		this.horaFimJornada,
	});

	static List<String> dbColumns = <String>[
		'id',
		'tipo',
		'codigo',
		'nome',
		'tipo_trabalho',
		'carga_horaria',
		'entrada01',
		'saida01',
		'entrada02',
		'saida02',
		'entrada03',
		'saida03',
		'entrada04',
		'saida04',
		'entrada05',
		'saida05',
		'hora_inicio_jornada',
		'hora_fim_jornada',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Tipo',
		'Codigo',
		'Nome',
		'Tipo Trabalho',
		'Carga Horaria',
		'Entrada01',
		'Saida01',
		'Entrada02',
		'Saida02',
		'Entrada03',
		'Saida03',
		'Entrada04',
		'Saida04',
		'Entrada05',
		'Saida05',
		'Hora Inicio Jornada',
		'Hora Fim Jornada',
	];

	PontoHorarioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		tipo = PontoHorarioDomain.getTipo(jsonData['tipo']);
		codigo = jsonData['codigo'];
		nome = jsonData['nome'];
		tipoTrabalho = PontoHorarioDomain.getTipoTrabalho(jsonData['tipoTrabalho']);
		cargaHoraria = jsonData['cargaHoraria'];
		entrada01 = jsonData['entrada01'];
		saida01 = jsonData['saida01'];
		entrada02 = jsonData['entrada02'];
		saida02 = jsonData['saida02'];
		entrada03 = jsonData['entrada03'];
		saida03 = jsonData['saida03'];
		entrada04 = jsonData['entrada04'];
		saida04 = jsonData['saida04'];
		entrada05 = jsonData['entrada05'];
		saida05 = jsonData['saida05'];
		horaInicioJornada = jsonData['horaInicioJornada'];
		horaFimJornada = jsonData['horaFimJornada'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['tipo'] = PontoHorarioDomain.setTipo(tipo);
		jsonData['codigo'] = codigo;
		jsonData['nome'] = nome;
		jsonData['tipoTrabalho'] = PontoHorarioDomain.setTipoTrabalho(tipoTrabalho);
		jsonData['cargaHoraria'] = Util.removeMask(cargaHoraria);
		jsonData['entrada01'] = Util.removeMask(entrada01);
		jsonData['saida01'] = Util.removeMask(saida01);
		jsonData['entrada02'] = Util.removeMask(entrada02);
		jsonData['saida02'] = Util.removeMask(saida02);
		jsonData['entrada03'] = Util.removeMask(entrada03);
		jsonData['saida03'] = Util.removeMask(saida03);
		jsonData['entrada04'] = Util.removeMask(entrada04);
		jsonData['saida04'] = Util.removeMask(saida04);
		jsonData['entrada05'] = Util.removeMask(entrada05);
		jsonData['saida05'] = Util.removeMask(saida05);
		jsonData['horaInicioJornada'] = Util.removeMask(horaInicioJornada);
		jsonData['horaFimJornada'] = Util.removeMask(horaFimJornada);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Fixo';
		codigo = plutoRow.cells['codigo']?.value;
		nome = plutoRow.cells['nome']?.value;
		tipoTrabalho = plutoRow.cells['tipoTrabalho']?.value != '' ? plutoRow.cells['tipoTrabalho']?.value : 'Normal';
		cargaHoraria = plutoRow.cells['cargaHoraria']?.value;
		entrada01 = plutoRow.cells['entrada01']?.value;
		saida01 = plutoRow.cells['saida01']?.value;
		entrada02 = plutoRow.cells['entrada02']?.value;
		saida02 = plutoRow.cells['saida02']?.value;
		entrada03 = plutoRow.cells['entrada03']?.value;
		saida03 = plutoRow.cells['saida03']?.value;
		entrada04 = plutoRow.cells['entrada04']?.value;
		saida04 = plutoRow.cells['saida04']?.value;
		entrada05 = plutoRow.cells['entrada05']?.value;
		saida05 = plutoRow.cells['saida05']?.value;
		horaInicioJornada = plutoRow.cells['horaInicioJornada']?.value;
		horaFimJornada = plutoRow.cells['horaFimJornada']?.value;
	}	

	PontoHorarioModel clone() {
		return PontoHorarioModel(
			id: id,
			tipo: tipo,
			codigo: codigo,
			nome: nome,
			tipoTrabalho: tipoTrabalho,
			cargaHoraria: cargaHoraria,
			entrada01: entrada01,
			saida01: saida01,
			entrada02: entrada02,
			saida02: saida02,
			entrada03: entrada03,
			saida03: saida03,
			entrada04: entrada04,
			saida04: saida04,
			entrada05: entrada05,
			saida05: saida05,
			horaInicioJornada: horaInicioJornada,
			horaFimJornada: horaFimJornada,
		);			
	}

	
}