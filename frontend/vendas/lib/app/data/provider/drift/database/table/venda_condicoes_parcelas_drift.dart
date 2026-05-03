import 'package:drift/drift.dart';
import 'package:vendas/app/data/provider/drift/database/database.dart';

@DataClassName("VendaCondicoesParcelas")
class VendaCondicoesParcelass extends Table {
	@override
	String get tableName => 'venda_condicoes_parcelas';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idVendaCondicoesPagamento => integer().named('id_venda_condicoes_pagamento').nullable()();
	IntColumn get parcela => integer().named('parcela').nullable()();
	IntColumn get dias => integer().named('dias').nullable()();
	RealColumn get taxa => real().named('taxa').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class VendaCondicoesParcelasGrouped {
	VendaCondicoesParcelas? vendaCondicoesParcelas; 

  VendaCondicoesParcelasGrouped({
		this.vendaCondicoesParcelas, 

  });
}
