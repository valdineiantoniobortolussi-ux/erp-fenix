import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FolhaInssRetencao")
class FolhaInssRetencaos extends Table {
	@override
	String get tableName => 'folha_inss_retencao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFolhaInss => integer().named('id_folha_inss').nullable()();
	IntColumn get idFolhaInssServico => integer().named('id_folha_inss_servico').nullable()();
	RealColumn get valorMensal => real().named('valor_mensal').nullable()();
	RealColumn get valor13 => real().named('valor_13').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaInssRetencaoGrouped {
	FolhaInssRetencao? folhaInssRetencao; 
	FolhaInssServico? folhaInssServico; 

  FolhaInssRetencaoGrouped({
		this.folhaInssRetencao, 
		this.folhaInssServico, 

  });
}
