import 'package:drift/drift.dart';
import 'package:pcp/app/data/provider/drift/database/database.dart';

@DataClassName("PcpOpDetalhe")
class PcpOpDetalhes extends Table {
	@override
	String get tableName => 'pcp_op_detalhe';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPcpOpCabecalho => integer().named('id_pcp_op_cabecalho').nullable()();
	IntColumn get idProduto => integer().named('id_produto').nullable()();
	RealColumn get quantidadeProduzir => real().named('quantidade_produzir').nullable()();
	RealColumn get quantidadeProduzida => real().named('quantidade_produzida').nullable()();
	RealColumn get quantidadeEntregue => real().named('quantidade_entregue').nullable()();
	RealColumn get custoPrevisto => real().named('custo_previsto').nullable()();
	RealColumn get custoRealizado => real().named('custo_realizado').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PcpOpDetalheGrouped {
	PcpOpDetalhe? pcpOpDetalhe; 
	Produto? produto; 

  PcpOpDetalheGrouped({
		this.pcpOpDetalhe, 
		this.produto, 

  });
}
