import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';

@DataClassName("FinChequeRecebido")
class FinChequeRecebidos extends Table {
	@override
	String get tableName => 'fin_cheque_recebido';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCliente => integer().named('id_cliente').nullable()();
	TextColumn get cpf => text().named('cpf').withLength(min: 0, max: 11).nullable()();
	TextColumn get cnpj => text().named('cnpj').withLength(min: 0, max: 14).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get codigoBanco => text().named('codigo_banco').withLength(min: 0, max: 10).nullable()();
	TextColumn get codigoAgencia => text().named('codigo_agencia').withLength(min: 0, max: 10).nullable()();
	TextColumn get conta => text().named('conta').withLength(min: 0, max: 20).nullable()();
	IntColumn get numero => integer().named('numero').nullable()();
	DateTimeColumn get dataEmissao => dateTime().named('data_emissao').nullable()();
	DateTimeColumn get bomPara => dateTime().named('bom_para').nullable()();
	DateTimeColumn get dataCompensacao => dateTime().named('data_compensacao').nullable()();
	RealColumn get valor => real().named('valor').nullable()();
	DateTimeColumn get custodiaData => dateTime().named('custodia_data').nullable()();
	RealColumn get custodiaTarifa => real().named('custodia_tarifa').nullable()();
	RealColumn get custodiaComissao => real().named('custodia_comissao').nullable()();
	DateTimeColumn get descontoData => dateTime().named('desconto_data').nullable()();
	RealColumn get descontoTarifa => real().named('desconto_tarifa').nullable()();
	RealColumn get descontoComissao => real().named('desconto_comissao').nullable()();
	RealColumn get valorRecebido => real().named('valor_recebido').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FinChequeRecebidoGrouped {
	FinChequeRecebido? finChequeRecebido; 
	ViewPessoaCliente? viewPessoaCliente; 

  FinChequeRecebidoGrouped({
		this.finChequeRecebido, 
		this.viewPessoaCliente, 

  });
}
