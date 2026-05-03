import 'package:drift/drift.dart';
import 'package:pcp/app/data/provider/drift/database/database.dart';

@DataClassName("PcpInstrucao")
class PcpInstrucaos extends Table {
	@override
	String get tableName => 'pcp_instrucao';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 3).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PcpInstrucaoGrouped {
	PcpInstrucao? pcpInstrucao; 

  PcpInstrucaoGrouped({
		this.pcpInstrucao, 

  });
}
