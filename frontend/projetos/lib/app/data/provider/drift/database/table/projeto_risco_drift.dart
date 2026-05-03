import 'package:drift/drift.dart';
import 'package:projetos/app/data/provider/drift/database/database.dart';

@DataClassName("ProjetoRisco")
class ProjetoRiscos extends Table {
	@override
	String get tableName => 'projeto_risco';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idProjetoPrincipal => integer().named('id_projeto_principal').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	IntColumn get probabilidade => integer().named('probabilidade').nullable()();
	IntColumn get impacto => integer().named('impacto').nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ProjetoRiscoGrouped {
	ProjetoRisco? projetoRisco; 

  ProjetoRiscoGrouped({
		this.projetoRisco, 

  });
}
