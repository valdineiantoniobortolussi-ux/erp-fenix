import 'package:drift/drift.dart';
import 'package:pcp/app/data/provider/drift/database/database.dart';

@DataClassName("PcpInstrucaoOp")
class PcpInstrucaoOps extends Table {
	@override
	String get tableName => 'pcp_instrucao_op';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPcpInstrucao => integer().named('id_pcp_instrucao').nullable()();
	IntColumn get idPcpOpCabecalho => integer().named('id_pcp_op_cabecalho').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PcpInstrucaoOpGrouped {
	PcpInstrucaoOp? pcpInstrucaoOp; 
	PcpInstrucao? pcpInstrucao; 

  PcpInstrucaoOpGrouped({
		this.pcpInstrucaoOp, 
		this.pcpInstrucao, 

  });
}
