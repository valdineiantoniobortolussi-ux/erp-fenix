import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("CstIcms")
class CstIcmss extends Table {
	@override
	String get tableName => 'cst_icms';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 2).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 250).nullable()();
	TextColumn get observacao => text().named('observacao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CstIcmsGrouped {
	CstIcms? cstIcms; 

  CstIcmsGrouped({
		this.cstIcms, 

  });
}
