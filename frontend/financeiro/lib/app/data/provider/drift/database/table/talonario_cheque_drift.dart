import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';

@DataClassName("TalonarioCheque")
class TalonarioCheques extends Table {
	@override
	String get tableName => 'talonario_cheque';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idBancoContaCaixa => integer().named('id_banco_conta_caixa').nullable()();
	TextColumn get talao => text().named('talao').withLength(min: 0, max: 10).nullable()();
	IntColumn get numero => integer().named('numero').nullable()();
	TextColumn get statusTalao => text().named('status_talao').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class TalonarioChequeGrouped {
	TalonarioCheque? talonarioCheque; 
	List<ChequeGrouped>? chequeGroupedList; 
	BancoContaCaixa? bancoContaCaixa; 

  TalonarioChequeGrouped({
		this.talonarioCheque, 
		this.chequeGroupedList, 
		this.bancoContaCaixa, 

  });
}
