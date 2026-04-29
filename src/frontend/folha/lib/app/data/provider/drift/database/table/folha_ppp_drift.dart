import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

@DataClassName("FolhaPpp")
class FolhaPpps extends Table {
	@override
	String get tableName => 'folha_ppp';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaPppGrouped {
	FolhaPpp? folhaPpp; 
	List<FolhaPppCatGrouped>? folhaPppCatGroupedList; 
	List<FolhaPppAtividadeGrouped>? folhaPppAtividadeGroupedList; 
	List<FolhaPppFatorRiscoGrouped>? folhaPppFatorRiscoGroupedList; 
	List<FolhaPppExameMedicoGrouped>? folhaPppExameMedicoGroupedList; 
	ViewPessoaColaborador? viewPessoaColaborador; 

  FolhaPppGrouped({
		this.folhaPpp, 
		this.folhaPppCatGroupedList, 
		this.folhaPppAtividadeGroupedList, 
		this.folhaPppFatorRiscoGroupedList, 
		this.folhaPppExameMedicoGroupedList, 
		this.viewPessoaColaborador, 

  });
}
