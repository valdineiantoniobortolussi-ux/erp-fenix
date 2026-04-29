import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeInformacaoPagamento")
class NfeInformacaoPagamentos extends Table {
	@override
	String get tableName => 'nfe_informacao_pagamento';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeCabecalho => integer().named('id_nfe_cabecalho').nullable()();
	TextColumn get indicadorPagamento => text().named('indicador_pagamento').withLength(min: 0, max: 1).nullable()();
	TextColumn get meioPagamento => text().named('meio_pagamento').withLength(min: 0, max: 2).nullable()();
	RealColumn get valor => real().named('valor').nullable()();
	TextColumn get tipoIntegracao => text().named('tipo_integracao').withLength(min: 0, max: 1).nullable()();
	TextColumn get cnpjOperadoraCartao => text().named('cnpj_operadora_cartao').withLength(min: 0, max: 14).nullable()();
	TextColumn get bandeira => text().named('bandeira').withLength(min: 0, max: 2).nullable()();
	TextColumn get numeroAutorizacao => text().named('numero_autorizacao').withLength(min: 0, max: 20).nullable()();
	RealColumn get troco => real().named('troco').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeInformacaoPagamentoGrouped {
	NfeInformacaoPagamento? nfeInformacaoPagamento; 

  NfeInformacaoPagamentoGrouped({
		this.nfeInformacaoPagamento, 

  });
}
