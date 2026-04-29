import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';

@DataClassName("MdfeRodoviarioMotorista")
class MdfeRodoviarioMotoristas extends Table {
	@override
	String get tableName => 'mdfe_rodoviario_motorista';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idMdfeRodoviario => integer().named('id_mdfe_rodoviario').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 60).nullable()();
	TextColumn get cpf => text().named('cpf').withLength(min: 0, max: 11).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class MdfeRodoviarioMotoristaGrouped {
	MdfeRodoviarioMotorista? mdfeRodoviarioMotorista; 
	MdfeRodoviario? mdfeRodoviario; 

  MdfeRodoviarioMotoristaGrouped({
		this.mdfeRodoviarioMotorista, 
		this.mdfeRodoviario, 

  });
}
