import 'package:drift/drift.dart';
import 'package:ordem_servico/app/data/provider/drift/database/database.dart';

@DataClassName("OsAberturaEquipamento")
class OsAberturaEquipamentos extends Table {
	@override
	String get tableName => 'os_abertura_equipamento';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idOsAbertura => integer().named('id_os_abertura').nullable()();
	IntColumn get idOsEquipamento => integer().named('id_os_equipamento').nullable()();
	TextColumn get tipoCobertura => text().named('tipo_cobertura').withLength(min: 0, max: 1).nullable()();
	TextColumn get numeroSerie => text().named('numero_serie').withLength(min: 0, max: 50).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class OsAberturaEquipamentoGrouped {
	OsAberturaEquipamento? osAberturaEquipamento; 
	OsEquipamento? osEquipamento; 

  OsAberturaEquipamentoGrouped({
		this.osAberturaEquipamento, 
		this.osEquipamento, 

  });
}
