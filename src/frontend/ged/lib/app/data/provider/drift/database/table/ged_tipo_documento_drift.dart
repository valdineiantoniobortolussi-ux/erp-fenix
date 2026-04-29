import 'package:drift/drift.dart';
import 'package:ged/app/data/provider/drift/database/database.dart';

@DataClassName("GedTipoDocumento")
class GedTipoDocumentos extends Table {
	@override
	String get tableName => 'ged_tipo_documento';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	RealColumn get tamanhoMaximo => real().named('tamanho_maximo').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class GedTipoDocumentoGrouped {
	GedTipoDocumento? gedTipoDocumento; 

  GedTipoDocumentoGrouped({
		this.gedTipoDocumento, 

  });
}
