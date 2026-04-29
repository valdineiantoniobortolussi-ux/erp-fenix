import 'package:drift/drift.dart';
import 'package:esocial/app/data/provider/drift/database/database.dart';

@DataClassName("EsocialClassificacaoTribut")
class EsocialClassificacaoTributs extends Table {
	@override
	String get tableName => 'esocial_classificacao_tribut';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 2).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EsocialClassificacaoTributGrouped {
	EsocialClassificacaoTribut? esocialClassificacaoTribut; 

  EsocialClassificacaoTributGrouped({
		this.esocialClassificacaoTribut, 

  });
}
