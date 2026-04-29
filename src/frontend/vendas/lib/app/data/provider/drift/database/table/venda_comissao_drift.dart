import 'package:drift/drift.dart';
import 'package:vendas/app/data/provider/drift/database/database.dart';

@DataClassName("VendaComissao")
class VendaComissaos extends Table {
	@override
	String get tableName => 'venda_comissao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idVendaCabecalho => integer().named('id_venda_cabecalho').nullable()();
	IntColumn get idVendedor => integer().named('id_vendedor').nullable()();
	RealColumn get valorVenda => real().named('valor_venda').nullable()();
	TextColumn get tipoContabil => text().named('tipo_contabil').withLength(min: 0, max: 1).nullable()();
	RealColumn get valorComissao => real().named('valor_comissao').nullable()();
	TextColumn get situacao => text().named('situacao').withLength(min: 0, max: 1).nullable()();
	DateTimeColumn get dataLancamento => dateTime().named('data_lancamento').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class VendaComissaoGrouped {
	VendaComissao? vendaComissao; 
	ViewPessoaVendedor? viewPessoaVendedor; 

  VendaComissaoGrouped({
		this.vendaComissao, 
		this.viewPessoaVendedor, 

  });
}
