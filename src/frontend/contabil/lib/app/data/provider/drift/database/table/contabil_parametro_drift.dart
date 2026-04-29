import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("ContabilParametro")
class ContabilParametros extends Table {
	@override
	String get tableName => 'contabil_parametro';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get mascara => text().named('mascara').withLength(min: 0, max: 30).nullable()();
	IntColumn get niveis => integer().named('niveis').nullable()();
	TextColumn get informarContaPor => text().named('informar_conta_por').withLength(min: 0, max: 1).nullable()();
	TextColumn get compartilhaPlanoConta => text().named('compartilha_plano_conta').withLength(min: 0, max: 1).nullable()();
	TextColumn get compartilhaHistoricos => text().named('compartilha_historicos').withLength(min: 0, max: 1).nullable()();
	TextColumn get alteraLancamentoOutro => text().named('altera_lancamento_outro').withLength(min: 0, max: 1).nullable()();
	TextColumn get historicoObrigatorio => text().named('historico_obrigatorio').withLength(min: 0, max: 1).nullable()();
	TextColumn get permiteLancamentoZerado => text().named('permite_lancamento_zerado').withLength(min: 0, max: 1).nullable()();
	TextColumn get geraInformativoSped => text().named('gera_informativo_sped').withLength(min: 0, max: 1).nullable()();
	TextColumn get spedFormaEscritDiario => text().named('sped_forma_escrit_diario').withLength(min: 0, max: 1).nullable()();
	TextColumn get spedNomeLivroDiario => text().named('sped_nome_livro_diario').withLength(min: 0, max: 100).nullable()();
	TextColumn get assinaturaDireita => text().named('assinatura_direita').nullable()();
	TextColumn get assinaturaEsquerda => text().named('assinatura_esquerda').nullable()();
	TextColumn get contaAtivo => text().named('conta_ativo').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaPassivo => text().named('conta_passivo').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaPatrimonioLiquido => text().named('conta_patrimonio_liquido').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaDepreciacaoAcumulada => text().named('conta_depreciacao_acumulada').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaCapitalSocial => text().named('conta_capital_social').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaResultadoExercicio => text().named('conta_resultado_exercicio').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaPrejuizoAcumulado => text().named('conta_prejuizo_acumulado').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaLucroAcumulado => text().named('conta_lucro_acumulado').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaTituloPagar => text().named('conta_titulo_pagar').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaTituloReceber => text().named('conta_titulo_receber').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaJurosPassivo => text().named('conta_juros_passivo').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaJurosAtivo => text().named('conta_juros_ativo').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaDescontoObtido => text().named('conta_desconto_obtido').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaDescontoConcedido => text().named('conta_desconto_concedido').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaCmv => text().named('conta_cmv').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaVenda => text().named('conta_venda').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaVendaServico => text().named('conta_venda_servico').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaEstoque => text().named('conta_estoque').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaApuraResultado => text().named('conta_apura_resultado').withLength(min: 0, max: 30).nullable()();
	TextColumn get contaJurosApropriar => text().named('conta_juros_apropriar').withLength(min: 0, max: 30).nullable()();
	IntColumn get idHistPadraoResultado => integer().named('id_hist_padrao_resultado').nullable()();
	IntColumn get idHistPadraoLucro => integer().named('id_hist_padrao_lucro').nullable()();
	IntColumn get idHistPadraoPrejuizo => integer().named('id_hist_padrao_prejuizo').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContabilParametroGrouped {
	ContabilParametro? contabilParametro; 

  ContabilParametroGrouped({
		this.contabilParametro, 

  });
}
