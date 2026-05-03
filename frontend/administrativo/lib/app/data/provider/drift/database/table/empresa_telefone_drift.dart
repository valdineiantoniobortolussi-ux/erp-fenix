import 'package:drift/drift.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';

@DataClassName("EmpresaTelefone")
class EmpresaTelefones extends Table {
	@override
	String get tableName => 'empresa_telefone';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idEmpresa => integer().named('id_empresa').nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 15).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EmpresaTelefoneGrouped {
	EmpresaTelefone? empresaTelefone; 

  EmpresaTelefoneGrouped({
		this.empresaTelefone, 

  });
}
