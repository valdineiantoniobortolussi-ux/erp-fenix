import 'package:drift/drift.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';
import 'package:estoque/app/data/provider/drift/database/database_imports.dart';

@DataClassName("EstoqueReajusteCabecalho")
class EstoqueReajusteCabecalhos extends Table {
	@override
	String get tableName => 'estoque_reajuste_cabecalho';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	DateTimeColumn get dataReajuste => dateTime().named('data_reajuste').nullable()();
	RealColumn get taxa => real().named('taxa').nullable()();
	TextColumn get tipoReajuste => text().named('tipo_reajuste').withLength(min: 0, max: 1).nullable()();
	TextColumn get justificativa => text().named('justificativa').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EstoqueReajusteCabecalhoGrouped {
	EstoqueReajusteCabecalho? estoqueReajusteCabecalho; 
	List<EstoqueReajusteDetalheGrouped>? estoqueReajusteDetalheGroupedList; 
	ViewPessoaColaborador? viewPessoaColaborador; 

  EstoqueReajusteCabecalhoGrouped({
		this.estoqueReajusteCabecalho, 
		this.estoqueReajusteDetalheGroupedList, 
		this.viewPessoaColaborador, 

  });
}
