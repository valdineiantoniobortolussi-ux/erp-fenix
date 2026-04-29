import 'package:drift/drift.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';
import 'package:contratos/app/data/provider/drift/database/database_imports.dart';

@DataClassName("Contrato")
class Contratos extends Table {
	@override
	String get tableName => 'contrato';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idSolicitacaoServico => integer().named('id_solicitacao_servico').nullable()();
	IntColumn get idTipoContrato => integer().named('id_tipo_contrato').nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 50).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();
	DateTimeColumn get dataCadastro => dateTime().named('data_cadastro').nullable()();
	DateTimeColumn get dataInicioVigencia => dateTime().named('data_inicio_vigencia').nullable()();
	DateTimeColumn get dataFimVigencia => dateTime().named('data_fim_vigencia').nullable()();
	TextColumn get diaFaturamento => text().named('dia_faturamento').withLength(min: 0, max: 2).nullable()();
	RealColumn get valor => real().named('valor').nullable()();
	IntColumn get quantidadeParcelas => integer().named('quantidade_parcelas').nullable()();
	IntColumn get intervaloEntreParcelas => integer().named('intervalo_entre_parcelas').nullable()();
	TextColumn get classificacaoContabilConta => text().named('classificacao_contabil_conta').withLength(min: 0, max: 30).nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContratoGrouped {
	Contrato? contrato; 
	List<ContratoHistoricoReajusteGrouped>? contratoHistoricoReajusteGroupedList; 
	List<ContratoPrevFaturamentoGrouped>? contratoPrevFaturamentoGroupedList; 
	List<ContratoHistFaturamentoGrouped>? contratoHistFaturamentoGroupedList; 
	TipoContrato? tipoContrato; 
	ContratoSolicitacaoServico? contratoSolicitacaoServico; 

  ContratoGrouped({
		this.contrato, 
		this.contratoHistoricoReajusteGroupedList, 
		this.contratoPrevFaturamentoGroupedList, 
		this.contratoHistFaturamentoGroupedList, 
		this.tipoContrato, 
		this.contratoSolicitacaoServico, 

  });
}
