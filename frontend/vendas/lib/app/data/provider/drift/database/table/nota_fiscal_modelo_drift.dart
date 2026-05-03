import 'package:drift/drift.dart';
import 'package:vendas/app/data/provider/drift/database/database.dart';

@DataClassName("NotaFiscalModelo")
class NotaFiscalModelos extends Table {
	@override
	String get tableName => 'nota_fiscal_modelo';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 2).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();
	TextColumn get modelo => text().named('modelo').withLength(min: 0, max: 10).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NotaFiscalModeloGrouped {
	NotaFiscalModelo? notaFiscalModelo; 

  NotaFiscalModeloGrouped({
		this.notaFiscalModelo, 

  });
}
