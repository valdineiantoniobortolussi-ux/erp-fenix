import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeDetEspecificoVeiculo")
class NfeDetEspecificoVeiculos extends Table {
	@override
	String get tableName => 'nfe_det_especifico_veiculo';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeDetalhe => integer().named('id_nfe_detalhe').nullable()();
	TextColumn get tipoOperacao => text().named('tipo_operacao').withLength(min: 0, max: 1).nullable()();
	TextColumn get chassi => text().named('chassi').withLength(min: 0, max: 17).nullable()();
	TextColumn get cor => text().named('cor').withLength(min: 0, max: 4).nullable()();
	TextColumn get descricaoCor => text().named('descricao_cor').withLength(min: 0, max: 40).nullable()();
	TextColumn get potenciaMotor => text().named('potencia_motor').withLength(min: 0, max: 4).nullable()();
	TextColumn get cilindradas => text().named('cilindradas').withLength(min: 0, max: 4).nullable()();
	TextColumn get pesoLiquido => text().named('peso_liquido').withLength(min: 0, max: 9).nullable()();
	TextColumn get pesoBruto => text().named('peso_bruto').withLength(min: 0, max: 9).nullable()();
	TextColumn get numeroSerie => text().named('numero_serie').withLength(min: 0, max: 9).nullable()();
	TextColumn get tipoCombustivel => text().named('tipo_combustivel').withLength(min: 0, max: 2).nullable()();
	TextColumn get numeroMotor => text().named('numero_motor').withLength(min: 0, max: 21).nullable()();
	TextColumn get capacidadeMaximaTracao => text().named('capacidade_maxima_tracao').withLength(min: 0, max: 9).nullable()();
	TextColumn get distanciaEixos => text().named('distancia_eixos').withLength(min: 0, max: 4).nullable()();
	TextColumn get anoModelo => text().named('ano_modelo').withLength(min: 0, max: 4).nullable()();
	TextColumn get anoFabricacao => text().named('ano_fabricacao').withLength(min: 0, max: 4).nullable()();
	TextColumn get tipoPintura => text().named('tipo_pintura').withLength(min: 0, max: 1).nullable()();
	TextColumn get tipoVeiculo => text().named('tipo_veiculo').withLength(min: 0, max: 2).nullable()();
	TextColumn get especieVeiculo => text().named('especie_veiculo').withLength(min: 0, max: 1).nullable()();
	TextColumn get condicaoVin => text().named('condicao_vin').withLength(min: 0, max: 1).nullable()();
	TextColumn get condicaoVeiculo => text().named('condicao_veiculo').withLength(min: 0, max: 1).nullable()();
	TextColumn get codigoMarcaModelo => text().named('codigo_marca_modelo').withLength(min: 0, max: 6).nullable()();
	TextColumn get codigoCorDenatran => text().named('codigo_cor_denatran').withLength(min: 0, max: 2).nullable()();
	IntColumn get lotacaoMaxima => integer().named('lotacao_maxima').nullable()();
	TextColumn get restricao => text().named('restricao').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeDetEspecificoVeiculoGrouped {
	NfeDetEspecificoVeiculo? nfeDetEspecificoVeiculo; 

  NfeDetEspecificoVeiculoGrouped({
		this.nfeDetEspecificoVeiculo, 

  });
}
