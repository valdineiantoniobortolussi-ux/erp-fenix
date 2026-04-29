import 'package:drift/drift.dart';
import 'package:orcamentos/app/data/provider/drift/database/database.dart';
import 'package:orcamentos/app/data/provider/drift/database/database_imports.dart';

@DataClassName("OrcamentoEmpresarial")
class OrcamentoEmpresarials extends Table {
	@override
	String get tableName => 'orcamento_empresarial';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idOrcamentoPeriodo => integer().named('id_orcamento_periodo').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 30).nullable()();
	DateTimeColumn get dataInicial => dateTime().named('data_inicial').nullable()();
	IntColumn get numeroPeriodos => integer().named('numero_periodos').nullable()();
	DateTimeColumn get dataBase => dateTime().named('data_base').nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class OrcamentoEmpresarialGrouped {
	OrcamentoEmpresarial? orcamentoEmpresarial; 
	List<OrcamentoDetalheGrouped>? orcamentoDetalheGroupedList; 
	OrcamentoPeriodo? orcamentoPeriodo; 

  OrcamentoEmpresarialGrouped({
		this.orcamentoEmpresarial, 
		this.orcamentoDetalheGroupedList, 
		this.orcamentoPeriodo, 

  });
}
