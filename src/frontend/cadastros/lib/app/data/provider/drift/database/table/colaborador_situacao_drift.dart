import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("ColaboradorSituacao")
class ColaboradorSituacaos extends Table {
	@override
	String get tableName => 'colaborador_situacao';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 3).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ColaboradorSituacaoGrouped {
	ColaboradorSituacao? colaboradorSituacao; 

  ColaboradorSituacaoGrouped({
		this.colaboradorSituacao, 

  });
}
