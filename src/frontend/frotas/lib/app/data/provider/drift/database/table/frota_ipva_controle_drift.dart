import 'package:drift/drift.dart';
import 'package:frotas/app/data/provider/drift/database/database.dart';

@DataClassName("FrotaIpvaControle")
class FrotaIpvaControles extends Table {
	@override
	String get tableName => 'frota_ipva_controle';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFrotaVeiculo => integer().named('id_frota_veiculo').nullable()();
	TextColumn get ano => text().named('ano').withLength(min: 0, max: 4).nullable()();
	TextColumn get parcela => text().named('parcela').withLength(min: 0, max: 2).nullable()();
	DateTimeColumn get dataVencimento => dateTime().named('data_vencimento').nullable()();
	DateTimeColumn get dataPagamento => dateTime().named('data_pagamento').nullable()();
	RealColumn get valor => real().named('valor').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FrotaIpvaControleGrouped {
	FrotaIpvaControle? frotaIpvaControle; 

  FrotaIpvaControleGrouped({
		this.frotaIpvaControle, 

  });
}
