import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';

@DataClassName("FiscalNotaFiscalEntrada")
class FiscalNotaFiscalEntradas extends Table {
	@override
	String get tableName => 'fiscal_nota_fiscal_entrada';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeCabecalho => integer().named('id_nfe_cabecalho').nullable()();
	TextColumn get competencia => text().named('competencia').withLength(min: 0, max: 7).nullable()();
	IntColumn get cfopEntrada => integer().named('cfop_entrada').nullable()();
	RealColumn get valorRateioFrete => real().named('valor_rateio_frete').nullable()();
	RealColumn get valorCustoMedio => real().named('valor_custo_medio').nullable()();
	RealColumn get valorIcmsAntecipado => real().named('valor_icms_antecipado').nullable()();
	RealColumn get valorBcIcmsAntecipado => real().named('valor_bc_icms_antecipado').nullable()();
	RealColumn get valorBcIcmsCreditado => real().named('valor_bc_icms_creditado').nullable()();
	RealColumn get valorBcPisCreditado => real().named('valor_bc_pis_creditado').nullable()();
	RealColumn get valorBcCofinsCreditado => real().named('valor_bc_cofins_creditado').nullable()();
	RealColumn get valorBcIpiCreditado => real().named('valor_bc_ipi_creditado').nullable()();
	TextColumn get cstCreditoIcms => text().named('cst_credito_icms').withLength(min: 0, max: 3).nullable()();
	TextColumn get cstCreditoPis => text().named('cst_credito_pis').withLength(min: 0, max: 2).nullable()();
	TextColumn get cstCreditoCofins => text().named('cst_credito_cofins').withLength(min: 0, max: 2).nullable()();
	TextColumn get cstCreditoIpi => text().named('cst_credito_ipi').withLength(min: 0, max: 2).nullable()();
	RealColumn get valorIcmsCreditado => real().named('valor_icms_creditado').nullable()();
	RealColumn get valorPisCreditado => real().named('valor_pis_creditado').nullable()();
	RealColumn get valorCofinsCreditado => real().named('valor_cofins_creditado').nullable()();
	RealColumn get valorIpiCreditado => real().named('valor_ipi_creditado').nullable()();
	IntColumn get qtdeParcelaCreditoPis => integer().named('qtde_parcela_credito_pis').nullable()();
	IntColumn get qtdeParcelaCreditoCofins => integer().named('qtde_parcela_credito_cofins').nullable()();
	IntColumn get qtdeParcelaCreditoIcms => integer().named('qtde_parcela_credito_icms').nullable()();
	IntColumn get qtdeParcelaCreditoIpi => integer().named('qtde_parcela_credito_ipi').nullable()();
	RealColumn get aliquotaCreditoIcms => real().named('aliquota_credito_icms').nullable()();
	RealColumn get aliquotaCreditoPis => real().named('aliquota_credito_pis').nullable()();
	RealColumn get aliquotaCreditoCofins => real().named('aliquota_credito_cofins').nullable()();
	RealColumn get aliquotaCreditoIpi => real().named('aliquota_credito_ipi').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FiscalNotaFiscalEntradaGrouped {
	FiscalNotaFiscalEntrada? fiscalNotaFiscalEntrada; 
	NfeCabecalho? nfeCabecalho; 

  FiscalNotaFiscalEntradaGrouped({
		this.fiscalNotaFiscalEntrada, 
		this.nfeCabecalho, 

  });
}
