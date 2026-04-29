import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("ViewPessoaUsuario")
class ViewPessoaUsuarios extends Table {
	@override
	String get tableName => 'view_pessoa_usuario';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPessoa => integer().named('id_pessoa').nullable()();
	TextColumn get pessoaNome => text().named('pessoa_nome').withLength(min: 0, max: 450).nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 3).nullable()();
	TextColumn get email => text().named('email').withLength(min: 0, max: 750).nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	IntColumn get idUsuario => integer().named('id_usuario').nullable()();
	TextColumn get login => text().named('login').withLength(min: 0, max: 150).nullable()();
	TextColumn get senha => text().named('senha').withLength(min: 0, max: 150).nullable()();
	DateTimeColumn get dataCadastro => dateTime().named('data_cadastro').nullable()();
	TextColumn get administrador => text().named('administrador').withLength(min: 0, max: 3).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ViewPessoaUsuarioGrouped {
	ViewPessoaUsuario? viewPessoaUsuario; 

  ViewPessoaUsuarioGrouped({
		this.viewPessoaUsuario, 

  });
}
