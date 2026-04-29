import 'package:drift/drift.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';

@DataClassName("RequisicaoInternaDetalhe")
class RequisicaoInternaDetalhes extends Table {
	@override
	String get tableName => 'requisicao_interna_detalhe';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idRequisicaoInternaCabecalho => integer().named('id_requisicao_interna_cabecalho').nullable()();
	IntColumn get idProduto => integer().named('id_produto').nullable()();
	RealColumn get quantidade => real().named('quantidade').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class RequisicaoInternaDetalheGrouped {
	RequisicaoInternaDetalhe? requisicaoInternaDetalhe; 
	Produto? produto; 

  RequisicaoInternaDetalheGrouped({
		this.requisicaoInternaDetalhe, 
		this.produto, 

  });
}
