import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';

@DataClassName("FiscalNotaFiscalSaida")
class FiscalNotaFiscalSaidas extends Table {
	@override
	String get tableName => 'fiscal_nota_fiscal_saida';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeCabecalho => integer().named('id_nfe_cabecalho').nullable()();
	TextColumn get competencia => text().named('competencia').withLength(min: 0, max: 7).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FiscalNotaFiscalSaidaGrouped {
	FiscalNotaFiscalSaida? fiscalNotaFiscalSaida; 
	NfeCabecalho? nfeCabecalho; 

  FiscalNotaFiscalSaidaGrouped({
		this.fiscalNotaFiscalSaida, 
		this.nfeCabecalho, 

  });
}
