import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("ColaboradorTipo")
class ColaboradorTipos extends Table {
	@override
	String get tableName => 'colaborador_tipo';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 20).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ColaboradorTipoGrouped {
	ColaboradorTipo? colaboradorTipo; 

  ColaboradorTipoGrouped({
		this.colaboradorTipo, 

  });
}
