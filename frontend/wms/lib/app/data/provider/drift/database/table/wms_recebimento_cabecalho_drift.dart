import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/provider/drift/database/database_imports.dart';

@DataClassName("WmsRecebimentoCabecalho")
class WmsRecebimentoCabecalhos extends Table {
	@override
	String get tableName => 'wms_recebimento_cabecalho';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idWmsAgendamento => integer().named('id_wms_agendamento').nullable()();
	DateTimeColumn get dataRecebimento => dateTime().named('data_recebimento').nullable()();
	TextColumn get horaInicio => text().named('hora_inicio').withLength(min: 0, max: 8).nullable()();
	TextColumn get horaFim => text().named('hora_fim').withLength(min: 0, max: 8).nullable()();
	IntColumn get volumeRecebido => integer().named('volume_recebido').nullable()();
	RealColumn get pesoRecebido => real().named('peso_recebido').nullable()();
	TextColumn get inconsistencia => text().named('inconsistencia').withLength(min: 0, max: 1).nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class WmsRecebimentoCabecalhoGrouped {
	WmsRecebimentoCabecalho? wmsRecebimentoCabecalho; 
	List<WmsRecebimentoDetalheGrouped>? wmsRecebimentoDetalheGroupedList; 
	WmsAgendamento? wmsAgendamento; 

  WmsRecebimentoCabecalhoGrouped({
		this.wmsRecebimentoCabecalho, 
		this.wmsRecebimentoDetalheGroupedList, 
		this.wmsAgendamento, 

  });
}
