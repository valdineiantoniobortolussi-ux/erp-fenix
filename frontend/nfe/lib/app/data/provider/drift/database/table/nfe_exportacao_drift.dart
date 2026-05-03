import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeExportacao")
class NfeExportacaos extends Table {
	@override
	String get tableName => 'nfe_exportacao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeDetalhe => integer().named('id_nfe_detalhe').nullable()();
	IntColumn get drawback => integer().named('drawback').nullable()();
	IntColumn get numeroRegistro => integer().named('numero_registro').nullable()();
	TextColumn get chaveAcesso => text().named('chave_acesso').withLength(min: 0, max: 44).nullable()();
	RealColumn get quantidade => real().named('quantidade').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeExportacaoGrouped {
	NfeExportacao? nfeExportacao; 

  NfeExportacaoGrouped({
		this.nfeExportacao, 

  });
}
