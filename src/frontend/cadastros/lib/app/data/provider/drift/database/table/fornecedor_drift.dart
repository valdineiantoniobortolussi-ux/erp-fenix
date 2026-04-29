import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("Fornecedor")
class Fornecedors extends Table {
	@override
	String get tableName => 'fornecedor';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPessoa => integer().named('id_pessoa').nullable()();
	DateTimeColumn get desde => dateTime().named('desde').nullable()();
	DateTimeColumn get dataCadastro => dateTime().named('data_cadastro').nullable()();
	TextColumn get observacao => text().named('observacao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FornecedorGrouped {
	Fornecedor? fornecedor; 

  FornecedorGrouped({
		this.fornecedor, 

  });
}
