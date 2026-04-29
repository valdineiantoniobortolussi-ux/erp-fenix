import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/provider/drift/database/database_imports.dart';

@DataClassName("WmsOrdemSeparacaoCab")
class WmsOrdemSeparacaoCabs extends Table {
	@override
	String get tableName => 'wms_ordem_separacao_cab';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get origem => text().named('origem').withLength(min: 0, max: 1).nullable()();
	DateTimeColumn get dataSolicitacao => dateTime().named('data_solicitacao').nullable()();
	DateTimeColumn get dataLimite => dateTime().named('data_limite').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class WmsOrdemSeparacaoCabGrouped {
	WmsOrdemSeparacaoCab? wmsOrdemSeparacaoCab; 
	List<WmsOrdemSeparacaoDetGrouped>? wmsOrdemSeparacaoDetGroupedList; 

  WmsOrdemSeparacaoCabGrouped({
		this.wmsOrdemSeparacaoCab, 
		this.wmsOrdemSeparacaoDetGroupedList, 

  });
}
