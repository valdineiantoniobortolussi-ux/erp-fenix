import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';

@DataClassName("MdfeRodoviario")
class MdfeRodoviarios extends Table {
	@override
	String get tableName => 'mdfe_rodoviario';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idMdfeCabecalho => integer().named('id_mdfe_cabecalho').nullable()();
	TextColumn get rntrc => text().named('rntrc').withLength(min: 0, max: 8).nullable()();
	TextColumn get codigoAgendamento => text().named('codigo_agendamento').withLength(min: 0, max: 16).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class MdfeRodoviarioGrouped {
	MdfeRodoviario? mdfeRodoviario; 

  MdfeRodoviarioGrouped({
		this.mdfeRodoviario, 

  });
}
