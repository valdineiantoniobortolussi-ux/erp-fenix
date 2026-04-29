import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';

@DataClassName("WmsAgendamento")
class WmsAgendamentos extends Table {
	@override
	String get tableName => 'wms_agendamento';

	IntColumn get id => integer().named('id').nullable()();
	DateTimeColumn get dataOperacao => dateTime().named('data_operacao').nullable()();
	TextColumn get horaOperacao => text().named('hora_operacao').withLength(min: 0, max: 8).nullable()();
	TextColumn get localOperacao => text().named('local_operacao').withLength(min: 0, max: 100).nullable()();
	IntColumn get quantidadeVolume => integer().named('quantidade_volume').nullable()();
	RealColumn get pesoTotalVolume => real().named('peso_total_volume').nullable()();
	IntColumn get quantidadePessoa => integer().named('quantidade_pessoa').nullable()();
	IntColumn get quantidadeHora => integer().named('quantidade_hora').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class WmsAgendamentoGrouped {
	WmsAgendamento? wmsAgendamento; 

  WmsAgendamentoGrouped({
		this.wmsAgendamento, 

  });
}
