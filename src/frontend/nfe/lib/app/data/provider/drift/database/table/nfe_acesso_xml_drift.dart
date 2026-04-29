import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeAcessoXml")
class NfeAcessoXmls extends Table {
	@override
	String get tableName => 'nfe_acesso_xml';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeCabecalho => integer().named('id_nfe_cabecalho').nullable()();
	TextColumn get cnpj => text().named('cnpj').withLength(min: 0, max: 14).nullable()();
	TextColumn get cpf => text().named('cpf').withLength(min: 0, max: 11).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeAcessoXmlGrouped {
	NfeAcessoXml? nfeAcessoXml; 

  NfeAcessoXmlGrouped({
		this.nfeAcessoXml, 

  });
}
