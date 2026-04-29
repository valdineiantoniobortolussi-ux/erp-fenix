import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';

@DataClassName("PontoHorarioAutorizado")
class PontoHorarioAutorizados extends Table {
	@override
	String get tableName => 'ponto_horario_autorizado';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	DateTimeColumn get dataHorario => dateTime().named('data_horario').nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	TextColumn get cargaHoraria => text().named('carga_horaria').withLength(min: 0, max: 8).nullable()();
	TextColumn get entrada01 => text().named('entrada01').withLength(min: 0, max: 8).nullable()();
	TextColumn get saida01 => text().named('saida01').withLength(min: 0, max: 8).nullable()();
	TextColumn get entrada02 => text().named('entrada02').withLength(min: 0, max: 8).nullable()();
	TextColumn get saida02 => text().named('saida02').withLength(min: 0, max: 8).nullable()();
	TextColumn get entrada03 => text().named('entrada03').withLength(min: 0, max: 8).nullable()();
	TextColumn get saida03 => text().named('saida03').withLength(min: 0, max: 8).nullable()();
	TextColumn get entrada04 => text().named('entrada04').withLength(min: 0, max: 8).nullable()();
	TextColumn get saida04 => text().named('saida04').withLength(min: 0, max: 8).nullable()();
	TextColumn get entrada05 => text().named('entrada05').withLength(min: 0, max: 8).nullable()();
	TextColumn get saida05 => text().named('saida05').withLength(min: 0, max: 8).nullable()();
	TextColumn get horaFechamentoDia => text().named('hora_fechamento_dia').withLength(min: 0, max: 8).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PontoHorarioAutorizadoGrouped {
	PontoHorarioAutorizado? pontoHorarioAutorizado; 
	ViewPessoaColaborador? viewPessoaColaborador; 

  PontoHorarioAutorizadoGrouped({
		this.pontoHorarioAutorizado, 
		this.viewPessoaColaborador, 

  });
}
