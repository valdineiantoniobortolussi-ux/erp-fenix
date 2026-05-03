import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

@DataClassName("EmpresaTransporte")
class EmpresaTransportes extends Table {
	@override
	String get tableName => 'empresa_transporte';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get uf => text().named('uf').withLength(min: 0, max: 2).nullable()();
	TextColumn get classificacaoContabilConta => text().named('classificacao_contabil_conta').withLength(min: 0, max: 30).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EmpresaTransporteGrouped {
	EmpresaTransporte? empresaTransporte; 
	List<EmpresaTransporteItinerarioGrouped>? empresaTransporteItinerarioGroupedList; 

  EmpresaTransporteGrouped({
		this.empresaTransporte, 
		this.empresaTransporteItinerarioGroupedList, 

  });
}
