import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';

@DataClassName("FinParcelaReceber")
class FinParcelaRecebers extends Table {
	@override
	String get tableName => 'fin_parcela_receber';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFinLancamentoReceber => integer().named('id_fin_lancamento_receber').nullable()();
	IntColumn get idFinChequeRecebido => integer().named('id_fin_cheque_recebido').nullable()();
	IntColumn get idFinStatusParcela => integer().named('id_fin_status_parcela').nullable()();
	IntColumn get idFinTipoRecebimento => integer().named('id_fin_tipo_recebimento').nullable()();
	IntColumn get numeroParcela => integer().named('numero_parcela').nullable()();
	DateTimeColumn get dataEmissao => dateTime().named('data_emissao').nullable()();
	DateTimeColumn get dataVencimento => dateTime().named('data_vencimento').nullable()();
	DateTimeColumn get dataRecebimento => dateTime().named('data_recebimento').nullable()();
	DateTimeColumn get descontoAte => dateTime().named('desconto_ate').nullable()();
	RealColumn get valor => real().named('valor').nullable()();
	RealColumn get taxaJuro => real().named('taxa_juro').nullable()();
	RealColumn get taxaMulta => real().named('taxa_multa').nullable()();
	RealColumn get taxaDesconto => real().named('taxa_desconto').nullable()();
	RealColumn get valorJuro => real().named('valor_juro').nullable()();
	RealColumn get valorMulta => real().named('valor_multa').nullable()();
	RealColumn get valorDesconto => real().named('valor_desconto').nullable()();
	TextColumn get emitiuBoleto => text().named('emitiu_boleto').withLength(min: 0, max: 1).nullable()();
	TextColumn get boletoNossoNumero => text().named('boleto_nosso_numero').withLength(min: 0, max: 50).nullable()();
	RealColumn get valorRecebido => real().named('valor_recebido').nullable()();
	TextColumn get historico => text().named('historico').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FinParcelaReceberGrouped {
	FinParcelaReceber? finParcelaReceber; 
	FinStatusParcela? finStatusParcela; 
	FinTipoRecebimento? finTipoRecebimento; 

  FinParcelaReceberGrouped({
		this.finParcelaReceber, 
		this.finStatusParcela, 
		this.finTipoRecebimento, 

  });
}
