import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/data/domain/domain_imports.dart';

class FolhaEventoModel {
	int? id;
	String? codigo;
	String? nome;
	String? descricao;
	String? baseCalculo;
	String? tipo;
	String? unidade;
	double? taxa;
	String? rubricaEsocial;
	String? codIncidenciaPrevidencia;
	String? codIncidenciaIrrf;
	String? codIncidenciaFgts;
	String? codIncidenciaSindicato;
	String? repercuteDsr;
	String? repercute13;
	String? repercuteFerias;
	String? repercuteAviso;

	FolhaEventoModel({
		this.id,
		this.codigo,
		this.nome,
		this.descricao,
		this.baseCalculo,
		this.tipo,
		this.unidade,
		this.taxa,
		this.rubricaEsocial,
		this.codIncidenciaPrevidencia,
		this.codIncidenciaIrrf,
		this.codIncidenciaFgts,
		this.codIncidenciaSindicato,
		this.repercuteDsr,
		this.repercute13,
		this.repercuteFerias,
		this.repercuteAviso,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'nome',
		'descricao',
		'base_calculo',
		'tipo',
		'unidade',
		'taxa',
		'rubrica_esocial',
		'cod_incidencia_previdencia',
		'cod_incidencia_irrf',
		'cod_incidencia_fgts',
		'cod_incidencia_sindicato',
		'repercute_dsr',
		'repercute_13',
		'repercute_ferias',
		'repercute_aviso',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Nome',
		'Descricao',
		'Base Calculo',
		'Tipo',
		'Unidade',
		'Taxa',
		'Rubrica Esocial',
		'Cod Incidencia Previdencia',
		'Cod Incidencia Irrf',
		'Cod Incidencia Fgts',
		'Cod Incidencia Sindicato',
		'Repercute Dsr',
		'Repercute 13',
		'Repercute Ferias',
		'Repercute Aviso',
	];

	FolhaEventoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = jsonData['codigo'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		baseCalculo = FolhaEventoDomain.getBaseCalculo(jsonData['baseCalculo']);
		tipo = FolhaEventoDomain.getTipo(jsonData['tipo']);
		unidade = FolhaEventoDomain.getUnidade(jsonData['unidade']);
		taxa = jsonData['taxa']?.toDouble();
		rubricaEsocial = jsonData['rubricaEsocial'];
		codIncidenciaPrevidencia = jsonData['codIncidenciaPrevidencia'];
		codIncidenciaIrrf = jsonData['codIncidenciaIrrf'];
		codIncidenciaFgts = jsonData['codIncidenciaFgts'];
		codIncidenciaSindicato = jsonData['codIncidenciaSindicato'];
		repercuteDsr = FolhaEventoDomain.getRepercuteDsr(jsonData['repercuteDsr']);
		repercute13 = FolhaEventoDomain.getRepercute13(jsonData['repercute13']);
		repercuteFerias = FolhaEventoDomain.getRepercuteFerias(jsonData['repercuteFerias']);
		repercuteAviso = FolhaEventoDomain.getRepercuteAviso(jsonData['repercuteAviso']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = codigo;
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
		jsonData['baseCalculo'] = FolhaEventoDomain.setBaseCalculo(baseCalculo);
		jsonData['tipo'] = FolhaEventoDomain.setTipo(tipo);
		jsonData['unidade'] = FolhaEventoDomain.setUnidade(unidade);
		jsonData['taxa'] = taxa;
		jsonData['rubricaEsocial'] = rubricaEsocial;
		jsonData['codIncidenciaPrevidencia'] = codIncidenciaPrevidencia;
		jsonData['codIncidenciaIrrf'] = codIncidenciaIrrf;
		jsonData['codIncidenciaFgts'] = codIncidenciaFgts;
		jsonData['codIncidenciaSindicato'] = codIncidenciaSindicato;
		jsonData['repercuteDsr'] = FolhaEventoDomain.setRepercuteDsr(repercuteDsr);
		jsonData['repercute13'] = FolhaEventoDomain.setRepercute13(repercute13);
		jsonData['repercuteFerias'] = FolhaEventoDomain.setRepercuteFerias(repercuteFerias);
		jsonData['repercuteAviso'] = FolhaEventoDomain.setRepercuteAviso(repercuteAviso);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		baseCalculo = plutoRow.cells['baseCalculo']?.value != '' ? plutoRow.cells['baseCalculo']?.value : '1=Salário contratual: define que a base de cálculo deve ser calculada sobre o valor do salário contratual';
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Provento';
		unidade = plutoRow.cells['unidade']?.value != '' ? plutoRow.cells['unidade']?.value : 'Valor';
		taxa = plutoRow.cells['taxa']?.value?.toDouble();
		rubricaEsocial = plutoRow.cells['rubricaEsocial']?.value;
		codIncidenciaPrevidencia = plutoRow.cells['codIncidenciaPrevidencia']?.value;
		codIncidenciaIrrf = plutoRow.cells['codIncidenciaIrrf']?.value;
		codIncidenciaFgts = plutoRow.cells['codIncidenciaFgts']?.value;
		codIncidenciaSindicato = plutoRow.cells['codIncidenciaSindicato']?.value;
		repercuteDsr = plutoRow.cells['repercuteDsr']?.value != '' ? plutoRow.cells['repercuteDsr']?.value : 'Sim';
		repercute13 = plutoRow.cells['repercute13']?.value != '' ? plutoRow.cells['repercute13']?.value : 'Sim';
		repercuteFerias = plutoRow.cells['repercuteFerias']?.value != '' ? plutoRow.cells['repercuteFerias']?.value : 'Sim';
		repercuteAviso = plutoRow.cells['repercuteAviso']?.value != '' ? plutoRow.cells['repercuteAviso']?.value : 'Sim';
	}	

	FolhaEventoModel clone() {
		return FolhaEventoModel(
			id: id,
			codigo: codigo,
			nome: nome,
			descricao: descricao,
			baseCalculo: baseCalculo,
			tipo: tipo,
			unidade: unidade,
			taxa: taxa,
			rubricaEsocial: rubricaEsocial,
			codIncidenciaPrevidencia: codIncidenciaPrevidencia,
			codIncidenciaIrrf: codIncidenciaIrrf,
			codIncidenciaFgts: codIncidenciaFgts,
			codIncidenciaSindicato: codIncidenciaSindicato,
			repercuteDsr: repercuteDsr,
			repercute13: repercute13,
			repercuteFerias: repercuteFerias,
			repercuteAviso: repercuteAviso,
		);			
	}

	
}