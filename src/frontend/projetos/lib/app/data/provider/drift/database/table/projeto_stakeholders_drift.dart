import 'package:drift/drift.dart';
import 'package:projetos/app/data/provider/drift/database/database.dart';

@DataClassName("ProjetoStakeholders")
class ProjetoStakeholderss extends Table {
	@override
	String get tableName => 'projeto_stakeholders';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idProjetoPrincipal => integer().named('id_projeto_principal').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ProjetoStakeholdersGrouped {
	ProjetoStakeholders? projetoStakeholders; 
	ViewPessoaColaborador? viewPessoaColaborador; 

  ProjetoStakeholdersGrouped({
		this.projetoStakeholders, 
		this.viewPessoaColaborador, 

  });
}
