import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';

@DataClassName("FinParcelaPagar")
class FinParcelaPagars extends Table {
	@override
	String get tableName => 'fin_parcela_pagar';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFinLancamentoPagar => integer().named('id_fin_lancamento_pagar').nullable()();
	IntColumn get idFinChequeEmitido => integer().named('id_fin_cheque_emitido').nullable()();
	IntColumn get idFinStatusParcela => integer().named('id_fin_status_parcela').nullable()();
	IntColumn get idFinTipoPagamento => integer().named('id_fin_tipo_pagamento').nullable()();
	IntColumn get numeroParcela => integer().named('numero_parcela').nullable()();
	DateTimeColumn get dataEmissao => dateTime().named('data_emissao').nullable()();
	DateTimeColumn get dataVencimento => dateTime().named('data_vencimento').nullable()();
	DateTimeColumn get dataPagamento => dateTime().named('data_pagamento').nullable()();
	DateTimeColumn get descontoAte => dateTime().named('desconto_ate').nullable()();
	RealColumn get valor => real().named('valor').nullable()();
	RealColumn get taxaJuro => real().named('taxa_juro').nullable()();
	RealColumn get taxaMulta => real().named('taxa_multa').nullable()();
	RealColumn get taxaDesconto => real().named('taxa_desconto').nullable()();
	RealColumn get valorJuro => real().named('valor_juro').nullable()();
	RealColumn get valorMulta => real().named('valor_multa').nullable()();
	RealColumn get valorDesconto => real().named('valor_desconto').nullable()();
	RealColumn get valorPago => real().named('valor_pago').nullable()();
	TextColumn get historico => text().named('historico').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FinParcelaPagarGrouped {
	FinParcelaPagar? finParcelaPagar; 
	FinStatusParcela? finStatusParcela; 
	FinTipoPagamento? finTipoPagamento; 

  FinParcelaPagarGrouped({
		this.finParcelaPagar, 
		this.finStatusParcela, 
		this.finTipoPagamento, 

  });
}
