import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeDetEspecificoCombustivel")
class NfeDetEspecificoCombustivels extends Table {
	@override
	String get tableName => 'nfe_det_especifico_combustivel';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeDetalhe => integer().named('id_nfe_detalhe').nullable()();
	IntColumn get codigoAnp => integer().named('codigo_anp').nullable()();
	TextColumn get descricaoAnp => text().named('descricao_anp').withLength(min: 0, max: 95).nullable()();
	RealColumn get percentualGlp => real().named('percentual_glp').nullable()();
	RealColumn get percentualGasNacional => real().named('percentual_gas_nacional').nullable()();
	RealColumn get percentualGasImportado => real().named('percentual_gas_importado').nullable()();
	RealColumn get valorPartida => real().named('valor_partida').nullable()();
	TextColumn get codif => text().named('codif').withLength(min: 0, max: 21).nullable()();
	RealColumn get quantidadeTempAmbiente => real().named('quantidade_temp_ambiente').nullable()();
	TextColumn get ufConsumo => text().named('uf_consumo').withLength(min: 0, max: 2).nullable()();
	RealColumn get cideBaseCalculo => real().named('cide_base_calculo').nullable()();
	RealColumn get cideAliquota => real().named('cide_aliquota').nullable()();
	RealColumn get cideValor => real().named('cide_valor').nullable()();
	IntColumn get encerranteBico => integer().named('encerrante_bico').nullable()();
	IntColumn get encerranteBomba => integer().named('encerrante_bomba').nullable()();
	IntColumn get encerranteTanque => integer().named('encerrante_tanque').nullable()();
	RealColumn get encerranteValorInicio => real().named('encerrante_valor_inicio').nullable()();
	RealColumn get encerranteValorFim => real().named('encerrante_valor_fim').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeDetEspecificoCombustivelGrouped {
	NfeDetEspecificoCombustivel? nfeDetEspecificoCombustivel; 

  NfeDetEspecificoCombustivelGrouped({
		this.nfeDetEspecificoCombustivel, 

  });
}
