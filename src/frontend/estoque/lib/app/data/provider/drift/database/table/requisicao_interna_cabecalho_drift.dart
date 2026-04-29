import 'package:drift/drift.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';
import 'package:estoque/app/data/provider/drift/database/database_imports.dart';

@DataClassName("RequisicaoInternaCabecalho")
class RequisicaoInternaCabecalhos extends Table {
	@override
	String get tableName => 'requisicao_interna_cabecalho';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	DateTimeColumn get dataRequisicao => dateTime().named('data_requisicao').nullable()();
	TextColumn get situacao => text().named('situacao').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class RequisicaoInternaCabecalhoGrouped {
	RequisicaoInternaCabecalho? requisicaoInternaCabecalho; 
	List<RequisicaoInternaDetalheGrouped>? requisicaoInternaDetalheGroupedList; 
	ViewPessoaColaborador? viewPessoaColaborador; 

  RequisicaoInternaCabecalhoGrouped({
		this.requisicaoInternaCabecalho, 
		this.requisicaoInternaDetalheGroupedList, 
		this.viewPessoaColaborador, 

  });
}
