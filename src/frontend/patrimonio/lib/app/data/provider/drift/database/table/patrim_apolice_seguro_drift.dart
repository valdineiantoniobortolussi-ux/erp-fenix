import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';

@DataClassName("PatrimApoliceSeguro")
class PatrimApoliceSeguros extends Table {
	@override
	String get tableName => 'patrim_apolice_seguro';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPatrimBem => integer().named('id_patrim_bem').nullable()();
	IntColumn get idSeguradora => integer().named('id_seguradora').nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 20).nullable()();
	DateTimeColumn get dataContratacao => dateTime().named('data_contratacao').nullable()();
	DateTimeColumn get dataVencimento => dateTime().named('data_vencimento').nullable()();
	RealColumn get valorPremio => real().named('valor_premio').nullable()();
	RealColumn get valorSegurado => real().named('valor_segurado').nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();
	TextColumn get imagem => text().named('imagem').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PatrimApoliceSeguroGrouped {
	PatrimApoliceSeguro? patrimApoliceSeguro; 
	Seguradora? seguradora; 

  PatrimApoliceSeguroGrouped({
		this.patrimApoliceSeguro, 
		this.seguradora, 

  });
}
