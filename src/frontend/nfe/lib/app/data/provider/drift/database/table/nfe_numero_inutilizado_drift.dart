import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeNumeroInutilizado")
class NfeNumeroInutilizados extends Table {
	@override
	String get tableName => 'nfe_numero_inutilizado';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get serie => text().named('serie').withLength(min: 0, max: 3).nullable()();
	IntColumn get numero => integer().named('numero').nullable()();
	DateTimeColumn get dataInutilizacao => dateTime().named('data_inutilizacao').nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeNumeroInutilizadoGrouped {
	NfeNumeroInutilizado? nfeNumeroInutilizado; 

  NfeNumeroInutilizadoGrouped({
		this.nfeNumeroInutilizado, 

  });
}
