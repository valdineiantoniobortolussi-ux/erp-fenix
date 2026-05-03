import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FolhaInssServico")
class FolhaInssServicos extends Table {
	@override
	String get tableName => 'folha_inss_servico';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 3).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaInssServicoGrouped {
	FolhaInssServico? folhaInssServico; 

  FolhaInssServicoGrouped({
		this.folhaInssServico, 

  });
}
