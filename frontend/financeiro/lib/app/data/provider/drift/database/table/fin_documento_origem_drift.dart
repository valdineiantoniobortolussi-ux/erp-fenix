import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';

@DataClassName("FinDocumentoOrigem")
class FinDocumentoOrigems extends Table {
	@override
	String get tableName => 'fin_documento_origem';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 3).nullable()();
	TextColumn get sigla => text().named('sigla').withLength(min: 0, max: 10).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FinDocumentoOrigemGrouped {
	FinDocumentoOrigem? finDocumentoOrigem; 

  FinDocumentoOrigemGrouped({
		this.finDocumentoOrigem, 

  });
}
