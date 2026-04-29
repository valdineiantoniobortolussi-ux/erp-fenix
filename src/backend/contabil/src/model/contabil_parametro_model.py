from src import db


class ContabilParametroModel(db.Model):
    __tablename__ = 'contabil_parametro'

    id = db.Column(db.Integer, primary_key=True)
    mascara = db.Column(db.String(30))
    niveis = db.Column(db.Integer)
    informar_conta_por = db.Column(db.String(1))
    compartilha_plano_conta = db.Column(db.String(1))
    compartilha_historicos = db.Column(db.String(1))
    altera_lancamento_outro = db.Column(db.String(1))
    historico_obrigatorio = db.Column(db.String(1))
    permite_lancamento_zerado = db.Column(db.String(1))
    gera_informativo_sped = db.Column(db.String(1))
    sped_forma_escrit_diario = db.Column(db.String(1))
    sped_nome_livro_diario = db.Column(db.String(100))
    assinatura_direita = db.Column(db.Text)
    assinatura_esquerda = db.Column(db.Text)
    conta_ativo = db.Column(db.String(30))
    conta_passivo = db.Column(db.String(30))
    conta_patrimonio_liquido = db.Column(db.String(30))
    conta_depreciacao_acumulada = db.Column(db.String(30))
    conta_capital_social = db.Column(db.String(30))
    conta_resultado_exercicio = db.Column(db.String(30))
    conta_prejuizo_acumulado = db.Column(db.String(30))
    conta_lucro_acumulado = db.Column(db.String(30))
    conta_titulo_pagar = db.Column(db.String(30))
    conta_titulo_receber = db.Column(db.String(30))
    conta_juros_passivo = db.Column(db.String(30))
    conta_juros_ativo = db.Column(db.String(30))
    conta_desconto_obtido = db.Column(db.String(30))
    conta_desconto_concedido = db.Column(db.String(30))
    conta_cmv = db.Column(db.String(30))
    conta_venda = db.Column(db.String(30))
    conta_venda_servico = db.Column(db.String(30))
    conta_estoque = db.Column(db.String(30))
    conta_apura_resultado = db.Column(db.String(30))
    conta_juros_apropriar = db.Column(db.String(30))
    id_hist_padrao_resultado = db.Column(db.Integer)
    id_hist_padrao_lucro = db.Column(db.Integer)
    id_hist_padrao_prejuizo = db.Column(db.Integer)


    def mapping(self, data):
        self.id = data.get('id')
        self.mascara = data.get('mascara')
        self.niveis = data.get('niveis')
        self.informar_conta_por = data.get('informarContaPor')
        self.compartilha_plano_conta = data.get('compartilhaPlanoConta')
        self.compartilha_historicos = data.get('compartilhaHistoricos')
        self.altera_lancamento_outro = data.get('alteraLancamentoOutro')
        self.historico_obrigatorio = data.get('historicoObrigatorio')
        self.permite_lancamento_zerado = data.get('permiteLancamentoZerado')
        self.gera_informativo_sped = data.get('geraInformativoSped')
        self.sped_forma_escrit_diario = data.get('spedFormaEscritDiario')
        self.sped_nome_livro_diario = data.get('spedNomeLivroDiario')
        self.assinatura_direita = data.get('assinaturaDireita')
        self.assinatura_esquerda = data.get('assinaturaEsquerda')
        self.conta_ativo = data.get('contaAtivo')
        self.conta_passivo = data.get('contaPassivo')
        self.conta_patrimonio_liquido = data.get('contaPatrimonioLiquido')
        self.conta_depreciacao_acumulada = data.get('contaDepreciacaoAcumulada')
        self.conta_capital_social = data.get('contaCapitalSocial')
        self.conta_resultado_exercicio = data.get('contaResultadoExercicio')
        self.conta_prejuizo_acumulado = data.get('contaPrejuizoAcumulado')
        self.conta_lucro_acumulado = data.get('contaLucroAcumulado')
        self.conta_titulo_pagar = data.get('contaTituloPagar')
        self.conta_titulo_receber = data.get('contaTituloReceber')
        self.conta_juros_passivo = data.get('contaJurosPassivo')
        self.conta_juros_ativo = data.get('contaJurosAtivo')
        self.conta_desconto_obtido = data.get('contaDescontoObtido')
        self.conta_desconto_concedido = data.get('contaDescontoConcedido')
        self.conta_cmv = data.get('contaCmv')
        self.conta_venda = data.get('contaVenda')
        self.conta_venda_servico = data.get('contaVendaServico')
        self.conta_estoque = data.get('contaEstoque')
        self.conta_apura_resultado = data.get('contaApuraResultado')
        self.conta_juros_apropriar = data.get('contaJurosApropriar')
        self.id_hist_padrao_resultado = data.get('idHistPadraoResultado')
        self.id_hist_padrao_lucro = data.get('idHistPadraoLucro')
        self.id_hist_padrao_prejuizo = data.get('idHistPadraoPrejuizo')

    def serialize(self):
        return {
            'id': self.id,
            'mascara': self.mascara,
            'niveis': self.niveis,
            'informarContaPor': self.informar_conta_por,
            'compartilhaPlanoConta': self.compartilha_plano_conta,
            'compartilhaHistoricos': self.compartilha_historicos,
            'alteraLancamentoOutro': self.altera_lancamento_outro,
            'historicoObrigatorio': self.historico_obrigatorio,
            'permiteLancamentoZerado': self.permite_lancamento_zerado,
            'geraInformativoSped': self.gera_informativo_sped,
            'spedFormaEscritDiario': self.sped_forma_escrit_diario,
            'spedNomeLivroDiario': self.sped_nome_livro_diario,
            'assinaturaDireita': self.assinatura_direita,
            'assinaturaEsquerda': self.assinatura_esquerda,
            'contaAtivo': self.conta_ativo,
            'contaPassivo': self.conta_passivo,
            'contaPatrimonioLiquido': self.conta_patrimonio_liquido,
            'contaDepreciacaoAcumulada': self.conta_depreciacao_acumulada,
            'contaCapitalSocial': self.conta_capital_social,
            'contaResultadoExercicio': self.conta_resultado_exercicio,
            'contaPrejuizoAcumulado': self.conta_prejuizo_acumulado,
            'contaLucroAcumulado': self.conta_lucro_acumulado,
            'contaTituloPagar': self.conta_titulo_pagar,
            'contaTituloReceber': self.conta_titulo_receber,
            'contaJurosPassivo': self.conta_juros_passivo,
            'contaJurosAtivo': self.conta_juros_ativo,
            'contaDescontoObtido': self.conta_desconto_obtido,
            'contaDescontoConcedido': self.conta_desconto_concedido,
            'contaCmv': self.conta_cmv,
            'contaVenda': self.conta_venda,
            'contaVendaServico': self.conta_venda_servico,
            'contaEstoque': self.conta_estoque,
            'contaApuraResultado': self.conta_apura_resultado,
            'contaJurosApropriar': self.conta_juros_apropriar,
            'idHistPadraoResultado': self.id_hist_padrao_resultado,
            'idHistPadraoLucro': self.id_hist_padrao_lucro,
            'idHistPadraoPrejuizo': self.id_hist_padrao_prejuizo,
        }