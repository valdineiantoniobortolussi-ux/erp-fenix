import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FolhaFechamento")
class FolhaFechamentos extends Table {
	@override
	String get tableName => 'folha_fechamento';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get fechamentoAtual => text().named('fechamento_atual').withLength(min: 0, max: 7).nullable()();
	TextColumn get proximoFechamento => text().named('proximo_fechamento').withLength(min: 0, max: 7).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaFechamentoGrouped {
	FolhaFechamento? folhaFechamento; 

  FolhaFechamentoGrouped({
		this.folhaFechamento, 

  });
}
