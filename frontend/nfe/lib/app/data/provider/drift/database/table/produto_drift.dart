import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("Produto")
class Produtos extends Table {
	@override
	String get tableName => 'produto';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idProdutoSubgrupo => integer().named('id_produto_subgrupo').nullable()();
	IntColumn get idProdutoMarca => integer().named('id_produto_marca').nullable()();
	IntColumn get idProdutoUnidade => integer().named('id_produto_unidade').nullable()();
	IntColumn get idTributIcmsCustomCab => integer().named('id_tribut_icms_custom_cab').nullable()();
	IntColumn get idTributGrupoTributario => integer().named('id_tribut_grupo_tributario').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 250).nullable()();
	TextColumn get gtin => text().named('gtin').withLength(min: 0, max: 14).nullable()();
	TextColumn get codigoInterno => text().named('codigo_interno').withLength(min: 0, max: 50).nullable()();
	RealColumn get valorCompra => real().named('valor_compra').nullable()();
	RealColumn get valorVenda => real().named('valor_venda').nullable()();
	TextColumn get codigoNcm => text().named('codigo_ncm').withLength(min: 0, max: 8).nullable()();
	RealColumn get estoqueMinimo => real().named('estoque_minimo').nullable()();
	RealColumn get estoqueMaximo => real().named('estoque_maximo').nullable()();
	RealColumn get quantidadeEstoque => real().named('quantidade_estoque').nullable()();
	DateTimeColumn get dataCadastro => dateTime().named('data_cadastro').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ProdutoGrouped {
	Produto? produto; 

  ProdutoGrouped({
		this.produto, 

  });
}
