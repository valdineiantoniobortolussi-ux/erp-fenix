import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FolhaLancamentoDetalhe")
class FolhaLancamentoDetalhes extends Table {
	@override
	String get tableName => 'folha_lancamento_detalhe';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFolhaLancamentoCabecalho => integer().named('id_folha_lancamento_cabecalho').nullable()();
	IntColumn get idFolhaEvento => integer().named('id_folha_evento').nullable()();
	RealColumn get origem => real().named('origem').nullable()();
	RealColumn get provento => real().named('provento').nullable()();
	RealColumn get desconto => real().named('desconto').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaLancamentoDetalheGrouped {
	FolhaLancamentoDetalhe? folhaLancamentoDetalhe; 
	FolhaEvento? folhaEvento; 

  FolhaLancamentoDetalheGrouped({
		this.folhaLancamentoDetalhe, 
		this.folhaEvento, 

  });
}
