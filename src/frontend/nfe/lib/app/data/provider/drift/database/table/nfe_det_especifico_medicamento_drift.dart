import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeDetEspecificoMedicamento")
class NfeDetEspecificoMedicamentos extends Table {
	@override
	String get tableName => 'nfe_det_especifico_medicamento';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeDetalhe => integer().named('id_nfe_detalhe').nullable()();
	TextColumn get codigoAnvisa => text().named('codigo_anvisa').withLength(min: 0, max: 13).nullable()();
	TextColumn get motivoIsencao => text().named('motivo_isencao').withLength(min: 0, max: 250).nullable()();
	RealColumn get precoMaximoConsumidor => real().named('preco_maximo_consumidor').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeDetEspecificoMedicamentoGrouped {
	NfeDetEspecificoMedicamento? nfeDetEspecificoMedicamento; 

  NfeDetEspecificoMedicamentoGrouped({
		this.nfeDetEspecificoMedicamento, 

  });
}
