import 'package:drift/drift.dart';
import 'package:ordem_servico/app/data/provider/drift/database/database.dart';

@DataClassName("OsProdutoServico")
class OsProdutoServicos extends Table {
	@override
	String get tableName => 'os_produto_servico';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idOsAbertura => integer().named('id_os_abertura').nullable()();
	IntColumn get idProduto => integer().named('id_produto').nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	TextColumn get complemento => text().named('complemento').nullable()();
	RealColumn get quantidade => real().named('quantidade').nullable()();
	RealColumn get valorUnitario => real().named('valor_unitario').nullable()();
	RealColumn get valorSubtotal => real().named('valor_subtotal').nullable()();
	RealColumn get taxaDesconto => real().named('taxa_desconto').nullable()();
	RealColumn get valorDesconto => real().named('valor_desconto').nullable()();
	RealColumn get valorTotal => real().named('valor_total').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class OsProdutoServicoGrouped {
	OsProdutoServico? osProdutoServico; 
	Produto? produto; 

  OsProdutoServicoGrouped({
		this.osProdutoServico, 
		this.produto, 

  });
}
