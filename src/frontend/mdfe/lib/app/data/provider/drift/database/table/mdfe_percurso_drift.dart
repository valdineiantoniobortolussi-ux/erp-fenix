import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';

@DataClassName("MdfePercurso")
class MdfePercursos extends Table {
	@override
	String get tableName => 'mdfe_percurso';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idMdfeCabecalho => integer().named('id_mdfe_cabecalho').nullable()();
	TextColumn get ufPercurso => text().named('uf_percurso').withLength(min: 0, max: 2).nullable()();
	DateTimeColumn get dataInicioViagem => dateTime().named('data_inicio_viagem').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class MdfePercursoGrouped {
	MdfePercurso? mdfePercurso; 

  MdfePercursoGrouped({
		this.mdfePercurso, 

  });
}
