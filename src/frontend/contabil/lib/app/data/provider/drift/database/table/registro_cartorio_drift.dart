import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("RegistroCartorio")
class RegistroCartorios extends Table {
	@override
	String get tableName => 'registro_cartorio';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nomeCartorio => text().named('nome_cartorio').withLength(min: 0, max: 100).nullable()();
	DateTimeColumn get dataRegistro => dateTime().named('data_registro').nullable()();
	IntColumn get numero => integer().named('numero').nullable()();
	IntColumn get folha => integer().named('folha').nullable()();
	IntColumn get livro => integer().named('livro').nullable()();
	TextColumn get nire => text().named('nire').withLength(min: 0, max: 11).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class RegistroCartorioGrouped {
	RegistroCartorio? registroCartorio; 

  RegistroCartorioGrouped({
		this.registroCartorio, 

  });
}
