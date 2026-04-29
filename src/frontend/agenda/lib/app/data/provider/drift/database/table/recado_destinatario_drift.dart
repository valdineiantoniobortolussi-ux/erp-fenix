import 'package:drift/drift.dart';
import 'package:agenda/app/data/provider/drift/database/database.dart';

@DataClassName("RecadoDestinatario")
class RecadoDestinatarios extends Table {
	@override
	String get tableName => 'recado_destinatario';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	IntColumn get idRecadoRemetente => integer().named('id_recado_remetente').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class RecadoDestinatarioGrouped {
	RecadoDestinatario? recadoDestinatario; 
	ViewPessoaColaborador? viewPessoaColaborador; 

  RecadoDestinatarioGrouped({
		this.recadoDestinatario, 
		this.viewPessoaColaborador, 

  });
}
