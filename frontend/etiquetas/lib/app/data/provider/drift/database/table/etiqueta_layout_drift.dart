import 'package:drift/drift.dart';
import 'package:etiquetas/app/data/provider/drift/database/database.dart';
import 'package:etiquetas/app/data/provider/drift/database/database_imports.dart';

@DataClassName("EtiquetaLayout")
class EtiquetaLayouts extends Table {
	@override
	String get tableName => 'etiqueta_layout';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFormatoPapel => integer().named('id_formato_papel').nullable()();
	TextColumn get codigoFabricante => text().named('codigo_fabricante').withLength(min: 0, max: 50).nullable()();
	IntColumn get quantidade => integer().named('quantidade').nullable()();
	IntColumn get quantidadeHorizontal => integer().named('quantidade_horizontal').nullable()();
	IntColumn get quantidadeVertical => integer().named('quantidade_vertical').nullable()();
	IntColumn get margemSuperior => integer().named('margem_superior').nullable()();
	IntColumn get margemInferior => integer().named('margem_inferior').nullable()();
	IntColumn get margemEsquerda => integer().named('margem_esquerda').nullable()();
	IntColumn get margemDireita => integer().named('margem_direita').nullable()();
	IntColumn get espacamentoHorizontal => integer().named('espacamento_horizontal').nullable()();
	IntColumn get espacamentoVertical => integer().named('espacamento_vertical').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EtiquetaLayoutGrouped {
	EtiquetaLayout? etiquetaLayout; 
	List<EtiquetaTemplateGrouped>? etiquetaTemplateGroupedList; 
	EtiquetaFormatoPapel? etiquetaFormatoPapel; 

  EtiquetaLayoutGrouped({
		this.etiquetaLayout, 
		this.etiquetaTemplateGroupedList, 
		this.etiquetaFormatoPapel, 

  });
}
