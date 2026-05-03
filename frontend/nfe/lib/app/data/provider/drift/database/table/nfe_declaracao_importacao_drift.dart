import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeDeclaracaoImportacao")
class NfeDeclaracaoImportacaos extends Table {
	@override
	String get tableName => 'nfe_declaracao_importacao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeDetalhe => integer().named('id_nfe_detalhe').nullable()();
	TextColumn get numeroDocumento => text().named('numero_documento').withLength(min: 0, max: 12).nullable()();
	DateTimeColumn get dataRegistro => dateTime().named('data_registro').nullable()();
	TextColumn get localDesembaraco => text().named('local_desembaraco').withLength(min: 0, max: 60).nullable()();
	TextColumn get ufDesembaraco => text().named('uf_desembaraco').withLength(min: 0, max: 2).nullable()();
	DateTimeColumn get dataDesembaraco => dateTime().named('data_desembaraco').nullable()();
	TextColumn get viaTransporte => text().named('via_transporte').withLength(min: 0, max: 1).nullable()();
	RealColumn get valorAfrmm => real().named('valor_afrmm').nullable()();
	TextColumn get formaIntermediacao => text().named('forma_intermediacao').withLength(min: 0, max: 1).nullable()();
	TextColumn get cnpj => text().named('cnpj').withLength(min: 0, max: 14).nullable()();
	TextColumn get ufTerceiro => text().named('uf_terceiro').withLength(min: 0, max: 2).nullable()();
	TextColumn get codigoExportador => text().named('codigo_exportador').withLength(min: 0, max: 60).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeDeclaracaoImportacaoGrouped {
	NfeDeclaracaoImportacao? nfeDeclaracaoImportacao; 

  NfeDeclaracaoImportacaoGrouped({
		this.nfeDeclaracaoImportacao, 

  });
}
