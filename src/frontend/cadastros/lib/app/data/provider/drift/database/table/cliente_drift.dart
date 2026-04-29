import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("Cliente")
class Clientes extends Table {
	@override
	String get tableName => 'cliente';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPessoa => integer().named('id_pessoa').nullable()();
	IntColumn get idTabelaPreco => integer().named('id_tabela_preco').nullable()();
	DateTimeColumn get desde => dateTime().named('desde').nullable()();
	DateTimeColumn get dataCadastro => dateTime().named('data_cadastro').nullable()();
	RealColumn get taxaDesconto => real().named('taxa_desconto').nullable()();
	RealColumn get limiteCredito => real().named('limite_credito').nullable()();
	TextColumn get observacao => text().named('observacao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ClienteGrouped {
	Cliente? cliente; 
	TabelaPreco? tabelaPreco; 

  ClienteGrouped({
		this.cliente, 
		this.tabelaPreco, 

  });
}
