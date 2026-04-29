import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("BancoAgencia")
class BancoAgencias extends Table {
	@override
	String get tableName => 'banco_agencia';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idBanco => integer().named('id_banco').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 20).nullable()();
	TextColumn get digito => text().named('digito').withLength(min: 0, max: 1).nullable()();
	TextColumn get telefone => text().named('telefone').withLength(min: 0, max: 15).nullable()();
	TextColumn get contato => text().named('contato').withLength(min: 0, max: 100).nullable()();
	TextColumn get gerente => text().named('gerente').withLength(min: 0, max: 100).nullable()();
	TextColumn get observacao => text().named('observacao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class BancoAgenciaGrouped {
	BancoAgencia? bancoAgencia; 
	Banco? banco; 

  BancoAgenciaGrouped({
		this.bancoAgencia, 
		this.banco, 

  });
}
