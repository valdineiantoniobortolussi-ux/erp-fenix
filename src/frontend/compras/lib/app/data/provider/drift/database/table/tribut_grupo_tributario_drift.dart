import 'package:drift/drift.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';

@DataClassName("TributGrupoTributario")
class TributGrupoTributarios extends Table {
	@override
	String get tableName => 'tribut_grupo_tributario';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();
	TextColumn get origemMercadoria => text().named('origem_mercadoria').withLength(min: 0, max: 1).nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class TributGrupoTributarioGrouped {
	TributGrupoTributario? tributGrupoTributario; 

  TributGrupoTributarioGrouped({
		this.tributGrupoTributario, 

  });
}
