import 'package:drift/drift.dart';
import 'package:etiquetas/app/data/provider/drift/database/database.dart';

@DataClassName("EtiquetaFormatoPapel")
class EtiquetaFormatoPapels extends Table {
	@override
	String get tableName => 'etiqueta_formato_papel';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();
	IntColumn get altura => integer().named('altura').nullable()();
	IntColumn get largura => integer().named('largura').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EtiquetaFormatoPapelGrouped {
	EtiquetaFormatoPapel? etiquetaFormatoPapel; 

  EtiquetaFormatoPapelGrouped({
		this.etiquetaFormatoPapel, 

  });
}
