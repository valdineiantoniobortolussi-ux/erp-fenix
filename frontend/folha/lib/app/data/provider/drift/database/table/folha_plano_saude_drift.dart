import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FolhaPlanoSaude")
class FolhaPlanoSaudes extends Table {
	@override
	String get tableName => 'folha_plano_saude';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idOperadoraPlanoSaude => integer().named('id_operadora_plano_saude').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	DateTimeColumn get dataInicio => dateTime().named('data_inicio').nullable()();
	TextColumn get beneficiario => text().named('beneficiario').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaPlanoSaudeGrouped {
	FolhaPlanoSaude? folhaPlanoSaude; 
	ViewPessoaColaborador? viewPessoaColaborador; 
	OperadoraPlanoSaude? operadoraPlanoSaude; 

  FolhaPlanoSaudeGrouped({
		this.folhaPlanoSaude, 
		this.viewPessoaColaborador, 
		this.operadoraPlanoSaude, 

  });
}
