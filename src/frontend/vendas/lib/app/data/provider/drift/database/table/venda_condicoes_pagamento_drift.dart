import 'package:drift/drift.dart';
import 'package:vendas/app/data/provider/drift/database/database.dart';
import 'package:vendas/app/data/provider/drift/database/database_imports.dart';

@DataClassName("VendaCondicoesPagamento")
class VendaCondicoesPagamentos extends Table {
	@override
	String get tableName => 'venda_condicoes_pagamento';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();
	RealColumn get faturamentoMinimo => real().named('faturamento_minimo').nullable()();
	RealColumn get faturamentoMaximo => real().named('faturamento_maximo').nullable()();
	RealColumn get indiceCorrecao => real().named('indice_correcao').nullable()();
	IntColumn get diasTolerancia => integer().named('dias_tolerancia').nullable()();
	RealColumn get valorTolerancia => real().named('valor_tolerancia').nullable()();
	IntColumn get prazoMedio => integer().named('prazo_medio').nullable()();
	TextColumn get vistaPrazo => text().named('vista_prazo').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class VendaCondicoesPagamentoGrouped {
	VendaCondicoesPagamento? vendaCondicoesPagamento; 
	List<VendaCondicoesParcelasGrouped>? vendaCondicoesParcelasGroupedList; 

  VendaCondicoesPagamentoGrouped({
		this.vendaCondicoesPagamento, 
		this.vendaCondicoesParcelasGroupedList, 

  });
}
