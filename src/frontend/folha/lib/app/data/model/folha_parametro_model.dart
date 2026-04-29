import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class FolhaParametroModel {
	int? id;
	String? competencia;
	String? contribuiPis;
	double? aliquotaPis;
	String? discriminarDsr;
	String? diaPagamento;
	String? calculoProporcionalidade;
	String? descontarFaltas13;
	String? pagarAdicionais13;
	String? pagarEstagiarios13;
	String? mesAdiantamento13;
	double? percentualAdiantam13;
	String? feriasDescontarFaltas;
	String? feriasPagarAdicionais;
	String? feriasAdiantar13;
	String? feriasPagarEstagiarios;
	String? feriasCalcJustaCausa;
	String? feriasMovimentoMensal;

	FolhaParametroModel({
		this.id,
		this.competencia,
		this.contribuiPis,
		this.aliquotaPis,
		this.discriminarDsr,
		this.diaPagamento,
		this.calculoProporcionalidade,
		this.descontarFaltas13,
		this.pagarAdicionais13,
		this.pagarEstagiarios13,
		this.mesAdiantamento13,
		this.percentualAdiantam13,
		this.feriasDescontarFaltas,
		this.feriasPagarAdicionais,
		this.feriasAdiantar13,
		this.feriasPagarEstagiarios,
		this.feriasCalcJustaCausa,
		this.feriasMovimentoMensal,
	});

	static List<String> dbColumns = <String>[
		'id',
		'competencia',
		'contribui_pis',
		'aliquota_pis',
		'discriminar_dsr',
		'dia_pagamento',
		'calculo_proporcionalidade',
		'descontar_faltas_13',
		'pagar_adicionais_13',
		'pagar_estagiarios_13',
		'mes_adiantamento_13',
		'percentual_adiantam_13',
		'ferias_descontar_faltas',
		'ferias_pagar_adicionais',
		'ferias_adiantar_13',
		'ferias_pagar_estagiarios',
		'ferias_calc_justa_causa',
		'ferias_movimento_mensal',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Competencia',
		'Contribui Pis',
		'Aliquota Pis',
		'Discriminar Dsr',
		'Dia Pagamento',
		'Calculo Proporcionalidade',
		'Descontar Faltas 13',
		'Pagar Adicionais 13',
		'Pagar Estagiarios 13',
		'Mes Adiantamento 13',
		'Percentual Adiantam 13',
		'Ferias Descontar Faltas',
		'Ferias Pagar Adicionais',
		'Ferias Adiantar 13',
		'Ferias Pagar Estagiarios',
		'Ferias Calc Justa Causa',
		'Ferias Movimento Mensal',
	];

	FolhaParametroModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		competencia = jsonData['competencia'];
		contribuiPis = FolhaParametroDomain.getContribuiPis(jsonData['contribuiPis']);
		aliquotaPis = jsonData['aliquotaPis']?.toDouble();
		discriminarDsr = FolhaParametroDomain.getDiscriminarDsr(jsonData['discriminarDsr']);
		diaPagamento = jsonData['diaPagamento'];
		calculoProporcionalidade = FolhaParametroDomain.getCalculoProporcionalidade(jsonData['calculoProporcionalidade']);
		descontarFaltas13 = FolhaParametroDomain.getDescontarFaltas13(jsonData['descontarFaltas13']);
		pagarAdicionais13 = FolhaParametroDomain.getPagarAdicionais13(jsonData['pagarAdicionais13']);
		pagarEstagiarios13 = FolhaParametroDomain.getPagarEstagiarios13(jsonData['pagarEstagiarios13']);
		mesAdiantamento13 = jsonData['mesAdiantamento13'];
		percentualAdiantam13 = jsonData['percentualAdiantam13']?.toDouble();
		feriasDescontarFaltas = FolhaParametroDomain.getFeriasDescontarFaltas(jsonData['feriasDescontarFaltas']);
		feriasPagarAdicionais = FolhaParametroDomain.getFeriasPagarAdicionais(jsonData['feriasPagarAdicionais']);
		feriasAdiantar13 = FolhaParametroDomain.getFeriasAdiantar13(jsonData['feriasAdiantar13']);
		feriasPagarEstagiarios = FolhaParametroDomain.getFeriasPagarEstagiarios(jsonData['feriasPagarEstagiarios']);
		feriasCalcJustaCausa = FolhaParametroDomain.getFeriasCalcJustaCausa(jsonData['feriasCalcJustaCausa']);
		feriasMovimentoMensal = FolhaParametroDomain.getFeriasMovimentoMensal(jsonData['feriasMovimentoMensal']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['competencia'] = Util.removeMask(competencia);
		jsonData['contribuiPis'] = FolhaParametroDomain.setContribuiPis(contribuiPis);
		jsonData['aliquotaPis'] = aliquotaPis;
		jsonData['discriminarDsr'] = FolhaParametroDomain.setDiscriminarDsr(discriminarDsr);
		jsonData['diaPagamento'] = diaPagamento;
		jsonData['calculoProporcionalidade'] = FolhaParametroDomain.setCalculoProporcionalidade(calculoProporcionalidade);
		jsonData['descontarFaltas13'] = FolhaParametroDomain.setDescontarFaltas13(descontarFaltas13);
		jsonData['pagarAdicionais13'] = FolhaParametroDomain.setPagarAdicionais13(pagarAdicionais13);
		jsonData['pagarEstagiarios13'] = FolhaParametroDomain.setPagarEstagiarios13(pagarEstagiarios13);
		jsonData['mesAdiantamento13'] = mesAdiantamento13;
		jsonData['percentualAdiantam13'] = percentualAdiantam13;
		jsonData['feriasDescontarFaltas'] = FolhaParametroDomain.setFeriasDescontarFaltas(feriasDescontarFaltas);
		jsonData['feriasPagarAdicionais'] = FolhaParametroDomain.setFeriasPagarAdicionais(feriasPagarAdicionais);
		jsonData['feriasAdiantar13'] = FolhaParametroDomain.setFeriasAdiantar13(feriasAdiantar13);
		jsonData['feriasPagarEstagiarios'] = FolhaParametroDomain.setFeriasPagarEstagiarios(feriasPagarEstagiarios);
		jsonData['feriasCalcJustaCausa'] = FolhaParametroDomain.setFeriasCalcJustaCausa(feriasCalcJustaCausa);
		jsonData['feriasMovimentoMensal'] = FolhaParametroDomain.setFeriasMovimentoMensal(feriasMovimentoMensal);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		competencia = plutoRow.cells['competencia']?.value;
		contribuiPis = plutoRow.cells['contribuiPis']?.value != '' ? plutoRow.cells['contribuiPis']?.value : 'Sim';
		aliquotaPis = plutoRow.cells['aliquotaPis']?.value?.toDouble();
		discriminarDsr = plutoRow.cells['discriminarDsr']?.value != '' ? plutoRow.cells['discriminarDsr']?.value : 'Sim';
		diaPagamento = plutoRow.cells['diaPagamento']?.value;
		calculoProporcionalidade = plutoRow.cells['calculoProporcionalidade']?.value != '' ? plutoRow.cells['calculoProporcionalidade']?.value : '30 Dias';
		descontarFaltas13 = plutoRow.cells['descontarFaltas13']?.value != '' ? plutoRow.cells['descontarFaltas13']?.value : 'Sim';
		pagarAdicionais13 = plutoRow.cells['pagarAdicionais13']?.value != '' ? plutoRow.cells['pagarAdicionais13']?.value : 'Sim';
		pagarEstagiarios13 = plutoRow.cells['pagarEstagiarios13']?.value != '' ? plutoRow.cells['pagarEstagiarios13']?.value : 'Sim';
		mesAdiantamento13 = plutoRow.cells['mesAdiantamento13']?.value;
		percentualAdiantam13 = plutoRow.cells['percentualAdiantam13']?.value?.toDouble();
		feriasDescontarFaltas = plutoRow.cells['feriasDescontarFaltas']?.value != '' ? plutoRow.cells['feriasDescontarFaltas']?.value : 'Sim';
		feriasPagarAdicionais = plutoRow.cells['feriasPagarAdicionais']?.value != '' ? plutoRow.cells['feriasPagarAdicionais']?.value : 'Sim';
		feriasAdiantar13 = plutoRow.cells['feriasAdiantar13']?.value != '' ? plutoRow.cells['feriasAdiantar13']?.value : 'Sim';
		feriasPagarEstagiarios = plutoRow.cells['feriasPagarEstagiarios']?.value != '' ? plutoRow.cells['feriasPagarEstagiarios']?.value : 'Sim';
		feriasCalcJustaCausa = plutoRow.cells['feriasCalcJustaCausa']?.value != '' ? plutoRow.cells['feriasCalcJustaCausa']?.value : 'Sim';
		feriasMovimentoMensal = plutoRow.cells['feriasMovimentoMensal']?.value != '' ? plutoRow.cells['feriasMovimentoMensal']?.value : 'Sim';
	}	

	FolhaParametroModel clone() {
		return FolhaParametroModel(
			id: id,
			competencia: competencia,
			contribuiPis: contribuiPis,
			aliquotaPis: aliquotaPis,
			discriminarDsr: discriminarDsr,
			diaPagamento: diaPagamento,
			calculoProporcionalidade: calculoProporcionalidade,
			descontarFaltas13: descontarFaltas13,
			pagarAdicionais13: pagarAdicionais13,
			pagarEstagiarios13: pagarEstagiarios13,
			mesAdiantamento13: mesAdiantamento13,
			percentualAdiantam13: percentualAdiantam13,
			feriasDescontarFaltas: feriasDescontarFaltas,
			feriasPagarAdicionais: feriasPagarAdicionais,
			feriasAdiantar13: feriasAdiantar13,
			feriasPagarEstagiarios: feriasPagarEstagiarios,
			feriasCalcJustaCausa: feriasCalcJustaCausa,
			feriasMovimentoMensal: feriasMovimentoMensal,
		);			
	}

	
}