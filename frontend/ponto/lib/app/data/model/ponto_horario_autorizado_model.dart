import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:ponto/app/data/domain/domain_imports.dart';

class PontoHorarioAutorizadoModel {
	int? id;
	int? idColaborador;
	DateTime? dataHorario;
	String? tipo;
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
	String? horaFechamentoDia;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	PontoHorarioAutorizadoModel({
		this.id,
		this.idColaborador,
		this.dataHorario,
		this.tipo,
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
		this.horaFechamentoDia,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_horario',
		'tipo',
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
		'hora_fechamento_dia',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Horario',
		'Tipo',
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
		'Hora Fechamento Dia',
	];

	PontoHorarioAutorizadoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idColaborador = jsonData['idColaborador'];
		dataHorario = jsonData['dataHorario'] != null ? DateTime.tryParse(jsonData['dataHorario']) : null;
		tipo = PontoHorarioAutorizadoDomain.getTipo(jsonData['tipo']);
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
		horaFechamentoDia = jsonData['horaFechamentoDia'];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['dataHorario'] = dataHorario != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataHorario!) : null;
		jsonData['tipo'] = PontoHorarioAutorizadoDomain.setTipo(tipo);
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
		jsonData['horaFechamentoDia'] = Util.removeMask(horaFechamentoDia);
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
		dataHorario = Util.stringToDate(plutoRow.cells['dataHorario']?.value);
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Fixo';
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
		horaFechamentoDia = plutoRow.cells['horaFechamentoDia']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	PontoHorarioAutorizadoModel clone() {
		return PontoHorarioAutorizadoModel(
			id: id,
			idColaborador: idColaborador,
			dataHorario: dataHorario,
			tipo: tipo,
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
			horaFechamentoDia: horaFechamentoDia,
		);			
	}

	
}