import 'package:drift/drift.dart';
import 'package:ged/app/data/provider/drift/database/database.dart';

@DataClassName("GedVersaoDocumento")
class GedVersaoDocumentos extends Table {
	@override
	String get tableName => 'ged_versao_documento';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idGedDocumentoDetalhe => integer().named('id_ged_documento_detalhe').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	TextColumn get acao => text().named('acao').withLength(min: 0, max: 1).nullable()();
	IntColumn get versao => integer().named('versao').nullable()();
	DateTimeColumn get dataVersao => dateTime().named('data_versao').nullable()();
	TextColumn get horaVersao => text().named('hora_versao').withLength(min: 0, max: 8).nullable()();
	TextColumn get hashArquivo => text().named('hash_arquivo').withLength(min: 0, max: 250).nullable()();
	TextColumn get caminho => text().named('caminho').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class GedVersaoDocumentoGrouped {
	GedVersaoDocumento? gedVersaoDocumento; 
	GedDocumentoDetalhe? gedDocumentoDetalhe; 
	ViewPessoaColaborador? viewPessoaColaborador; 

  GedVersaoDocumentoGrouped({
		this.gedVersaoDocumento, 
		this.gedDocumentoDetalhe, 
		this.viewPessoaColaborador, 

  });
}
