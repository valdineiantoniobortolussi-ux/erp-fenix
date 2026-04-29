import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';

@DataClassName("MdfeRodoviarioCiot")
class MdfeRodoviarioCiots extends Table {
	@override
	String get tableName => 'mdfe_rodoviario_ciot';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idMdfeRodoviario => integer().named('id_mdfe_rodoviario').nullable()();
	TextColumn get ciot => text().named('ciot').withLength(min: 0, max: 12).nullable()();
	TextColumn get cpf => text().named('cpf').withLength(min: 0, max: 11).nullable()();
	TextColumn get cnpj => text().named('cnpj').withLength(min: 0, max: 14).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class MdfeRodoviarioCiotGrouped {
	MdfeRodoviarioCiot? mdfeRodoviarioCiot; 
	MdfeRodoviario? mdfeRodoviario; 

  MdfeRodoviarioCiotGrouped({
		this.mdfeRodoviarioCiot, 
		this.mdfeRodoviario, 

  });
}
