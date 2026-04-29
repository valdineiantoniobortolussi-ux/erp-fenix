import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';

@DataClassName("FinFechamentoCaixaBanco")
class FinFechamentoCaixaBancos extends Table {
	@override
	String get tableName => 'fin_fechamento_caixa_banco';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idBancoContaCaixa => integer().named('id_banco_conta_caixa').nullable()();
	DateTimeColumn get dataFechamento => dateTime().named('data_fechamento').nullable()();
	TextColumn get mesAno => text().named('mes_ano').withLength(min: 0, max: 7).nullable()();
	TextColumn get mes => text().named('mes').withLength(min: 0, max: 2).nullable()();
	TextColumn get ano => text().named('ano').withLength(min: 0, max: 4).nullable()();
	RealColumn get saldoAnterior => real().named('saldo_anterior').nullable()();
	RealColumn get recebimentos => real().named('recebimentos').nullable()();
	RealColumn get pagamentos => real().named('pagamentos').nullable()();
	RealColumn get saldoConta => real().named('saldo_conta').nullable()();
	RealColumn get chequeNaoCompensado => real().named('cheque_nao_compensado').nullable()();
	RealColumn get saldoDisponivel => real().named('saldo_disponivel').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FinFechamentoCaixaBancoGrouped {
	FinFechamentoCaixaBanco? finFechamentoCaixaBanco; 
	BancoContaCaixa? bancoContaCaixa; 

  FinFechamentoCaixaBancoGrouped({
		this.finFechamentoCaixaBanco, 
		this.bancoContaCaixa, 

  });
}
