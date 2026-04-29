import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';

@DataClassName("PatrimGrupoBem")
class PatrimGrupoBems extends Table {
	@override
	String get tableName => 'patrim_grupo_bem';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 3).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();
	TextColumn get contaAtivoImobilizado => text().named('conta_ativo_imobilizado').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaDepreciacaoAcumulada => text().named('conta_depreciacao_acumulada').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaDespesaDepreciacao => text().named('conta_despesa_depreciacao').withLength(min: 0, max: 30).nullable()();
	IntColumn get codigoHistorico => integer().named('codigo_historico').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PatrimGrupoBemGrouped {
	PatrimGrupoBem? patrimGrupoBem; 

  PatrimGrupoBemGrouped({
		this.patrimGrupoBem, 

  });
}
