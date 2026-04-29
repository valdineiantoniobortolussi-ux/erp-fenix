import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';

@DataClassName("FiscalApuracaoIcms")
class FiscalApuracaoIcmss extends Table {
	@override
	String get tableName => 'fiscal_apuracao_icms';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get competencia => text().named('competencia').withLength(min: 0, max: 7).nullable()();
	RealColumn get valorTotalDebito => real().named('valor_total_debito').nullable()();
	RealColumn get valorAjusteDebito => real().named('valor_ajuste_debito').nullable()();
	RealColumn get valorTotalAjusteDebito => real().named('valor_total_ajuste_debito').nullable()();
	RealColumn get valorEstornoCredito => real().named('valor_estorno_credito').nullable()();
	RealColumn get valorTotalCredito => real().named('valor_total_credito').nullable()();
	RealColumn get valorAjusteCredito => real().named('valor_ajuste_credito').nullable()();
	RealColumn get valorTotalAjusteCredito => real().named('valor_total_ajuste_credito').nullable()();
	RealColumn get valorEstornoDebito => real().named('valor_estorno_debito').nullable()();
	RealColumn get valorSaldoCredorAnterior => real().named('valor_saldo_credor_anterior').nullable()();
	RealColumn get valorSaldoApurado => real().named('valor_saldo_apurado').nullable()();
	RealColumn get valorTotalDeducao => real().named('valor_total_deducao').nullable()();
	RealColumn get valorIcmsRecolher => real().named('valor_icms_recolher').nullable()();
	RealColumn get valorSaldoCredorTransp => real().named('valor_saldo_credor_transp').nullable()();
	RealColumn get valorDebitoEspecial => real().named('valor_debito_especial').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FiscalApuracaoIcmsGrouped {
	FiscalApuracaoIcms? fiscalApuracaoIcms; 

  FiscalApuracaoIcmsGrouped({
		this.fiscalApuracaoIcms, 

  });
}
