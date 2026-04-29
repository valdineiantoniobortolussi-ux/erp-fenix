import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilParametroModel {
	int? id;
	String? mascara;
	int? niveis;
	String? informarContaPor;
	String? compartilhaPlanoConta;
	String? compartilhaHistoricos;
	String? alteraLancamentoOutro;
	String? historicoObrigatorio;
	String? permiteLancamentoZerado;
	String? geraInformativoSped;
	String? spedFormaEscritDiario;
	String? spedNomeLivroDiario;
	String? assinaturaDireita;
	String? assinaturaEsquerda;
	String? contaAtivo;
	String? contaPassivo;
	String? contaPatrimonioLiquido;
	String? contaDepreciacaoAcumulada;
	String? contaCapitalSocial;
	String? contaResultadoExercicio;
	String? contaPrejuizoAcumulado;
	String? contaLucroAcumulado;
	String? contaTituloPagar;
	String? contaTituloReceber;
	String? contaJurosPassivo;
	String? contaJurosAtivo;
	String? contaDescontoObtido;
	String? contaDescontoConcedido;
	String? contaCmv;
	String? contaVenda;
	String? contaVendaServico;
	String? contaEstoque;
	String? contaApuraResultado;
	String? contaJurosApropriar;
	int? idHistPadraoResultado;
	int? idHistPadraoLucro;
	int? idHistPadraoPrejuizo;

	ContabilParametroModel({
		this.id,
		this.mascara,
		this.niveis,
		this.informarContaPor,
		this.compartilhaPlanoConta,
		this.compartilhaHistoricos,
		this.alteraLancamentoOutro,
		this.historicoObrigatorio,
		this.permiteLancamentoZerado,
		this.geraInformativoSped,
		this.spedFormaEscritDiario,
		this.spedNomeLivroDiario,
		this.assinaturaDireita,
		this.assinaturaEsquerda,
		this.contaAtivo,
		this.contaPassivo,
		this.contaPatrimonioLiquido,
		this.contaDepreciacaoAcumulada,
		this.contaCapitalSocial,
		this.contaResultadoExercicio,
		this.contaPrejuizoAcumulado,
		this.contaLucroAcumulado,
		this.contaTituloPagar,
		this.contaTituloReceber,
		this.contaJurosPassivo,
		this.contaJurosAtivo,
		this.contaDescontoObtido,
		this.contaDescontoConcedido,
		this.contaCmv,
		this.contaVenda,
		this.contaVendaServico,
		this.contaEstoque,
		this.contaApuraResultado,
		this.contaJurosApropriar,
		this.idHistPadraoResultado,
		this.idHistPadraoLucro,
		this.idHistPadraoPrejuizo,
	});

	static List<String> dbColumns = <String>[
		'id',
		'mascara',
		'niveis',
		'informar_conta_por',
		'compartilha_plano_conta',
		'compartilha_historicos',
		'altera_lancamento_outro',
		'historico_obrigatorio',
		'permite_lancamento_zerado',
		'gera_informativo_sped',
		'sped_forma_escrit_diario',
		'sped_nome_livro_diario',
		'assinatura_direita',
		'assinatura_esquerda',
		'conta_ativo',
		'conta_passivo',
		'conta_patrimonio_liquido',
		'conta_depreciacao_acumulada',
		'conta_capital_social',
		'conta_resultado_exercicio',
		'conta_prejuizo_acumulado',
		'conta_lucro_acumulado',
		'conta_titulo_pagar',
		'conta_titulo_receber',
		'conta_juros_passivo',
		'conta_juros_ativo',
		'conta_desconto_obtido',
		'conta_desconto_concedido',
		'conta_cmv',
		'conta_venda',
		'conta_venda_servico',
		'conta_estoque',
		'conta_apura_resultado',
		'conta_juros_apropriar',
		'id_hist_padrao_resultado',
		'id_hist_padrao_lucro',
		'id_hist_padrao_prejuizo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Mascara',
		'Niveis',
		'Informar Conta Por',
		'Compartilha Plano Conta',
		'Compartilha Historicos',
		'Altera Lancamento Outro',
		'Historico Obrigatorio',
		'Permite Lancamento Zerado',
		'Gera Informativo Sped',
		'Sped Forma Escrit Diario',
		'Sped Nome Livro Diario',
		'Assinatura Direita',
		'Assinatura Esquerda',
		'Conta Ativo',
		'Conta Passivo',
		'Conta Patrimonio Liquido',
		'Conta Depreciacao Acumulada',
		'Conta Capital Social',
		'Conta Resultado Exercicio',
		'Conta Prejuizo Acumulado',
		'Conta Lucro Acumulado',
		'Conta Titulo Pagar',
		'Conta Titulo Receber',
		'Conta Juros Passivo',
		'Conta Juros Ativo',
		'Conta Desconto Obtido',
		'Conta Desconto Concedido',
		'Conta Cmv',
		'Conta Venda',
		'Conta Venda Servico',
		'Conta Estoque',
		'Conta Apura Resultado',
		'Conta Juros Apropriar',
		'Id Hist Padrao Resultado',
		'Id Hist Padrao Lucro',
		'Id Hist Padrao Prejuizo',
	];

	ContabilParametroModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		mascara = jsonData['mascara'];
		niveis = jsonData['niveis'];
		informarContaPor = ContabilParametroDomain.getInformarContaPor(jsonData['informarContaPor']);
		compartilhaPlanoConta = ContabilParametroDomain.getCompartilhaPlanoConta(jsonData['compartilhaPlanoConta']);
		compartilhaHistoricos = ContabilParametroDomain.getCompartilhaHistoricos(jsonData['compartilhaHistoricos']);
		alteraLancamentoOutro = ContabilParametroDomain.getAlteraLancamentoOutro(jsonData['alteraLancamentoOutro']);
		historicoObrigatorio = ContabilParametroDomain.getHistoricoObrigatorio(jsonData['historicoObrigatorio']);
		permiteLancamentoZerado = ContabilParametroDomain.getPermiteLancamentoZerado(jsonData['permiteLancamentoZerado']);
		geraInformativoSped = ContabilParametroDomain.getGeraInformativoSped(jsonData['geraInformativoSped']);
		spedFormaEscritDiario = ContabilParametroDomain.getSpedFormaEscritDiario(jsonData['spedFormaEscritDiario']);
		spedNomeLivroDiario = jsonData['spedNomeLivroDiario'];
		assinaturaDireita = jsonData['assinaturaDireita'];
		assinaturaEsquerda = jsonData['assinaturaEsquerda'];
		contaAtivo = jsonData['contaAtivo'];
		contaPassivo = jsonData['contaPassivo'];
		contaPatrimonioLiquido = jsonData['contaPatrimonioLiquido'];
		contaDepreciacaoAcumulada = jsonData['contaDepreciacaoAcumulada'];
		contaCapitalSocial = jsonData['contaCapitalSocial'];
		contaResultadoExercicio = jsonData['contaResultadoExercicio'];
		contaPrejuizoAcumulado = jsonData['contaPrejuizoAcumulado'];
		contaLucroAcumulado = jsonData['contaLucroAcumulado'];
		contaTituloPagar = jsonData['contaTituloPagar'];
		contaTituloReceber = jsonData['contaTituloReceber'];
		contaJurosPassivo = jsonData['contaJurosPassivo'];
		contaJurosAtivo = jsonData['contaJurosAtivo'];
		contaDescontoObtido = jsonData['contaDescontoObtido'];
		contaDescontoConcedido = jsonData['contaDescontoConcedido'];
		contaCmv = jsonData['contaCmv'];
		contaVenda = jsonData['contaVenda'];
		contaVendaServico = jsonData['contaVendaServico'];
		contaEstoque = jsonData['contaEstoque'];
		contaApuraResultado = jsonData['contaApuraResultado'];
		contaJurosApropriar = jsonData['contaJurosApropriar'];
		idHistPadraoResultado = jsonData['idHistPadraoResultado'];
		idHistPadraoLucro = jsonData['idHistPadraoLucro'];
		idHistPadraoPrejuizo = jsonData['idHistPadraoPrejuizo'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['mascara'] = mascara;
		jsonData['niveis'] = niveis;
		jsonData['informarContaPor'] = ContabilParametroDomain.setInformarContaPor(informarContaPor);
		jsonData['compartilhaPlanoConta'] = ContabilParametroDomain.setCompartilhaPlanoConta(compartilhaPlanoConta);
		jsonData['compartilhaHistoricos'] = ContabilParametroDomain.setCompartilhaHistoricos(compartilhaHistoricos);
		jsonData['alteraLancamentoOutro'] = ContabilParametroDomain.setAlteraLancamentoOutro(alteraLancamentoOutro);
		jsonData['historicoObrigatorio'] = ContabilParametroDomain.setHistoricoObrigatorio(historicoObrigatorio);
		jsonData['permiteLancamentoZerado'] = ContabilParametroDomain.setPermiteLancamentoZerado(permiteLancamentoZerado);
		jsonData['geraInformativoSped'] = ContabilParametroDomain.setGeraInformativoSped(geraInformativoSped);
		jsonData['spedFormaEscritDiario'] = ContabilParametroDomain.setSpedFormaEscritDiario(spedFormaEscritDiario);
		jsonData['spedNomeLivroDiario'] = spedNomeLivroDiario;
		jsonData['assinaturaDireita'] = assinaturaDireita;
		jsonData['assinaturaEsquerda'] = assinaturaEsquerda;
		jsonData['contaAtivo'] = contaAtivo;
		jsonData['contaPassivo'] = contaPassivo;
		jsonData['contaPatrimonioLiquido'] = contaPatrimonioLiquido;
		jsonData['contaDepreciacaoAcumulada'] = contaDepreciacaoAcumulada;
		jsonData['contaCapitalSocial'] = contaCapitalSocial;
		jsonData['contaResultadoExercicio'] = contaResultadoExercicio;
		jsonData['contaPrejuizoAcumulado'] = contaPrejuizoAcumulado;
		jsonData['contaLucroAcumulado'] = contaLucroAcumulado;
		jsonData['contaTituloPagar'] = contaTituloPagar;
		jsonData['contaTituloReceber'] = contaTituloReceber;
		jsonData['contaJurosPassivo'] = contaJurosPassivo;
		jsonData['contaJurosAtivo'] = contaJurosAtivo;
		jsonData['contaDescontoObtido'] = contaDescontoObtido;
		jsonData['contaDescontoConcedido'] = contaDescontoConcedido;
		jsonData['contaCmv'] = contaCmv;
		jsonData['contaVenda'] = contaVenda;
		jsonData['contaVendaServico'] = contaVendaServico;
		jsonData['contaEstoque'] = contaEstoque;
		jsonData['contaApuraResultado'] = contaApuraResultado;
		jsonData['contaJurosApropriar'] = contaJurosApropriar;
		jsonData['idHistPadraoResultado'] = idHistPadraoResultado;
		jsonData['idHistPadraoLucro'] = idHistPadraoLucro;
		jsonData['idHistPadraoPrejuizo'] = idHistPadraoPrejuizo;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		mascara = plutoRow.cells['mascara']?.value;
		niveis = plutoRow.cells['niveis']?.value;
		informarContaPor = plutoRow.cells['informarContaPor']?.value != '' ? plutoRow.cells['informarContaPor']?.value : 'Código';
		compartilhaPlanoConta = plutoRow.cells['compartilhaPlanoConta']?.value != '' ? plutoRow.cells['compartilhaPlanoConta']?.value : 'Sim';
		compartilhaHistoricos = plutoRow.cells['compartilhaHistoricos']?.value != '' ? plutoRow.cells['compartilhaHistoricos']?.value : 'Sim';
		alteraLancamentoOutro = plutoRow.cells['alteraLancamentoOutro']?.value != '' ? plutoRow.cells['alteraLancamentoOutro']?.value : 'Sim';
		historicoObrigatorio = plutoRow.cells['historicoObrigatorio']?.value != '' ? plutoRow.cells['historicoObrigatorio']?.value : 'Sim';
		permiteLancamentoZerado = plutoRow.cells['permiteLancamentoZerado']?.value != '' ? plutoRow.cells['permiteLancamentoZerado']?.value : 'Sim';
		geraInformativoSped = plutoRow.cells['geraInformativoSped']?.value != '' ? plutoRow.cells['geraInformativoSped']?.value : 'Sim';
		spedFormaEscritDiario = plutoRow.cells['spedFormaEscritDiario']?.value != '' ? plutoRow.cells['spedFormaEscritDiario']?.value : 'Livro Diário Completo';
		spedNomeLivroDiario = plutoRow.cells['spedNomeLivroDiario']?.value;
		assinaturaDireita = plutoRow.cells['assinaturaDireita']?.value;
		assinaturaEsquerda = plutoRow.cells['assinaturaEsquerda']?.value;
		contaAtivo = plutoRow.cells['contaAtivo']?.value;
		contaPassivo = plutoRow.cells['contaPassivo']?.value;
		contaPatrimonioLiquido = plutoRow.cells['contaPatrimonioLiquido']?.value;
		contaDepreciacaoAcumulada = plutoRow.cells['contaDepreciacaoAcumulada']?.value;
		contaCapitalSocial = plutoRow.cells['contaCapitalSocial']?.value;
		contaResultadoExercicio = plutoRow.cells['contaResultadoExercicio']?.value;
		contaPrejuizoAcumulado = plutoRow.cells['contaPrejuizoAcumulado']?.value;
		contaLucroAcumulado = plutoRow.cells['contaLucroAcumulado']?.value;
		contaTituloPagar = plutoRow.cells['contaTituloPagar']?.value;
		contaTituloReceber = plutoRow.cells['contaTituloReceber']?.value;
		contaJurosPassivo = plutoRow.cells['contaJurosPassivo']?.value;
		contaJurosAtivo = plutoRow.cells['contaJurosAtivo']?.value;
		contaDescontoObtido = plutoRow.cells['contaDescontoObtido']?.value;
		contaDescontoConcedido = plutoRow.cells['contaDescontoConcedido']?.value;
		contaCmv = plutoRow.cells['contaCmv']?.value;
		contaVenda = plutoRow.cells['contaVenda']?.value;
		contaVendaServico = plutoRow.cells['contaVendaServico']?.value;
		contaEstoque = plutoRow.cells['contaEstoque']?.value;
		contaApuraResultado = plutoRow.cells['contaApuraResultado']?.value;
		contaJurosApropriar = plutoRow.cells['contaJurosApropriar']?.value;
		idHistPadraoResultado = plutoRow.cells['idHistPadraoResultado']?.value;
		idHistPadraoLucro = plutoRow.cells['idHistPadraoLucro']?.value;
		idHistPadraoPrejuizo = plutoRow.cells['idHistPadraoPrejuizo']?.value;
	}	

	ContabilParametroModel clone() {
		return ContabilParametroModel(
			id: id,
			mascara: mascara,
			niveis: niveis,
			informarContaPor: informarContaPor,
			compartilhaPlanoConta: compartilhaPlanoConta,
			compartilhaHistoricos: compartilhaHistoricos,
			alteraLancamentoOutro: alteraLancamentoOutro,
			historicoObrigatorio: historicoObrigatorio,
			permiteLancamentoZerado: permiteLancamentoZerado,
			geraInformativoSped: geraInformativoSped,
			spedFormaEscritDiario: spedFormaEscritDiario,
			spedNomeLivroDiario: spedNomeLivroDiario,
			assinaturaDireita: assinaturaDireita,
			assinaturaEsquerda: assinaturaEsquerda,
			contaAtivo: contaAtivo,
			contaPassivo: contaPassivo,
			contaPatrimonioLiquido: contaPatrimonioLiquido,
			contaDepreciacaoAcumulada: contaDepreciacaoAcumulada,
			contaCapitalSocial: contaCapitalSocial,
			contaResultadoExercicio: contaResultadoExercicio,
			contaPrejuizoAcumulado: contaPrejuizoAcumulado,
			contaLucroAcumulado: contaLucroAcumulado,
			contaTituloPagar: contaTituloPagar,
			contaTituloReceber: contaTituloReceber,
			contaJurosPassivo: contaJurosPassivo,
			contaJurosAtivo: contaJurosAtivo,
			contaDescontoObtido: contaDescontoObtido,
			contaDescontoConcedido: contaDescontoConcedido,
			contaCmv: contaCmv,
			contaVenda: contaVenda,
			contaVendaServico: contaVendaServico,
			contaEstoque: contaEstoque,
			contaApuraResultado: contaApuraResultado,
			contaJurosApropriar: contaJurosApropriar,
			idHistPadraoResultado: idHistPadraoResultado,
			idHistPadraoLucro: idHistPadraoLucro,
			idHistPadraoPrejuizo: idHistPadraoPrejuizo,
		);			
	}

	
}