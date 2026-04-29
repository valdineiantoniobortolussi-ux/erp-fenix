import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';

@DataClassName("PatrimMovimentacaoBem")
class PatrimMovimentacaoBems extends Table {
	@override
	String get tableName => 'patrim_movimentacao_bem';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPatrimBem => integer().named('id_patrim_bem').nullable()();
	IntColumn get idPatrimTipoMovimentacao => integer().named('id_patrim_tipo_movimentacao').nullable()();
	DateTimeColumn get dataMovimentacao => dateTime().named('data_movimentacao').nullable()();
	TextColumn get responsavel => text().named('responsavel').withLength(min: 0, max: 50).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PatrimMovimentacaoBemGrouped {
	PatrimMovimentacaoBem? patrimMovimentacaoBem; 
	PatrimTipoMovimentacao? patrimTipoMovimentacao; 

  PatrimMovimentacaoBemGrouped({
		this.patrimMovimentacaoBem, 
		this.patrimTipoMovimentacao, 

  });
}
