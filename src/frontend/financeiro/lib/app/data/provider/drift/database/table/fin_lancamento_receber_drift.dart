import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';

@DataClassName("FinLancamentoReceber")
class FinLancamentoRecebers extends Table {
	@override
	String get tableName => 'fin_lancamento_receber';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCliente => integer().named('id_cliente').nullable()();
	IntColumn get idBancoContaCaixa => integer().named('id_banco_conta_caixa').nullable()();
	IntColumn get idFinDocumentoOrigem => integer().named('id_fin_documento_origem').nullable()();
	IntColumn get idFinNaturezaFinanceira => integer().named('id_fin_natureza_financeira').nullable()();
	IntColumn get quantidadeParcela => integer().named('quantidade_parcela').nullable()();
	RealColumn get valorAReceber => real().named('valor_a_receber').nullable()();
	DateTimeColumn get dataLancamento => dateTime().named('data_lancamento').nullable()();
	TextColumn get numeroDocumento => text().named('numero_documento').withLength(min: 0, max: 50).nullable()();
	DateTimeColumn get primeiroVencimento => dateTime().named('primeiro_vencimento').nullable()();
	RealColumn get taxaComissao => real().named('taxa_comissao').nullable()();
	RealColumn get valorComissao => real().named('valor_comissao').nullable()();
	IntColumn get intervaloEntreParcelas => integer().named('intervalo_entre_parcelas').nullable()();
	TextColumn get diaFixo => text().named('dia_fixo').withLength(min: 0, max: 2).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FinLancamentoReceberGrouped {
	FinLancamentoReceber? finLancamentoReceber; 
	List<FinParcelaReceberGrouped>? finParcelaReceberGroupedList; 
	FinDocumentoOrigem? finDocumentoOrigem; 
	BancoContaCaixa? bancoContaCaixa; 
	FinNaturezaFinanceira? finNaturezaFinanceira; 
	ViewPessoaCliente? viewPessoaCliente; 

  FinLancamentoReceberGrouped({
		this.finLancamentoReceber, 
		this.finParcelaReceberGroupedList, 
		this.finDocumentoOrigem, 
		this.bancoContaCaixa, 
		this.finNaturezaFinanceira, 
		this.viewPessoaCliente, 

  });
}
