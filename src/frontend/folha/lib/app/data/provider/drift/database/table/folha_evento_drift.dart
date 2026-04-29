import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FolhaEvento")
class FolhaEventos extends Table {
	@override
	String get tableName => 'folha_evento';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 3).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();
	TextColumn get baseCalculo => text().named('base_calculo').withLength(min: 0, max: 2).nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	TextColumn get unidade => text().named('unidade').withLength(min: 0, max: 1).nullable()();
	RealColumn get taxa => real().named('taxa').nullable()();
	TextColumn get rubricaEsocial => text().named('rubrica_esocial').withLength(min: 0, max: 4).nullable()();
	TextColumn get codIncidenciaPrevidencia => text().named('cod_incidencia_previdencia').withLength(min: 0, max: 2).nullable()();
	TextColumn get codIncidenciaIrrf => text().named('cod_incidencia_irrf').withLength(min: 0, max: 2).nullable()();
	TextColumn get codIncidenciaFgts => text().named('cod_incidencia_fgts').withLength(min: 0, max: 2).nullable()();
	TextColumn get codIncidenciaSindicato => text().named('cod_incidencia_sindicato').withLength(min: 0, max: 2).nullable()();
	TextColumn get repercuteDsr => text().named('repercute_dsr').withLength(min: 0, max: 1).nullable()();
	TextColumn get repercute13 => text().named('repercute_13').withLength(min: 0, max: 1).nullable()();
	TextColumn get repercuteFerias => text().named('repercute_ferias').withLength(min: 0, max: 1).nullable()();
	TextColumn get repercuteAviso => text().named('repercute_aviso').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaEventoGrouped {
	FolhaEvento? folhaEvento; 

  FolhaEventoGrouped({
		this.folhaEvento, 

  });
}
