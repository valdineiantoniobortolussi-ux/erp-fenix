import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';

@DataClassName("FinTipoRecebimento")
class FinTipoRecebimentos extends Table {
	@override
	String get tableName => 'fin_tipo_recebimento';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 2).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FinTipoRecebimentoGrouped {
	FinTipoRecebimento? finTipoRecebimento; 

  FinTipoRecebimentoGrouped({
		this.finTipoRecebimento, 

  });
}
