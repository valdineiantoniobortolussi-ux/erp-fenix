import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';

@DataClassName("FinConfiguracaoBoleto")
class FinConfiguracaoBoletos extends Table {
	@override
	String get tableName => 'fin_configuracao_boleto';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idBancoContaCaixa => integer().named('id_banco_conta_caixa').nullable()();
	TextColumn get instrucao01 => text().named('instrucao01').withLength(min: 0, max: 100).nullable()();
	TextColumn get instrucao02 => text().named('instrucao02').withLength(min: 0, max: 100).nullable()();
	TextColumn get caminhoArquivoRemessa => text().named('caminho_arquivo_remessa').withLength(min: 0, max: 250).nullable()();
	TextColumn get caminhoArquivoRetorno => text().named('caminho_arquivo_retorno').withLength(min: 0, max: 250).nullable()();
	TextColumn get caminhoArquivoLogotipo => text().named('caminho_arquivo_logotipo').withLength(min: 0, max: 250).nullable()();
	TextColumn get caminhoArquivoPdf => text().named('caminho_arquivo_pdf').withLength(min: 0, max: 250).nullable()();
	TextColumn get mensagem => text().named('mensagem').withLength(min: 0, max: 250).nullable()();
	TextColumn get localPagamento => text().named('local_pagamento').withLength(min: 0, max: 100).nullable()();
	TextColumn get layoutRemessa => text().named('layout_remessa').withLength(min: 0, max: 1).nullable()();
	TextColumn get aceite => text().named('aceite').withLength(min: 0, max: 1).nullable()();
	TextColumn get especie => text().named('especie').withLength(min: 0, max: 1).nullable()();
	TextColumn get carteira => text().named('carteira').withLength(min: 0, max: 3).nullable()();
	TextColumn get codigoConvenio => text().named('codigo_convenio').withLength(min: 0, max: 20).nullable()();
	TextColumn get codigoCedente => text().named('codigo_cedente').withLength(min: 0, max: 20).nullable()();
	RealColumn get taxaMulta => real().named('taxa_multa').nullable()();
	RealColumn get taxaJuro => real().named('taxa_juro').nullable()();
	IntColumn get diasProtesto => integer().named('dias_protesto').nullable()();
	TextColumn get nossoNumeroAnterior => text().named('nosso_numero_anterior').withLength(min: 0, max: 50).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FinConfiguracaoBoletoGrouped {
	FinConfiguracaoBoleto? finConfiguracaoBoleto; 
	BancoContaCaixa? bancoContaCaixa; 

  FinConfiguracaoBoletoGrouped({
		this.finConfiguracaoBoleto, 
		this.bancoContaCaixa, 

  });
}
