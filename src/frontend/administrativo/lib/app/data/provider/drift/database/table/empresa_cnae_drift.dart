import 'package:drift/drift.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';

@DataClassName("EmpresaCnae")
class EmpresaCnaes extends Table {
	@override
	String get tableName => 'empresa_cnae';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idEmpresa => integer().named('id_empresa').nullable()();
	IntColumn get idCnae => integer().named('id_cnae').nullable()();
	TextColumn get principal => text().named('principal').withLength(min: 0, max: 1).nullable()();
	TextColumn get ramoAtividade => text().named('ramo_atividade').withLength(min: 0, max: 50).nullable()();
	TextColumn get objetoSocial => text().named('objeto_social').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EmpresaCnaeGrouped {
	EmpresaCnae? empresaCnae; 
	Cnae? cnae; 

  EmpresaCnaeGrouped({
		this.empresaCnae, 
		this.cnae, 

  });
}
