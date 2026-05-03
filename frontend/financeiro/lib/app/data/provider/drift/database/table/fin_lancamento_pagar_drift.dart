import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';

@DataClassName("FinLancamentoPagar")
class FinLancamentoPagars extends Table {
	@override
	String get tableName => 'fin_lancamento_pagar';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get imagemDocumento => text().named('imagem_documento').nullable()();
	IntColumn get idFornecedor => integer().named('id_fornecedor').nullable()();
	IntColumn get idBancoContaCaixa => integer().named('id_banco_conta_caixa').nullable()();
	IntColumn get idFinDocumentoOrigem => integer().named('id_fin_documento_origem').nullable()();
	IntColumn get idFinNaturezaFinanceira => integer().named('id_fin_natureza_financeira').nullable()();
	IntColumn get quantidadeParcela => integer().named('quantidade_parcela').nullable()();
	RealColumn get valorAPagar => real().named('valor_a_pagar').nullable()();
	DateTimeColumn get dataLancamento => dateTime().named('data_lancamento').nullable()();
	TextColumn get numeroDocumento => text().named('numero_documento').withLength(min: 0, max: 50).nullable()();
	DateTimeColumn get primeiroVencimento => dateTime().named('primeiro_vencimento').nullable()();
	IntColumn get intervaloEntreParcelas => integer().named('intervalo_entre_parcelas').nullable()();
	TextColumn get diaFixo => text().named('dia_fixo').withLength(min: 0, max: 2).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FinLancamentoPagarGrouped {
	FinLancamentoPagar? finLancamentoPagar; 
	List<FinParcelaPagarGrouped>? finParcelaPagarGroupedList; 
	FinDocumentoOrigem? finDocumentoOrigem; 
	BancoContaCaixa? bancoContaCaixa; 
	FinNaturezaFinanceira? finNaturezaFinanceira; 
	ViewPessoaFornecedor? viewPessoaFornecedor; 

  FinLancamentoPagarGrouped({
		this.finLancamentoPagar, 
		this.finParcelaPagarGroupedList, 
		this.finDocumentoOrigem, 
		this.bancoContaCaixa, 
		this.finNaturezaFinanceira, 
		this.viewPessoaFornecedor, 

  });
}
