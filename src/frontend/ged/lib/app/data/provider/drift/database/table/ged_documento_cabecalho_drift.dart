import 'package:drift/drift.dart';
import 'package:ged/app/data/provider/drift/database/database.dart';
import 'package:ged/app/data/provider/drift/database/database_imports.dart';

@DataClassName("GedDocumentoCabecalho")
class GedDocumentoCabecalhos extends Table {
	@override
	String get tableName => 'ged_documento_cabecalho';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	DateTimeColumn get dataInclusao => dateTime().named('data_inclusao').nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class GedDocumentoCabecalhoGrouped {
	GedDocumentoCabecalho? gedDocumentoCabecalho; 
	List<GedDocumentoDetalheGrouped>? gedDocumentoDetalheGroupedList; 

  GedDocumentoCabecalhoGrouped({
		this.gedDocumentoCabecalho, 
		this.gedDocumentoDetalheGroupedList, 

  });
}
