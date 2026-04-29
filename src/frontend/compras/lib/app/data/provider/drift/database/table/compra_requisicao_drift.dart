import 'package:drift/drift.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';
import 'package:compras/app/data/provider/drift/database/database_imports.dart';

@DataClassName("CompraRequisicao")
class CompraRequisicaos extends Table {
	@override
	String get tableName => 'compra_requisicao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCompraTipoRequisicao => integer().named('id_compra_tipo_requisicao').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();
	DateTimeColumn get dataRequisicao => dateTime().named('data_requisicao').nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CompraRequisicaoGrouped {
	CompraRequisicao? compraRequisicao; 
	List<CompraRequisicaoDetalheGrouped>? compraRequisicaoDetalheGroupedList; 
	ViewPessoaColaborador? viewPessoaColaborador; 
	CompraTipoRequisicao? compraTipoRequisicao; 

  CompraRequisicaoGrouped({
		this.compraRequisicao, 
		this.compraRequisicaoDetalheGroupedList, 
		this.viewPessoaColaborador, 
		this.compraTipoRequisicao, 

  });
}
