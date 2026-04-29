import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class FolhaPppFatorRiscoModel {
	int? id;
	int? idFolhaPpp;
	DateTime? dataInicio;
	DateTime? dataFim;
	String? tipo;
	String? fatorRisco;
	String? intensidade;
	String? tecnicaUtilizada;
	String? epcEficaz;
	String? epiEficaz;
	int? caEpi;
	String? atendimentoNr061;
	String? atendimentoNr062;
	String? atendimentoNr063;
	String? atendimentoNr064;
	String? atendimentoNr065;

	FolhaPppFatorRiscoModel({
		this.id,
		this.idFolhaPpp,
		this.dataInicio,
		this.dataFim,
		this.tipo,
		this.fatorRisco,
		this.intensidade,
		this.tecnicaUtilizada,
		this.epcEficaz,
		this.epiEficaz,
		this.caEpi,
		this.atendimentoNr061,
		this.atendimentoNr062,
		this.atendimentoNr063,
		this.atendimentoNr064,
		this.atendimentoNr065,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_inicio',
		'data_fim',
		'tipo',
		'fator_risco',
		'intensidade',
		'tecnica_utilizada',
		'epc_eficaz',
		'epi_eficaz',
		'ca_epi',
		'atendimento_nr06_1',
		'atendimento_nr06_2',
		'atendimento_nr06_3',
		'atendimento_nr06_4',
		'atendimento_nr06_5',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Inicio',
		'Data Fim',
		'Tipo',
		'Fator Risco',
		'Intensidade',
		'Tecnica Utilizada',
		'Epc Eficaz',
		'Epi Eficaz',
		'Ca Epi',
		'Atendimento Nr06 1',
		'Atendimento Nr06 2',
		'Atendimento Nr06 3',
		'Atendimento Nr06 4',
		'Atendimento Nr06 5',
	];

	FolhaPppFatorRiscoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFolhaPpp = jsonData['idFolhaPpp'];
		dataInicio = jsonData['dataInicio'] != null ? DateTime.tryParse(jsonData['dataInicio']) : null;
		dataFim = jsonData['dataFim'] != null ? DateTime.tryParse(jsonData['dataFim']) : null;
		tipo = FolhaPppFatorRiscoDomain.getTipo(jsonData['tipo']);
		fatorRisco = jsonData['fatorRisco'];
		intensidade = jsonData['intensidade'];
		tecnicaUtilizada = jsonData['tecnicaUtilizada'];
		epcEficaz = FolhaPppFatorRiscoDomain.getEpcEficaz(jsonData['epcEficaz']);
		epiEficaz = FolhaPppFatorRiscoDomain.getEpiEficaz(jsonData['epiEficaz']);
		caEpi = jsonData['caEpi'];
		atendimentoNr061 = FolhaPppFatorRiscoDomain.getAtendimentoNr061(jsonData['atendimentoNr061']);
		atendimentoNr062 = FolhaPppFatorRiscoDomain.getAtendimentoNr062(jsonData['atendimentoNr062']);
		atendimentoNr063 = FolhaPppFatorRiscoDomain.getAtendimentoNr063(jsonData['atendimentoNr063']);
		atendimentoNr064 = FolhaPppFatorRiscoDomain.getAtendimentoNr064(jsonData['atendimentoNr064']);
		atendimentoNr065 = FolhaPppFatorRiscoDomain.getAtendimentoNr065(jsonData['atendimentoNr065']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFolhaPpp'] = idFolhaPpp != 0 ? idFolhaPpp : null;
		jsonData['dataInicio'] = dataInicio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicio!) : null;
		jsonData['dataFim'] = dataFim != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFim!) : null;
		jsonData['tipo'] = FolhaPppFatorRiscoDomain.setTipo(tipo);
		jsonData['fatorRisco'] = fatorRisco;
		jsonData['intensidade'] = intensidade;
		jsonData['tecnicaUtilizada'] = tecnicaUtilizada;
		jsonData['epcEficaz'] = FolhaPppFatorRiscoDomain.setEpcEficaz(epcEficaz);
		jsonData['epiEficaz'] = FolhaPppFatorRiscoDomain.setEpiEficaz(epiEficaz);
		jsonData['caEpi'] = caEpi;
		jsonData['atendimentoNr061'] = FolhaPppFatorRiscoDomain.setAtendimentoNr061(atendimentoNr061);
		jsonData['atendimentoNr062'] = FolhaPppFatorRiscoDomain.setAtendimentoNr062(atendimentoNr062);
		jsonData['atendimentoNr063'] = FolhaPppFatorRiscoDomain.setAtendimentoNr063(atendimentoNr063);
		jsonData['atendimentoNr064'] = FolhaPppFatorRiscoDomain.setAtendimentoNr064(atendimentoNr064);
		jsonData['atendimentoNr065'] = FolhaPppFatorRiscoDomain.setAtendimentoNr065(atendimentoNr065);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idFolhaPpp = plutoRow.cells['idFolhaPpp']?.value;
		dataInicio = Util.stringToDate(plutoRow.cells['dataInicio']?.value);
		dataFim = Util.stringToDate(plutoRow.cells['dataFim']?.value);
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'F=Físico';
		fatorRisco = plutoRow.cells['fatorRisco']?.value;
		intensidade = plutoRow.cells['intensidade']?.value;
		tecnicaUtilizada = plutoRow.cells['tecnicaUtilizada']?.value;
		epcEficaz = plutoRow.cells['epcEficaz']?.value != '' ? plutoRow.cells['epcEficaz']?.value : 'Sim';
		epiEficaz = plutoRow.cells['epiEficaz']?.value != '' ? plutoRow.cells['epiEficaz']?.value : 'Sim';
		caEpi = plutoRow.cells['caEpi']?.value;
		atendimentoNr061 = plutoRow.cells['atendimentoNr061']?.value != '' ? plutoRow.cells['atendimentoNr061']?.value : 'Sim';
		atendimentoNr062 = plutoRow.cells['atendimentoNr062']?.value != '' ? plutoRow.cells['atendimentoNr062']?.value : 'Sim';
		atendimentoNr063 = plutoRow.cells['atendimentoNr063']?.value != '' ? plutoRow.cells['atendimentoNr063']?.value : 'Sim';
		atendimentoNr064 = plutoRow.cells['atendimentoNr064']?.value != '' ? plutoRow.cells['atendimentoNr064']?.value : 'Sim';
		atendimentoNr065 = plutoRow.cells['atendimentoNr065']?.value != '' ? plutoRow.cells['atendimentoNr065']?.value : 'Sim';
	}	

	FolhaPppFatorRiscoModel clone() {
		return FolhaPppFatorRiscoModel(
			id: id,
			idFolhaPpp: idFolhaPpp,
			dataInicio: dataInicio,
			dataFim: dataFim,
			tipo: tipo,
			fatorRisco: fatorRisco,
			intensidade: intensidade,
			tecnicaUtilizada: tecnicaUtilizada,
			epcEficaz: epcEficaz,
			epiEficaz: epiEficaz,
			caEpi: caEpi,
			atendimentoNr061: atendimentoNr061,
			atendimentoNr062: atendimentoNr062,
			atendimentoNr063: atendimentoNr063,
			atendimentoNr064: atendimentoNr064,
			atendimentoNr065: atendimentoNr065,
		);			
	}

	
}