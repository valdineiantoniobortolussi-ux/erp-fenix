import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/provider/drift/database/database_imports.dart';

@DataClassName("WmsCaixa")
class WmsCaixas extends Table {
	@override
	String get tableName => 'wms_caixa';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idWmsEstante => integer().named('id_wms_estante').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 10).nullable()();
	IntColumn get altura => integer().named('altura').nullable()();
	IntColumn get largura => integer().named('largura').nullable()();
	IntColumn get profundidade => integer().named('profundidade').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class WmsCaixaGrouped {
	WmsCaixa? wmsCaixa; 
	List<WmsArmazenamentoGrouped>? wmsArmazenamentoGroupedList; 
	WmsEstante? wmsEstante; 

  WmsCaixaGrouped({
		this.wmsCaixa, 
		this.wmsArmazenamentoGroupedList, 
		this.wmsEstante, 

  });
}
