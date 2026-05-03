import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("PapelFuncao")
class PapelFuncaos extends Table {
	@override
	String get tableName => 'papel_funcao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPapel => integer().named('id_papel').nullable()();
	IntColumn get idFuncao => integer().named('id_funcao').nullable()();
	TextColumn get habilitado => text().named('habilitado').withLength(min: 0, max: 1).nullable()();
	TextColumn get podeInserir => text().named('pode_inserir').withLength(min: 0, max: 1).nullable()();
	TextColumn get podeAlterar => text().named('pode_alterar').withLength(min: 0, max: 1).nullable()();
	TextColumn get podeExcluir => text().named('pode_excluir').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PapelFuncaoGrouped {
	PapelFuncao? papelFuncao; 

  PapelFuncaoGrouped({
		this.papelFuncao, 

  });
}
