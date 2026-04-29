import 'package:drift/drift.dart';
import 'package:projetos/app/data/provider/drift/database/database.dart';

@DataClassName("ProjetoCronograma")
class ProjetoCronogramas extends Table {
	@override
	String get tableName => 'projeto_cronograma';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idProjetoPrincipal => integer().named('id_projeto_principal').nullable()();
	TextColumn get tarefa => text().named('tarefa').withLength(min: 0, max: 100).nullable()();
	DateTimeColumn get dataTarefa => dateTime().named('data_tarefa').nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ProjetoCronogramaGrouped {
	ProjetoCronograma? projetoCronograma; 

  ProjetoCronogramaGrouped({
		this.projetoCronograma, 

  });
}
