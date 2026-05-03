import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("Sindicato")
class Sindicatos extends Table {
	@override
	String get tableName => 'sindicato';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	IntColumn get codigoBanco => integer().named('codigo_banco').nullable()();
	IntColumn get codigoAgencia => integer().named('codigo_agencia').nullable()();
	TextColumn get contaBanco => text().named('conta_banco').withLength(min: 0, max: 20).nullable()();
	TextColumn get codigoCedente => text().named('codigo_cedente').withLength(min: 0, max: 30).nullable()();
	TextColumn get logradouro => text().named('logradouro').withLength(min: 0, max: 100).nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 10).nullable()();
	TextColumn get bairro => text().named('bairro').withLength(min: 0, max: 100).nullable()();
	IntColumn get municipioIbge => integer().named('municipio_ibge').nullable()();
	TextColumn get uf => text().named('uf').withLength(min: 0, max: 2).nullable()();
	TextColumn get fone1 => text().named('fone1').withLength(min: 0, max: 14).nullable()();
	TextColumn get fone2 => text().named('fone2').withLength(min: 0, max: 14).nullable()();
	TextColumn get email => text().named('email').withLength(min: 0, max: 100).nullable()();
	TextColumn get tipoSindicato => text().named('tipo_sindicato').withLength(min: 0, max: 1).nullable()();
	DateTimeColumn get dataBase => dateTime().named('data_base').nullable()();
	RealColumn get pisoSalarial => real().named('piso_salarial').nullable()();
	TextColumn get cnpj => text().named('cnpj').withLength(min: 0, max: 14).nullable()();
	TextColumn get classificacaoContabilConta => text().named('classificacao_contabil_conta').withLength(min: 0, max: 30).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class SindicatoGrouped {
	Sindicato? sindicato; 

  SindicatoGrouped({
		this.sindicato, 

  });
}
