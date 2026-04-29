import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FolhaAfastamento")
class FolhaAfastamentos extends Table {
	@override
	String get tableName => 'folha_afastamento';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	IntColumn get idFolhaTipoAfastamento => integer().named('id_folha_tipo_afastamento').nullable()();
	DateTimeColumn get dataInicio => dateTime().named('data_inicio').nullable()();
	DateTimeColumn get dataFim => dateTime().named('data_fim').nullable()();
	IntColumn get diasAfastado => integer().named('dias_afastado').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaAfastamentoGrouped {
	FolhaAfastamento? folhaAfastamento; 
	ViewPessoaColaborador? viewPessoaColaborador; 
	FolhaTipoAfastamento? folhaTipoAfastamento; 

  FolhaAfastamentoGrouped({
		this.folhaAfastamento, 
		this.viewPessoaColaborador, 
		this.folhaTipoAfastamento, 

  });
}
