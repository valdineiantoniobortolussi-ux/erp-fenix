import 'package:drift/drift.dart';
import 'package:ged/app/data/provider/drift/database/database.dart';

@DataClassName("GedDocumentoDetalhe")
class GedDocumentoDetalhes extends Table {
	@override
	String get tableName => 'ged_documento_detalhe';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idGedDocumentoCabecalho => integer().named('id_ged_documento_cabecalho').nullable()();
	IntColumn get idGedTipoDocumento => integer().named('id_ged_tipo_documento').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();
	TextColumn get palavrasChave => text().named('palavras_chave').withLength(min: 0, max: 250).nullable()();
	TextColumn get podeExcluir => text().named('pode_excluir').withLength(min: 0, max: 1).nullable()();
	TextColumn get podeAlterar => text().named('pode_alterar').withLength(min: 0, max: 1).nullable()();
	TextColumn get assinado => text().named('assinado').withLength(min: 0, max: 1).nullable()();
	DateTimeColumn get dataFimVigencia => dateTime().named('data_fim_vigencia').nullable()();
	DateTimeColumn get dataExclusao => dateTime().named('data_exclusao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class GedDocumentoDetalheGrouped {
	GedDocumentoDetalhe? gedDocumentoDetalhe; 
	GedTipoDocumento? gedTipoDocumento; 

  GedDocumentoDetalheGrouped({
		this.gedDocumentoDetalhe, 
		this.gedTipoDocumento, 

  });
}
