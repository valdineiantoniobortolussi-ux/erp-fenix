import 'package:drift/drift.dart';
import 'package:projetos/app/data/provider/drift/database/database.dart';
import 'package:projetos/app/data/provider/drift/database/database_imports.dart';

@DataClassName("ProjetoPrincipal")
class ProjetoPrincipals extends Table {
	@override
	String get tableName => 'projeto_principal';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	DateTimeColumn get dataInicio => dateTime().named('data_inicio').nullable()();
	DateTimeColumn get dataPrevisaoFim => dateTime().named('data_previsao_fim').nullable()();
	DateTimeColumn get dataFim => dateTime().named('data_fim').nullable()();
	RealColumn get valorOrcamento => real().named('valor_orcamento').nullable()();
	TextColumn get linkQuadroKanban => text().named('link_quadro_kanban').withLength(min: 0, max: 100).nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ProjetoPrincipalGrouped {
	ProjetoPrincipal? projetoPrincipal; 
	List<ProjetoCronogramaGrouped>? projetoCronogramaGroupedList; 
	List<ProjetoRiscoGrouped>? projetoRiscoGroupedList; 
	List<ProjetoCustoGrouped>? projetoCustoGroupedList; 
	List<ProjetoStakeholdersGrouped>? projetoStakeholdersGroupedList; 

  ProjetoPrincipalGrouped({
		this.projetoPrincipal, 
		this.projetoCronogramaGroupedList, 
		this.projetoRiscoGroupedList, 
		this.projetoCustoGroupedList, 
		this.projetoStakeholdersGroupedList, 

  });
}
