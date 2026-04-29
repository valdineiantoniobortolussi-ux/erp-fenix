import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FolhaTipoAfastamento")
class FolhaTipoAfastamentos extends Table {
	@override
	String get tableName => 'folha_tipo_afastamento';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 3).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get codigoEsocial => text().named('codigo_esocial').withLength(min: 0, max: 2).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaTipoAfastamentoGrouped {
	FolhaTipoAfastamento? folhaTipoAfastamento; 

  FolhaTipoAfastamentoGrouped({
		this.folhaTipoAfastamento, 

  });
}
