import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FolhaRescisao")
class FolhaRescisaos extends Table {
	@override
	String get tableName => 'folha_rescisao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	DateTimeColumn get dataDemissao => dateTime().named('data_demissao').nullable()();
	DateTimeColumn get dataPagamento => dateTime().named('data_pagamento').nullable()();
	TextColumn get motivo => text().named('motivo').withLength(min: 0, max: 100).nullable()();
	TextColumn get motivoEsocial => text().named('motivo_esocial').withLength(min: 0, max: 2).nullable()();
	DateTimeColumn get dataAvisoPrevio => dateTime().named('data_aviso_previo').nullable()();
	IntColumn get diasAvisoPrevio => integer().named('dias_aviso_previo').nullable()();
	TextColumn get comprovouNovoEmprego => text().named('comprovou_novo_emprego').withLength(min: 0, max: 1).nullable()();
	TextColumn get dispensouEmpregado => text().named('dispensou_empregado').withLength(min: 0, max: 1).nullable()();
	RealColumn get pensaoAlimenticia => real().named('pensao_alimenticia').nullable()();
	RealColumn get pensaoAlimenticiaFgts => real().named('pensao_alimenticia_fgts').nullable()();
	RealColumn get fgtsValorRescisao => real().named('fgts_valor_rescisao').nullable()();
	RealColumn get fgtsSaldoBanco => real().named('fgts_saldo_banco').nullable()();
	RealColumn get fgtsComplementoSaldo => real().named('fgts_complemento_saldo').nullable()();
	TextColumn get fgtsCodigoAfastamento => text().named('fgts_codigo_afastamento').withLength(min: 0, max: 10).nullable()();
	TextColumn get fgtsCodigoSaque => text().named('fgts_codigo_saque').withLength(min: 0, max: 10).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaRescisaoGrouped {
	FolhaRescisao? folhaRescisao; 
	ViewPessoaColaborador? viewPessoaColaborador; 

  FolhaRescisaoGrouped({
		this.folhaRescisao, 
		this.viewPessoaColaborador, 

  });
}
