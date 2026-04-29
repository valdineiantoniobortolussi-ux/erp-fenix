import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FolhaHistoricoSalarial")
class FolhaHistoricoSalarials extends Table {
	@override
	String get tableName => 'folha_historico_salarial';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	TextColumn get competencia => text().named('competencia').withLength(min: 0, max: 7).nullable()();
	RealColumn get salarioAtual => real().named('salario_atual').nullable()();
	RealColumn get percentualAumento => real().named('percentual_aumento').nullable()();
	RealColumn get salarioNovo => real().named('salario_novo').nullable()();
	TextColumn get validoAPartir => text().named('valido_a_partir').withLength(min: 0, max: 7).nullable()();
	TextColumn get motivo => text().named('motivo').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaHistoricoSalarialGrouped {
	FolhaHistoricoSalarial? folhaHistoricoSalarial; 
	ViewPessoaColaborador? viewPessoaColaborador; 

  FolhaHistoricoSalarialGrouped({
		this.folhaHistoricoSalarial, 
		this.viewPessoaColaborador, 

  });
}
