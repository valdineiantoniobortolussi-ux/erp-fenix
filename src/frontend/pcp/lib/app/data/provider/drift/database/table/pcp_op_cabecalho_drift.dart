import 'package:drift/drift.dart';
import 'package:pcp/app/data/provider/drift/database/database.dart';
import 'package:pcp/app/data/provider/drift/database/database_imports.dart';

@DataClassName("PcpOpCabecalho")
class PcpOpCabecalhos extends Table {
	@override
	String get tableName => 'pcp_op_cabecalho';

	IntColumn get id => integer().named('id').nullable()();
	DateTimeColumn get dataInicio => dateTime().named('data_inicio').nullable()();
	DateTimeColumn get dataPrevisaoEntrega => dateTime().named('data_previsao_entrega').nullable()();
	DateTimeColumn get dataTermino => dateTime().named('data_termino').nullable()();
	RealColumn get custoTotalPrevisto => real().named('custo_total_previsto').nullable()();
	RealColumn get custoTotalRealizado => real().named('custo_total_realizado').nullable()();
	RealColumn get porcentoVenda => real().named('porcento_venda').nullable()();
	RealColumn get porcentoEstoque => real().named('porcento_estoque').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PcpOpCabecalhoGrouped {
	PcpOpCabecalho? pcpOpCabecalho; 
	List<PcpOpDetalheGrouped>? pcpOpDetalheGroupedList; 
	List<PcpInstrucaoOpGrouped>? pcpInstrucaoOpGroupedList; 

  PcpOpCabecalhoGrouped({
		this.pcpOpCabecalho, 
		this.pcpOpDetalheGroupedList, 
		this.pcpInstrucaoOpGroupedList, 

  });
}
