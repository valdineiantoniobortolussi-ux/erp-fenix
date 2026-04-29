import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("ContabilEncerramentoExeDet")
class ContabilEncerramentoExeDets extends Table {
	@override
	String get tableName => 'contabil_encerramento_exe_det';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idContabilEncerramentoExe => integer().named('id_contabil_encerramento_exe').nullable()();
	IntColumn get idContabilConta => integer().named('id_contabil_conta').nullable()();
	RealColumn get saldoAnterior => real().named('saldo_anterior').nullable()();
	RealColumn get valorDebito => real().named('valor_debito').nullable()();
	RealColumn get valorCredito => real().named('valor_credito').nullable()();
	RealColumn get saldo => real().named('saldo').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContabilEncerramentoExeDetGrouped {
	ContabilEncerramentoExeDet? contabilEncerramentoExeDet; 
	ContabilConta? contabilConta; 

  ContabilEncerramentoExeDetGrouped({
		this.contabilEncerramentoExeDet, 
		this.contabilConta, 

  });
}
