import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("ViewControleAcesso")
class ViewControleAcessos extends Table {
	@override
	String get tableName => 'view_controle_acesso';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPessoa => integer().named('id_pessoa').nullable()();
	TextColumn get pessoaNome => text().named('pessoa_nome').withLength(min: 0, max: 450).nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	IntColumn get idUsuario => integer().named('id_usuario').nullable()();
	TextColumn get administrador => text().named('administrador').withLength(min: 0, max: 3).nullable()();
	IntColumn get idPapel => integer().named('id_papel').nullable()();
	TextColumn get papelNome => text().named('papel_nome').withLength(min: 0, max: 300).nullable()();
	TextColumn get papelDescricao => text().named('papel_descricao').withLength(min: 0, max: 750).nullable()();
	IntColumn get idFuncao => integer().named('id_funcao').nullable()();
	TextColumn get funcaoNome => text().named('funcao_nome').withLength(min: 0, max: 300).nullable()();
	TextColumn get funcaoDescricao => text().named('funcao_descricao').withLength(min: 0, max: 750).nullable()();
	IntColumn get idPapelFuncao => integer().named('id_papel_funcao').nullable()();
	TextColumn get habilitado => text().named('habilitado').withLength(min: 0, max: 3).nullable()();
	TextColumn get podeInserir => text().named('pode_inserir').withLength(min: 0, max: 3).nullable()();
	TextColumn get podeAlterar => text().named('pode_alterar').withLength(min: 0, max: 3).nullable()();
	TextColumn get podeExcluir => text().named('pode_excluir').withLength(min: 0, max: 3).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ViewControleAcessoGrouped {
	ViewControleAcesso? viewControleAcesso; 

  ViewControleAcessoGrouped({
		this.viewControleAcesso, 

  });
}
