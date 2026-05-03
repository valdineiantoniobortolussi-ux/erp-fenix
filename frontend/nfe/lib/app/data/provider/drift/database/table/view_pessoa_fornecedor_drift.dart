import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("ViewPessoaFornecedor")
class ViewPessoaFornecedors extends Table {
	@override
	String get tableName => 'view_pessoa_fornecedor';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 450).nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 3).nullable()();
	TextColumn get email => text().named('email').withLength(min: 0, max: 750).nullable()();
	TextColumn get site => text().named('site').withLength(min: 0, max: 450).nullable()();
	TextColumn get cpfCnpj => text().named('cpf_cnpj').withLength(min: 0, max: 20).nullable()();
	TextColumn get rgIe => text().named('rg_ie').withLength(min: 0, max: 20).nullable()();
	DateTimeColumn get desde => dateTime().named('desde').nullable()();
	DateTimeColumn get dataCadastro => dateTime().named('data_cadastro').nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();
	IntColumn get idPessoa => integer().named('id_pessoa').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ViewPessoaFornecedorGrouped {
	ViewPessoaFornecedor? viewPessoaFornecedor; 

  ViewPessoaFornecedorGrouped({
		this.viewPessoaFornecedor, 

  });
}
