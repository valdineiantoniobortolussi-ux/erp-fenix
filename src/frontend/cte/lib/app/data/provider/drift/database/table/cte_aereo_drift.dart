import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteAereo")
class CteAereos extends Table {
	@override
	String get tableName => 'cte_aereo';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteCabecalho => integer().named('id_cte_cabecalho').nullable()();
	IntColumn get numeroMinuta => integer().named('numero_minuta').nullable()();
	IntColumn get numeroConhecimento => integer().named('numero_conhecimento').nullable()();
	DateTimeColumn get dataPrevistaEntrega => dateTime().named('data_prevista_entrega').nullable()();
	TextColumn get idEmissor => text().named('id_emissor').withLength(min: 0, max: 20).nullable()();
	TextColumn get idInternaTomador => text().named('id_interna_tomador').withLength(min: 0, max: 14).nullable()();
	TextColumn get tarifaClasse => text().named('tarifa_classe').withLength(min: 0, max: 1).nullable()();
	TextColumn get tarifaCodigo => text().named('tarifa_codigo').withLength(min: 0, max: 4).nullable()();
	RealColumn get tarifaValor => real().named('tarifa_valor').nullable()();
	TextColumn get cargaDimensao => text().named('carga_dimensao').withLength(min: 0, max: 14).nullable()();
	TextColumn get cargaInformacaoManuseio => text().named('carga_informacao_manuseio').withLength(min: 0, max: 1).nullable()();
	TextColumn get cargaEspecial => text().named('carga_especial').withLength(min: 0, max: 3).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteAereoGrouped {
	CteAereo? cteAereo; 

  CteAereoGrouped({
		this.cteAereo, 

  });
}
