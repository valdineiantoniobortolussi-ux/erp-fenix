import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("PessoaTelefone")
class PessoaTelefones extends Table {
	@override
	String get tableName => 'pessoa_telefone';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPessoa => integer().named('id_pessoa').nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 15).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PessoaTelefoneGrouped {
	PessoaTelefone? pessoaTelefone; 

  PessoaTelefoneGrouped({
		this.pessoaTelefone, 

  });
}
