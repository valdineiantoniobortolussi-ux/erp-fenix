import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("PessoaContato")
class PessoaContatos extends Table {
	@override
	String get tableName => 'pessoa_contato';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPessoa => integer().named('id_pessoa').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 150).nullable()();
	TextColumn get email => text().named('email').withLength(min: 0, max: 250).nullable()();
	TextColumn get observacao => text().named('observacao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PessoaContatoGrouped {
	PessoaContato? pessoaContato; 

  PessoaContatoGrouped({
		this.pessoaContato, 

  });
}
