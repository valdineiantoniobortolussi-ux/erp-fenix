import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("Contador")
class Contadors extends Table {
	@override
	String get tableName => 'contador';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPessoa => integer().named('id_pessoa').nullable()();
	TextColumn get crcInscricao => text().named('crc_inscricao').withLength(min: 0, max: 15).nullable()();
	TextColumn get crcUf => text().named('crc_uf').withLength(min: 0, max: 2).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContadorGrouped {
	Contador? contador; 

  ContadorGrouped({
		this.contador, 

  });
}
