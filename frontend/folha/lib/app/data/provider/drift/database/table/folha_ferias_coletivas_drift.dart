import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FolhaFeriasColetivas")
class FolhaFeriasColetivass extends Table {
	@override
	String get tableName => 'folha_ferias_coletivas';

	IntColumn get id => integer().named('id').nullable()();
	DateTimeColumn get dataInicio => dateTime().named('data_inicio').nullable()();
	DateTimeColumn get dataFim => dateTime().named('data_fim').nullable()();
	IntColumn get diasGozo => integer().named('dias_gozo').nullable()();
	DateTimeColumn get abonoPecuniarioInicio => dateTime().named('abono_pecuniario_inicio').nullable()();
	DateTimeColumn get abonoPecuniarioFim => dateTime().named('abono_pecuniario_fim').nullable()();
	IntColumn get diasAbono => integer().named('dias_abono').nullable()();
	DateTimeColumn get dataPagamento => dateTime().named('data_pagamento').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaFeriasColetivasGrouped {
	FolhaFeriasColetivas? folhaFeriasColetivas; 

  FolhaFeriasColetivasGrouped({
		this.folhaFeriasColetivas, 

  });
}
