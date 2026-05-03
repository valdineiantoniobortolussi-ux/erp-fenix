import 'package:drift/drift.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';

@DataClassName("CompraTipoRequisicao")
class CompraTipoRequisicaos extends Table {
	@override
	String get tableName => 'compra_tipo_requisicao';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 2).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 30).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CompraTipoRequisicaoGrouped {
	CompraTipoRequisicao? compraTipoRequisicao; 

  CompraTipoRequisicaoGrouped({
		this.compraTipoRequisicao, 

  });
}
