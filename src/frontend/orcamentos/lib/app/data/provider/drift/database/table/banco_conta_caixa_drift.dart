import 'package:drift/drift.dart';
import 'package:orcamentos/app/data/provider/drift/database/database.dart';

@DataClassName("BancoContaCaixa")
class BancoContaCaixas extends Table {
	@override
	String get tableName => 'banco_conta_caixa';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 20).nullable()();
	TextColumn get digito => text().named('digito').withLength(min: 0, max: 1).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class BancoContaCaixaGrouped {
	BancoContaCaixa? bancoContaCaixa; 

  BancoContaCaixaGrouped({
		this.bancoContaCaixa, 

  });
}
