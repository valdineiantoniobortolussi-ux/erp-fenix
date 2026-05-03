import 'package:drift/drift.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';

@DataClassName("ContratoSolicitacaoServico")
class ContratoSolicitacaoServicos extends Table {
	@override
	String get tableName => 'contrato_solicitacao_servico';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idContratoTipoServico => integer().named('id_contrato_tipo_servico').nullable()();
	IntColumn get idSetor => integer().named('id_setor').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	IntColumn get idCliente => integer().named('id_cliente').nullable()();
	IntColumn get idFornecedor => integer().named('id_fornecedor').nullable()();
	DateTimeColumn get dataSolicitacao => dateTime().named('data_solicitacao').nullable()();
	DateTimeColumn get dataDesejadaInicio => dateTime().named('data_desejada_inicio').nullable()();
	TextColumn get urgente => text().named('urgente').withLength(min: 0, max: 1).nullable()();
	TextColumn get statusSolicitacao => text().named('status_solicitacao').withLength(min: 0, max: 1).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContratoSolicitacaoServicoGrouped {
	ContratoSolicitacaoServico? contratoSolicitacaoServico; 
	ViewPessoaColaborador? viewPessoaColaborador; 
	ViewPessoaCliente? viewPessoaCliente; 
	ViewPessoaFornecedor? viewPessoaFornecedor; 
	Setor? setor; 
	ContratoTipoServico? contratoTipoServico; 

  ContratoSolicitacaoServicoGrouped({
		this.contratoSolicitacaoServico, 
		this.viewPessoaColaborador, 
		this.viewPessoaCliente, 
		this.viewPessoaFornecedor, 
		this.setor, 
		this.contratoTipoServico, 

  });
}
