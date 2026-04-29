import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeResponsavelTecnico")
class NfeResponsavelTecnicos extends Table {
	@override
	String get tableName => 'nfe_responsavel_tecnico';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeCabecalho => integer().named('id_nfe_cabecalho').nullable()();
	TextColumn get cnpj => text().named('cnpj').withLength(min: 0, max: 14).nullable()();
	TextColumn get contato => text().named('contato').withLength(min: 0, max: 60).nullable()();
	TextColumn get email => text().named('email').withLength(min: 0, max: 60).nullable()();
	TextColumn get telefone => text().named('telefone').withLength(min: 0, max: 14).nullable()();
	TextColumn get identificadorCsrt => text().named('identificador_csrt').withLength(min: 0, max: 2).nullable()();
	TextColumn get hashCsrt => text().named('hash_csrt').withLength(min: 0, max: 28).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeResponsavelTecnicoGrouped {
	NfeResponsavelTecnico? nfeResponsavelTecnico; 

  NfeResponsavelTecnicoGrouped({
		this.nfeResponsavelTecnico, 

  });
}
