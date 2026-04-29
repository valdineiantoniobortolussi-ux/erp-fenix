import 'package:drift/drift.dart';
import 'package:ordem_servico/app/data/provider/drift/database/database.dart';

@DataClassName("OsEquipamento")
class OsEquipamentos extends Table {
	@override
	String get tableName => 'os_equipamento';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class OsEquipamentoGrouped {
	OsEquipamento? osEquipamento; 

  OsEquipamentoGrouped({
		this.osEquipamento, 

  });
}
