import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';

@DataClassName("PatrimDocumentoBem")
class PatrimDocumentoBems extends Table {
	@override
	String get tableName => 'patrim_documento_bem';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPatrimBem => integer().named('id_patrim_bem').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();
	TextColumn get imagem => text().named('imagem').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PatrimDocumentoBemGrouped {
	PatrimDocumentoBem? patrimDocumentoBem; 

  PatrimDocumentoBemGrouped({
		this.patrimDocumentoBem, 

  });
}
