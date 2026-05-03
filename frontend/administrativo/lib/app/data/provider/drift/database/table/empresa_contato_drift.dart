import 'package:drift/drift.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';

@DataClassName("EmpresaContato")
class EmpresaContatos extends Table {
	@override
	String get tableName => 'empresa_contato';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idEmpresa => integer().named('id_empresa').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 150).nullable()();
	TextColumn get email => text().named('email').withLength(min: 0, max: 250).nullable()();
	TextColumn get observacao => text().named('observacao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EmpresaContatoGrouped {
	EmpresaContato? empresaContato; 

  EmpresaContatoGrouped({
		this.empresaContato, 

  });
}
