import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("ContabilLote")
class ContabilLotes extends Table {
	@override
	String get tableName => 'contabil_lote';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();
	DateTimeColumn get dataInclusao => dateTime().named('data_inclusao').nullable()();
	DateTimeColumn get dataLiberacao => dateTime().named('data_liberacao').nullable()();
	TextColumn get liberado => text().named('liberado').withLength(min: 0, max: 1).nullable()();
	TextColumn get programado => text().named('programado').withLength(min: 0, max: 1).nullable()();
	RealColumn get valor => real().named('valor').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContabilLoteGrouped {
	ContabilLote? contabilLote; 

  ContabilLoteGrouped({
		this.contabilLote, 

  });
}
