import 'package:drift/drift.dart';
import 'package:pcp/app/data/provider/drift/database/database.dart';

@DataClassName("PcpServicoColaborador")
class PcpServicoColaboradors extends Table {
	@override
	String get tableName => 'pcp_servico_colaborador';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	IntColumn get idPcpServico => integer().named('id_pcp_servico').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PcpServicoColaboradorGrouped {
	PcpServicoColaborador? pcpServicoColaborador; 
	ViewPessoaColaborador? viewPessoaColaborador; 

  PcpServicoColaboradorGrouped({
		this.pcpServicoColaborador, 
		this.viewPessoaColaborador, 

  });
}
