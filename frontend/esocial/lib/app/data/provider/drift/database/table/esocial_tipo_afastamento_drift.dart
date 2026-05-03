import 'package:drift/drift.dart';
import 'package:esocial/app/data/provider/drift/database/database.dart';

@DataClassName("EsocialTipoAfastamento")
class EsocialTipoAfastamentos extends Table {
	@override
	String get tableName => 'esocial_tipo_afastamento';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 2).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EsocialTipoAfastamentoGrouped {
	EsocialTipoAfastamento? esocialTipoAfastamento; 

  EsocialTipoAfastamentoGrouped({
		this.esocialTipoAfastamento, 

  });
}
