import 'package:drift/drift.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';

@DataClassName("EstoqueTamanho")
class EstoqueTamanhos extends Table {
	@override
	String get tableName => 'estoque_tamanho';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 4).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();
	RealColumn get altura => real().named('altura').nullable()();
	RealColumn get comprimento => real().named('comprimento').nullable()();
	RealColumn get largura => real().named('largura').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EstoqueTamanhoGrouped {
	EstoqueTamanho? estoqueTamanho; 

  EstoqueTamanhoGrouped({
		this.estoqueTamanho, 

  });
}
