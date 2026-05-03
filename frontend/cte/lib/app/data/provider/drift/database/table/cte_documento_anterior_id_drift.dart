import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteDocumentoAnteriorId")
class CteDocumentoAnteriorIds extends Table {
	@override
	String get tableName => 'cte_documento_anterior_id';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteDocumentoAnterior => integer().named('id_cte_documento_anterior').nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 2).nullable()();
	TextColumn get serie => text().named('serie').withLength(min: 0, max: 3).nullable()();
	TextColumn get subserie => text().named('subserie').withLength(min: 0, max: 2).nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 20).nullable()();
	DateTimeColumn get dataEmissao => dateTime().named('data_emissao').nullable()();
	TextColumn get chaveCte => text().named('chave_cte').withLength(min: 0, max: 44).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteDocumentoAnteriorIdGrouped {
	CteDocumentoAnteriorId? cteDocumentoAnteriorId; 

  CteDocumentoAnteriorIdGrouped({
		this.cteDocumentoAnteriorId, 

  });
}
