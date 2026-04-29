import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';

@DataClassName("FiscalInscricoesSubstitutas")
class FiscalInscricoesSubstitutass extends Table {
	@override
	String get tableName => 'fiscal_inscricoes_substitutas';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFiscalParametros => integer().named('id_fiscal_parametros').nullable()();
	TextColumn get uf => text().named('uf').withLength(min: 0, max: 2).nullable()();
	TextColumn get inscricaoEstadual => text().named('inscricao_estadual').withLength(min: 0, max: 30).nullable()();
	TextColumn get pmpf => text().named('pmpf').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FiscalInscricoesSubstitutasGrouped {
	FiscalInscricoesSubstitutas? fiscalInscricoesSubstitutas; 

  FiscalInscricoesSubstitutasGrouped({
		this.fiscalInscricoesSubstitutas, 

  });
}
