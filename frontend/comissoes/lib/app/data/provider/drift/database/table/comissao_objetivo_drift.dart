import 'package:drift/drift.dart';
import 'package:comissoes/app/data/provider/drift/database/database.dart';

@DataClassName("ComissaoObjetivo")
class ComissaoObjetivos extends Table {
	@override
	String get tableName => 'comissao_objetivo';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idComissaoPerfil => integer().named('id_comissao_perfil').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 3).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();
	RealColumn get taxaPagamento => real().named('taxa_pagamento').nullable()();
	RealColumn get valorPagamento => real().named('valor_pagamento').nullable()();
	RealColumn get valorMeta => real().named('valor_meta').nullable()();
	DateTimeColumn get dataInicio => dateTime().named('data_inicio').nullable()();
	DateTimeColumn get dataFim => dateTime().named('data_fim').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ComissaoObjetivoGrouped {
	ComissaoObjetivo? comissaoObjetivo; 
	ComissaoPerfil? comissaoPerfil; 

  ComissaoObjetivoGrouped({
		this.comissaoObjetivo, 
		this.comissaoPerfil, 

  });
}
