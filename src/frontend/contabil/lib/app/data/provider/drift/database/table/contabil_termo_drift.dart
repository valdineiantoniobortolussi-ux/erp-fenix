import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("ContabilTermo")
class ContabilTermos extends Table {
	@override
	String get tableName => 'contabil_termo';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idContabilLivro => integer().named('id_contabil_livro').nullable()();
	TextColumn get aberturaEncerramento => text().named('abertura_encerramento').withLength(min: 0, max: 1).nullable()();
	IntColumn get numero => integer().named('numero').nullable()();
	IntColumn get paginaInicial => integer().named('pagina_inicial').nullable()();
	IntColumn get paginaFinal => integer().named('pagina_final').nullable()();
	TextColumn get registrado => text().named('registrado').withLength(min: 0, max: 100).nullable()();
	TextColumn get numeroRegistro => text().named('numero_registro').withLength(min: 0, max: 50).nullable()();
	DateTimeColumn get dataDespacho => dateTime().named('data_despacho').nullable()();
	DateTimeColumn get dataAbertura => dateTime().named('data_abertura').nullable()();
	DateTimeColumn get dataEncerramento => dateTime().named('data_encerramento').nullable()();
	DateTimeColumn get escrituracaoInicio => dateTime().named('escrituracao_inicio').nullable()();
	DateTimeColumn get escrituracaoFim => dateTime().named('escrituracao_fim').nullable()();
	TextColumn get texto => text().named('texto').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContabilTermoGrouped {
	ContabilTermo? contabilTermo; 

  ContabilTermoGrouped({
		this.contabilTermo, 

  });
}
