import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';

@DataClassName("SimplesNacionalCabecalho")
class SimplesNacionalCabecalhos extends Table {
	@override
	String get tableName => 'simples_nacional_cabecalho';

	IntColumn get id => integer().named('id').nullable()();
	DateTimeColumn get vigenciaInicial => dateTime().named('vigencia_inicial').nullable()();
	DateTimeColumn get vigenciaFinal => dateTime().named('vigencia_final').nullable()();
	TextColumn get anexo => text().named('anexo').withLength(min: 0, max: 10).nullable()();
	TextColumn get tabela => text().named('tabela').withLength(min: 0, max: 10).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class SimplesNacionalCabecalhoGrouped {
	SimplesNacionalCabecalho? simplesNacionalCabecalho; 
	List<SimplesNacionalDetalheGrouped>? simplesNacionalDetalheGroupedList; 

  SimplesNacionalCabecalhoGrouped({
		this.simplesNacionalCabecalho, 
		this.simplesNacionalDetalheGroupedList, 

  });
}
