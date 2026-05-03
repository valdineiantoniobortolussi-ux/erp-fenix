import 'package:drift/drift.dart';
import 'package:vendas/app/data/provider/drift/database/database.dart';

@DataClassName("NotaFiscalTipo")
class NotaFiscalTipos extends Table {
	@override
	String get tableName => 'nota_fiscal_tipo';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNotaFiscalModelo => integer().named('id_nota_fiscal_modelo').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();
	TextColumn get serie => text().named('serie').withLength(min: 0, max: 3).nullable()();
	TextColumn get serieScan => text().named('serie_scan').withLength(min: 0, max: 3).nullable()();
	IntColumn get ultimoNumero => integer().named('ultimo_numero').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NotaFiscalTipoGrouped {
	NotaFiscalTipo? notaFiscalTipo; 
	NotaFiscalModelo? notaFiscalModelo; 

  NotaFiscalTipoGrouped({
		this.notaFiscalTipo, 
		this.notaFiscalModelo, 

  });
}
