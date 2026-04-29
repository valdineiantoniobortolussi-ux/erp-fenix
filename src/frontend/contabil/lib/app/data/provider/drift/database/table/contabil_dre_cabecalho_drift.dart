import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

@DataClassName("ContabilDreCabecalho")
class ContabilDreCabecalhos extends Table {
	@override
	String get tableName => 'contabil_dre_cabecalho';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();
	TextColumn get padrao => text().named('padrao').withLength(min: 0, max: 1).nullable()();
	TextColumn get periodoInicial => text().named('periodo_inicial').withLength(min: 0, max: 7).nullable()();
	TextColumn get periodoFinal => text().named('periodo_final').withLength(min: 0, max: 7).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContabilDreCabecalhoGrouped {
	ContabilDreCabecalho? contabilDreCabecalho; 
	List<ContabilDreDetalheGrouped>? contabilDreDetalheGroupedList; 

  ContabilDreCabecalhoGrouped({
		this.contabilDreCabecalho, 
		this.contabilDreDetalheGroupedList, 

  });
}
