import 'package:drift/drift.dart';
import 'package:pcp/app/data/provider/drift/database/database.dart';

@DataClassName("PcpServicoEquipamento")
class PcpServicoEquipamentos extends Table {
	@override
	String get tableName => 'pcp_servico_equipamento';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPcpServico => integer().named('id_pcp_servico').nullable()();
	IntColumn get idPatrimBem => integer().named('id_patrim_bem').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PcpServicoEquipamentoGrouped {
	PcpServicoEquipamento? pcpServicoEquipamento; 
	PatrimBem? patrimBem; 

  PcpServicoEquipamentoGrouped({
		this.pcpServicoEquipamento, 
		this.patrimBem, 

  });
}
