import 'package:drift/drift.dart';
import 'package:projetos/app/data/provider/drift/database/database.dart';

@DataClassName("ProjetoCusto")
class ProjetoCustos extends Table {
	@override
	String get tableName => 'projeto_custo';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idProjetoPrincipal => integer().named('id_projeto_principal').nullable()();
	IntColumn get idFinNaturezaFinanceira => integer().named('id_fin_natureza_financeira').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	RealColumn get valorMensal => real().named('valor_mensal').nullable()();
	RealColumn get valorTotal => real().named('valor_total').nullable()();
	TextColumn get justificativa => text().named('justificativa').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ProjetoCustoGrouped {
	ProjetoCusto? projetoCusto; 
	FinNaturezaFinanceira? finNaturezaFinanceira; 

  ProjetoCustoGrouped({
		this.projetoCusto, 
		this.finNaturezaFinanceira, 

  });
}
