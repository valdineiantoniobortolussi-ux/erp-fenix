import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';

@DataClassName("PatrimTipoMovimentacao")
class PatrimTipoMovimentacaos extends Table {
	@override
	String get tableName => 'patrim_tipo_movimentacao';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PatrimTipoMovimentacaoGrouped {
	PatrimTipoMovimentacao? patrimTipoMovimentacao; 

  PatrimTipoMovimentacaoGrouped({
		this.patrimTipoMovimentacao, 

  });
}
