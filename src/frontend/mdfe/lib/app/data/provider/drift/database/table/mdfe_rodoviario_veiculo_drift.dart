import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';

@DataClassName("MdfeRodoviarioVeiculo")
class MdfeRodoviarioVeiculos extends Table {
	@override
	String get tableName => 'mdfe_rodoviario_veiculo';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idMdfeRodoviario => integer().named('id_mdfe_rodoviario').nullable()();
	TextColumn get codigoInterno => text().named('codigo_interno').withLength(min: 0, max: 10).nullable()();
	TextColumn get placa => text().named('placa').withLength(min: 0, max: 7).nullable()();
	TextColumn get renavam => text().named('renavam').withLength(min: 0, max: 11).nullable()();
	IntColumn get tara => integer().named('tara').nullable()();
	IntColumn get capacidadeKg => integer().named('capacidade_kg').nullable()();
	IntColumn get capacidadeM3 => integer().named('capacidade_m3').nullable()();
	TextColumn get tipoRodado => text().named('tipo_rodado').withLength(min: 0, max: 2).nullable()();
	TextColumn get tipoCarroceria => text().named('tipo_carroceria').withLength(min: 0, max: 2).nullable()();
	TextColumn get ufLicenciamento => text().named('uf_licenciamento').withLength(min: 0, max: 2).nullable()();
	TextColumn get proprietarioCpf => text().named('proprietario_cpf').withLength(min: 0, max: 11).nullable()();
	TextColumn get proprietarioCnpj => text().named('proprietario_cnpj').withLength(min: 0, max: 14).nullable()();
	TextColumn get proprietarioRntrc => text().named('proprietario_rntrc').withLength(min: 0, max: 8).nullable()();
	TextColumn get proprietarioNome => text().named('proprietario_nome').withLength(min: 0, max: 60).nullable()();
	TextColumn get proprietarioIe => text().named('proprietario_ie').withLength(min: 0, max: 2).nullable()();
	IntColumn get proprietarioTipo => integer().named('proprietario_tipo').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class MdfeRodoviarioVeiculoGrouped {
	MdfeRodoviarioVeiculo? mdfeRodoviarioVeiculo; 
	MdfeRodoviario? mdfeRodoviario; 

  MdfeRodoviarioVeiculoGrouped({
		this.mdfeRodoviarioVeiculo, 
		this.mdfeRodoviario, 

  });
}
