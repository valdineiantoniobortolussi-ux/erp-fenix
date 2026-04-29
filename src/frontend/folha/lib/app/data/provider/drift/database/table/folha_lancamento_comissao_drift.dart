import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FolhaLancamentoComissao")
class FolhaLancamentoComissaos extends Table {
	@override
	String get tableName => 'folha_lancamento_comissao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	TextColumn get competencia => text().named('competencia').withLength(min: 0, max: 7).nullable()();
	DateTimeColumn get vencimento => dateTime().named('vencimento').nullable()();
	RealColumn get baseCalculo => real().named('base_calculo').nullable()();
	RealColumn get valorComissao => real().named('valor_comissao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaLancamentoComissaoGrouped {
	FolhaLancamentoComissao? folhaLancamentoComissao; 
	ViewPessoaColaborador? viewPessoaColaborador; 

  FolhaLancamentoComissaoGrouped({
		this.folhaLancamentoComissao, 
		this.viewPessoaColaborador, 

  });
}
