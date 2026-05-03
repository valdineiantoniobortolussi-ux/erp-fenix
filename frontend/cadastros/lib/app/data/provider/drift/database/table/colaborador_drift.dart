import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

@DataClassName("Colaborador")
class Colaboradors extends Table {
	@override
	String get tableName => 'colaborador';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPessoa => integer().named('id_pessoa').nullable()();
	IntColumn get idCargo => integer().named('id_cargo').nullable()();
	IntColumn get idSetor => integer().named('id_setor').nullable()();
	IntColumn get idColaboradorSituacao => integer().named('id_colaborador_situacao').nullable()();
	IntColumn get idTipoAdmissao => integer().named('id_tipo_admissao').nullable()();
	IntColumn get idColaboradorTipo => integer().named('id_colaborador_tipo').nullable()();
	IntColumn get idSindicato => integer().named('id_sindicato').nullable()();
	TextColumn get matricula => text().named('matricula').withLength(min: 0, max: 10).nullable()();
	DateTimeColumn get dataCadastro => dateTime().named('data_cadastro').nullable()();
	DateTimeColumn get dataAdmissao => dateTime().named('data_admissao').nullable()();
	DateTimeColumn get dataDemissao => dateTime().named('data_demissao').nullable()();
	TextColumn get ctpsNumero => text().named('ctps_numero').withLength(min: 0, max: 10).nullable()();
	TextColumn get ctpsSerie => text().named('ctps_serie').withLength(min: 0, max: 10).nullable()();
	DateTimeColumn get ctpsDataExpedicao => dateTime().named('ctps_data_expedicao').nullable()();
	TextColumn get ctpsUf => text().named('ctps_uf').withLength(min: 0, max: 2).nullable()();
	TextColumn get observacao => text().named('observacao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ColaboradorGrouped {
	Colaborador? colaborador; 
	VendedorGrouped? vendedorGrouped; 
	Pessoa? pessoa; 
	ColaboradorSituacao? colaboradorSituacao; 
	ColaboradorTipo? colaboradorTipo; 
	Setor? setor; 
	Cargo? cargo; 
	TipoAdmissao? tipoAdmissao; 
	List<ColaboradorRelacionamentoGrouped>? colaboradorRelacionamentoGroupedList; 
	Sindicato? sindicato; 

  ColaboradorGrouped({
		this.colaborador, 
		this. vendedorGrouped, 
		this.pessoa, 
		this.colaboradorSituacao, 
		this.colaboradorTipo, 
		this.setor, 
		this.cargo, 
		this.tipoAdmissao, 
		this.colaboradorRelacionamentoGroupedList, 
		this.sindicato, 

  });
}
