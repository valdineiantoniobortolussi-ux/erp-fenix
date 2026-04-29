import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeDetEspecificoArmamento")
class NfeDetEspecificoArmamentos extends Table {
	@override
	String get tableName => 'nfe_det_especifico_armamento';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeDetalhe => integer().named('id_nfe_detalhe').nullable()();
	TextColumn get tipoArma => text().named('tipo_arma').withLength(min: 0, max: 1).nullable()();
	TextColumn get numeroSerieArma => text().named('numero_serie_arma').withLength(min: 0, max: 15).nullable()();
	TextColumn get numeroSerieCano => text().named('numero_serie_cano').withLength(min: 0, max: 15).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeDetEspecificoArmamentoGrouped {
	NfeDetEspecificoArmamento? nfeDetEspecificoArmamento; 

  NfeDetEspecificoArmamentoGrouped({
		this.nfeDetEspecificoArmamento, 

  });
}
