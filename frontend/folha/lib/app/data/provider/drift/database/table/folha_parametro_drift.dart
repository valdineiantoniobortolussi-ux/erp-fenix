import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FolhaParametro")
class FolhaParametros extends Table {
	@override
	String get tableName => 'folha_parametro';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get competencia => text().named('competencia').withLength(min: 0, max: 7).nullable()();
	TextColumn get contribuiPis => text().named('contribui_pis').withLength(min: 0, max: 1).nullable()();
	RealColumn get aliquotaPis => real().named('aliquota_pis').nullable()();
	TextColumn get discriminarDsr => text().named('discriminar_dsr').withLength(min: 0, max: 1).nullable()();
	TextColumn get diaPagamento => text().named('dia_pagamento').withLength(min: 0, max: 2).nullable()();
	TextColumn get calculoProporcionalidade => text().named('calculo_proporcionalidade').withLength(min: 0, max: 1).nullable()();
	TextColumn get descontarFaltas13 => text().named('descontar_faltas_13').withLength(min: 0, max: 1).nullable()();
	TextColumn get pagarAdicionais13 => text().named('pagar_adicionais_13').withLength(min: 0, max: 1).nullable()();
	TextColumn get pagarEstagiarios13 => text().named('pagar_estagiarios_13').withLength(min: 0, max: 1).nullable()();
	TextColumn get mesAdiantamento13 => text().named('mes_adiantamento_13').withLength(min: 0, max: 2).nullable()();
	RealColumn get percentualAdiantam13 => real().named('percentual_adiantam_13').nullable()();
	TextColumn get feriasDescontarFaltas => text().named('ferias_descontar_faltas').withLength(min: 0, max: 1).nullable()();
	TextColumn get feriasPagarAdicionais => text().named('ferias_pagar_adicionais').withLength(min: 0, max: 1).nullable()();
	TextColumn get feriasAdiantar13 => text().named('ferias_adiantar_13').withLength(min: 0, max: 1).nullable()();
	TextColumn get feriasPagarEstagiarios => text().named('ferias_pagar_estagiarios').withLength(min: 0, max: 1).nullable()();
	TextColumn get feriasCalcJustaCausa => text().named('ferias_calc_justa_causa').withLength(min: 0, max: 1).nullable()();
	TextColumn get feriasMovimentoMensal => text().named('ferias_movimento_mensal').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaParametroGrouped {
	FolhaParametro? folhaParametro; 

  FolhaParametroGrouped({
		this.folhaParametro, 

  });
}
