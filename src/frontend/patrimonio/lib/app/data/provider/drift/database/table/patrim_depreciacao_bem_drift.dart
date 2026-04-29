import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';

@DataClassName("PatrimDepreciacaoBem")
class PatrimDepreciacaoBems extends Table {
	@override
	String get tableName => 'patrim_depreciacao_bem';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPatrimBem => integer().named('id_patrim_bem').nullable()();
	DateTimeColumn get dataDepreciacao => dateTime().named('data_depreciacao').nullable()();
	IntColumn get dias => integer().named('dias').nullable()();
	RealColumn get taxa => real().named('taxa').nullable()();
	RealColumn get indice => real().named('indice').nullable()();
	RealColumn get valor => real().named('valor').nullable()();
	RealColumn get depreciacaoAcumulada => real().named('depreciacao_acumulada').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PatrimDepreciacaoBemGrouped {
	PatrimDepreciacaoBem? patrimDepreciacaoBem; 

  PatrimDepreciacaoBemGrouped({
		this.patrimDepreciacaoBem, 

  });
}
