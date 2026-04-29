import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeCupomFiscalReferenciado")
class NfeCupomFiscalReferenciados extends Table {
	@override
	String get tableName => 'nfe_cupom_fiscal_referenciado';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeCabecalho => integer().named('id_nfe_cabecalho').nullable()();
	TextColumn get modeloDocumentoFiscal => text().named('modelo_documento_fiscal').withLength(min: 0, max: 2).nullable()();
	IntColumn get numeroOrdemEcf => integer().named('numero_ordem_ecf').nullable()();
	IntColumn get coo => integer().named('coo').nullable()();
	DateTimeColumn get dataEmissaoCupom => dateTime().named('data_emissao_cupom').nullable()();
	IntColumn get numeroCaixa => integer().named('numero_caixa').nullable()();
	TextColumn get numeroSerieEcf => text().named('numero_serie_ecf').withLength(min: 0, max: 21).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeCupomFiscalReferenciadoGrouped {
	NfeCupomFiscalReferenciado? nfeCupomFiscalReferenciado; 

  NfeCupomFiscalReferenciadoGrouped({
		this.nfeCupomFiscalReferenciado, 

  });
}
