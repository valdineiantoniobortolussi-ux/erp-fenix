import 'package:drift/drift.dart';
import 'package:etiquetas/app/data/provider/drift/database/database.dart';

@DataClassName("EtiquetaTemplate")
class EtiquetaTemplates extends Table {
	@override
	String get tableName => 'etiqueta_template';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idEtiquetaLayout => integer().named('id_etiqueta_layout').nullable()();
	TextColumn get tabela => text().named('tabela').withLength(min: 0, max: 50).nullable()();
	TextColumn get campo => text().named('campo').withLength(min: 0, max: 50).nullable()();
	TextColumn get formato => text().named('formato').withLength(min: 0, max: 1).nullable()();
	IntColumn get quantidadeRepeticoes => integer().named('quantidade_repeticoes').nullable()();
	TextColumn get filtro => text().named('filtro').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EtiquetaTemplateGrouped {
	EtiquetaTemplate? etiquetaTemplate; 

  EtiquetaTemplateGrouped({
		this.etiquetaTemplate, 

  });
}
