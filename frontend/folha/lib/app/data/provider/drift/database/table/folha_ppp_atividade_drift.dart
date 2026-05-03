import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FolhaPppAtividade")
class FolhaPppAtividades extends Table {
	@override
	String get tableName => 'folha_ppp_atividade';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFolhaPpp => integer().named('id_folha_ppp').nullable()();
	DateTimeColumn get dataInicio => dateTime().named('data_inicio').nullable()();
	DateTimeColumn get dataFim => dateTime().named('data_fim').nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaPppAtividadeGrouped {
	FolhaPppAtividade? folhaPppAtividade; 

  FolhaPppAtividadeGrouped({
		this.folhaPppAtividade, 

  });
}
