import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/provider/drift/database/database_imports.dart';

@DataClassName("PontoBancoHoras")
class PontoBancoHorass extends Table {
	@override
	String get tableName => 'ponto_banco_horas';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	DateTimeColumn get dataTrabalho => dateTime().named('data_trabalho').nullable()();
	TextColumn get quantidade => text().named('quantidade').withLength(min: 0, max: 8).nullable()();
	TextColumn get situacao => text().named('situacao').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PontoBancoHorasGrouped {
	PontoBancoHoras? pontoBancoHoras; 
	List<PontoBancoHorasUtilizacaoGrouped>? pontoBancoHorasUtilizacaoGroupedList; 
	ViewPessoaColaborador? viewPessoaColaborador; 

  PontoBancoHorasGrouped({
		this.pontoBancoHoras, 
		this.pontoBancoHorasUtilizacaoGroupedList, 
		this.viewPessoaColaborador, 

  });
}
