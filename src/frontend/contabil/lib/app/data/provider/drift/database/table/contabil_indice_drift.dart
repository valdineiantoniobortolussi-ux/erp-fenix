import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

@DataClassName("ContabilIndice")
class ContabilIndices extends Table {
	@override
	String get tableName => 'contabil_indice';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get indice => text().named('indice').withLength(min: 0, max: 50).nullable()();
	TextColumn get periodicidade => text().named('periodicidade').withLength(min: 0, max: 1).nullable()();
	DateTimeColumn get diarioAPartirDe => dateTime().named('diario_a_partir_de').nullable()();
	TextColumn get mensalMesAno => text().named('mensal_mes_ano').withLength(min: 0, max: 7).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContabilIndiceGrouped {
	ContabilIndice? contabilIndice; 
	List<ContabilIndiceValorGrouped>? contabilIndiceValorGroupedList; 

  ContabilIndiceGrouped({
		this.contabilIndice, 
		this.contabilIndiceValorGroupedList, 

  });
}
