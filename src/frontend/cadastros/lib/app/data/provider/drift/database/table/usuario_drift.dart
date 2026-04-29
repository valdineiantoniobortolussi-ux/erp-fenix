import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("Usuario")
class Usuarios extends Table {
	@override
	String get tableName => 'usuario';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPapel => integer().named('id_papel').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	TextColumn get login => text().named('login').withLength(min: 0, max: 50).nullable()();
	TextColumn get senha => text().named('senha').withLength(min: 0, max: 50).nullable()();
	TextColumn get administrador => text().named('administrador').withLength(min: 0, max: 1).nullable()();
	DateTimeColumn get dataCadastro => dateTime().named('data_cadastro').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class UsuarioGrouped {
	Usuario? usuario; 

  UsuarioGrouped({
		this.usuario, 

  });
}
