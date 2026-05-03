import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';

@DataClassName("MdfeRodoviarioPedagio")
class MdfeRodoviarioPedagios extends Table {
	@override
	String get tableName => 'mdfe_rodoviario_pedagio';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idMdfeRodoviario => integer().named('id_mdfe_rodoviario').nullable()();
	TextColumn get cnpjFornecedor => text().named('cnpj_fornecedor').withLength(min: 0, max: 14).nullable()();
	TextColumn get cnpjResponsavel => text().named('cnpj_responsavel').withLength(min: 0, max: 14).nullable()();
	TextColumn get cpfResponsavel => text().named('cpf_responsavel').withLength(min: 0, max: 11).nullable()();
	TextColumn get numeroComprovante => text().named('numero_comprovante').withLength(min: 0, max: 20).nullable()();
	RealColumn get valor => real().named('valor').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class MdfeRodoviarioPedagioGrouped {
	MdfeRodoviarioPedagio? mdfeRodoviarioPedagio; 
	MdfeRodoviario? mdfeRodoviario; 

  MdfeRodoviarioPedagioGrouped({
		this.mdfeRodoviarioPedagio, 
		this.mdfeRodoviario, 

  });
}
