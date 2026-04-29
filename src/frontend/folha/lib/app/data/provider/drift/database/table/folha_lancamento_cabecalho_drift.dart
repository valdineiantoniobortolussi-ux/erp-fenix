import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

@DataClassName("FolhaLancamentoCabecalho")
class FolhaLancamentoCabecalhos extends Table {
	@override
	String get tableName => 'folha_lancamento_cabecalho';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	TextColumn get competencia => text().named('competencia').withLength(min: 0, max: 7).nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaLancamentoCabecalhoGrouped {
	FolhaLancamentoCabecalho? folhaLancamentoCabecalho; 
	List<FolhaLancamentoDetalheGrouped>? folhaLancamentoDetalheGroupedList; 
	ViewPessoaColaborador? viewPessoaColaborador; 

  FolhaLancamentoCabecalhoGrouped({
		this.folhaLancamentoCabecalho, 
		this.folhaLancamentoDetalheGroupedList, 
		this.viewPessoaColaborador, 

  });
}
