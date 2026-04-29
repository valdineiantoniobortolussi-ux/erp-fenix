import 'package:drift/drift.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';

@DataClassName("UsuarioToken")
class UsuarioTokens extends Table {
	@override
	String get tableName => 'usuario_token';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get login => text().named('login').withLength(min: 0, max: 50).nullable()();
	TextColumn get token => text().named('token').nullable()();
	DateTimeColumn get dataCriacao => dateTime().named('data_criacao').nullable()();
	TextColumn get horaCriacao => text().named('hora_criacao').withLength(min: 0, max: 8).nullable()();
	DateTimeColumn get dataExpiracao => dateTime().named('data_expiracao').nullable()();
	TextColumn get horaExpiracao => text().named('hora_expiracao').withLength(min: 0, max: 8).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class UsuarioTokenGrouped {
	UsuarioToken? usuarioToken; 

  UsuarioTokenGrouped({
		this.usuarioToken, 

  });
}
