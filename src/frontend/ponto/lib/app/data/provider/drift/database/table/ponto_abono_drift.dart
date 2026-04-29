import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/provider/drift/database/database_imports.dart';

@DataClassName("PontoAbono")
class PontoAbonos extends Table {
	@override
	String get tableName => 'ponto_abono';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	IntColumn get quantidade => integer().named('quantidade').nullable()();
	IntColumn get utilizado => integer().named('utilizado').nullable()();
	IntColumn get saldo => integer().named('saldo').nullable()();
	DateTimeColumn get dataCadastro => dateTime().named('data_cadastro').nullable()();
	DateTimeColumn get inicioUtilizacao => dateTime().named('inicio_utilizacao').nullable()();
	DateTimeColumn get dataValidade => dateTime().named('data_validade').nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PontoAbonoGrouped {
	PontoAbono? pontoAbono; 
	List<PontoAbonoUtilizacaoGrouped>? pontoAbonoUtilizacaoGroupedList; 
	ViewPessoaColaborador? viewPessoaColaborador; 

  PontoAbonoGrouped({
		this.pontoAbono, 
		this.pontoAbonoUtilizacaoGroupedList, 
		this.viewPessoaColaborador, 

  });
}
