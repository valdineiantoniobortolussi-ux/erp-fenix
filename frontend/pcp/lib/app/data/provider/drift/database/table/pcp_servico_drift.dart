import 'package:drift/drift.dart';
import 'package:pcp/app/data/provider/drift/database/database.dart';
import 'package:pcp/app/data/provider/drift/database/database_imports.dart';

@DataClassName("PcpServico")
class PcpServicos extends Table {
	@override
	String get tableName => 'pcp_servico';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPcpOpDetalhe => integer().named('id_pcp_op_detalhe').nullable()();
	DateTimeColumn get inicioPrevisto => dateTime().named('inicio_previsto').nullable()();
	DateTimeColumn get terminoPrevisto => dateTime().named('termino_previsto').nullable()();
	IntColumn get horasPrevisto => integer().named('horas_previsto').nullable()();
	IntColumn get minutosPrevisto => integer().named('minutos_previsto').nullable()();
	IntColumn get segundosPrevisto => integer().named('segundos_previsto').nullable()();
	RealColumn get custoPrevisto => real().named('custo_previsto').nullable()();
	DateTimeColumn get inicioRealizado => dateTime().named('inicio_realizado').nullable()();
	DateTimeColumn get terminoRealizado => dateTime().named('termino_realizado').nullable()();
	IntColumn get horasRealizado => integer().named('horas_realizado').nullable()();
	IntColumn get minutosRealizado => integer().named('minutos_realizado').nullable()();
	IntColumn get segundosRealizado => integer().named('segundos_realizado').nullable()();
	RealColumn get custoRealizado => real().named('custo_realizado').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PcpServicoGrouped {
	PcpServico? pcpServico; 
	List<PcpServicoColaboradorGrouped>? pcpServicoColaboradorGroupedList; 
	List<PcpServicoEquipamentoGrouped>? pcpServicoEquipamentoGroupedList; 
	PcpOpDetalhe? pcpOpDetalhe; 

  PcpServicoGrouped({
		this.pcpServico, 
		this.pcpServicoColaboradorGroupedList, 
		this.pcpServicoEquipamentoGroupedList, 
		this.pcpOpDetalhe, 

  });
}
