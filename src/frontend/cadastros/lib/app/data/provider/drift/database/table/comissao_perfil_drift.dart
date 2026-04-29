import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("ComissaoPerfil")
class ComissaoPerfils extends Table {
	@override
	String get tableName => 'comissao_perfil';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 3).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ComissaoPerfilGrouped {
	ComissaoPerfil? comissaoPerfil; 

  ComissaoPerfilGrouped({
		this.comissaoPerfil, 

  });
}
