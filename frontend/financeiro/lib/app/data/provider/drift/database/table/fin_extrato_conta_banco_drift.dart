import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';

@DataClassName("FinExtratoContaBanco")
class FinExtratoContaBancos extends Table {
	@override
	String get tableName => 'fin_extrato_conta_banco';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idBancoContaCaixa => integer().named('id_banco_conta_caixa').nullable()();
	TextColumn get mesAno => text().named('mes_ano').withLength(min: 0, max: 7).nullable()();
	TextColumn get mes => text().named('mes').withLength(min: 0, max: 2).nullable()();
	TextColumn get ano => text().named('ano').withLength(min: 0, max: 4).nullable()();
	DateTimeColumn get dataMovimento => dateTime().named('data_movimento').nullable()();
	DateTimeColumn get dataBalancete => dateTime().named('data_balancete').nullable()();
	TextColumn get historico => text().named('historico').withLength(min: 0, max: 250).nullable()();
	TextColumn get documento => text().named('documento').withLength(min: 0, max: 50).nullable()();
	RealColumn get valor => real().named('valor').nullable()();
	TextColumn get conciliado => text().named('conciliado').withLength(min: 0, max: 1).nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FinExtratoContaBancoGrouped {
	FinExtratoContaBanco? finExtratoContaBanco; 
	BancoContaCaixa? bancoContaCaixa; 

  FinExtratoContaBancoGrouped({
		this.finExtratoContaBanco, 
		this.bancoContaCaixa, 

  });
}
