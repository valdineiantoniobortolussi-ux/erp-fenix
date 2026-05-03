import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

@DataClassName("Pessoa")
class Pessoas extends Table {
	@override
	String get tableName => 'pessoa';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 150).nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	TextColumn get site => text().named('site').withLength(min: 0, max: 250).nullable()();
	TextColumn get email => text().named('email').withLength(min: 0, max: 250).nullable()();
	TextColumn get ehCliente => text().named('eh_cliente').withLength(min: 0, max: 1).nullable()();
	TextColumn get ehFornecedor => text().named('eh_fornecedor').withLength(min: 0, max: 1).nullable()();
	TextColumn get ehTransportadora => text().named('eh_transportadora').withLength(min: 0, max: 1).nullable()();
	TextColumn get ehColaborador => text().named('eh_colaborador').withLength(min: 0, max: 1).nullable()();
	TextColumn get ehContador => text().named('eh_contador').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PessoaGrouped {
	Pessoa? pessoa; 
	PessoaJuridica? pessoaJuridica; 
	Fornecedor? fornecedor; 
	ClienteGrouped? clienteGrouped; 
	PessoaFisicaGrouped? pessoaFisicaGrouped; 
	Transportadora? transportadora; 
	Contador? contador; 
	List<PessoaContatoGrouped>? pessoaContatoGroupedList; 
	List<PessoaTelefoneGrouped>? pessoaTelefoneGroupedList; 
	List<PessoaEnderecoGrouped>? pessoaEnderecoGroupedList; 

  PessoaGrouped({
		this.pessoa, 
		this.pessoaJuridica, 
		this.fornecedor, 
		this. clienteGrouped, 
		this. pessoaFisicaGrouped, 
		this.transportadora, 
		this.contador, 
		this.pessoaContatoGroupedList, 
		this.pessoaTelefoneGroupedList, 
		this.pessoaEnderecoGroupedList, 

  });
}
