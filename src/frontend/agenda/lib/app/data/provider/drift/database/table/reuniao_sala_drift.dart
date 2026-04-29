import 'package:drift/drift.dart';
import 'package:agenda/app/data/provider/drift/database/database.dart';

@DataClassName("ReuniaoSala")
class ReuniaoSalas extends Table {
	@override
	String get tableName => 'reuniao_sala';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get predio => text().named('predio').withLength(min: 0, max: 100).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get andar => text().named('andar').withLength(min: 0, max: 10).nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 10).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ReuniaoSalaGrouped {
	ReuniaoSala? reuniaoSala; 

  ReuniaoSalaGrouped({
		this.reuniaoSala, 

  });
}
