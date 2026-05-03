import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("OperadoraPlanoSaude")
class OperadoraPlanoSaudes extends Table {
	@override
	String get tableName => 'operadora_plano_saude';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get registroAns => text().named('registro_ans').withLength(min: 0, max: 20).nullable()();
	TextColumn get classificacaoContabilConta => text().named('classificacao_contabil_conta').withLength(min: 0, max: 30).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class OperadoraPlanoSaudeGrouped {
	OperadoraPlanoSaude? operadoraPlanoSaude; 

  OperadoraPlanoSaudeGrouped({
		this.operadoraPlanoSaude, 

  });
}
