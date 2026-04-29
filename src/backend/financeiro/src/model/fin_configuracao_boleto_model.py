from src import db
from src.model.banco_conta_caixa_model import BancoContaCaixaModel


class FinConfiguracaoBoletoModel(db.Model):
    __tablename__ = 'fin_configuracao_boleto'

    id = db.Column(db.Integer, primary_key=True)
    instrucao01 = db.Column(db.String(100))
    instrucao02 = db.Column(db.String(100))
    caminho_arquivo_remessa = db.Column(db.String(250))
    caminho_arquivo_retorno = db.Column(db.String(250))
    caminho_arquivo_logotipo = db.Column(db.String(250))
    caminho_arquivo_pdf = db.Column(db.String(250))
    mensagem = db.Column(db.String(250))
    local_pagamento = db.Column(db.String(100))
    layout_remessa = db.Column(db.String(1))
    aceite = db.Column(db.String(1))
    especie = db.Column(db.String(1))
    carteira = db.Column(db.String(3))
    codigo_convenio = db.Column(db.String(20))
    codigo_cedente = db.Column(db.String(20))
    taxa_multa = db.Column(db.Float)
    taxa_juro = db.Column(db.Float)
    dias_protesto = db.Column(db.Integer)
    nosso_numero_anterior = db.Column(db.String(50))
    id_banco_conta_caixa = db.Column(db.Integer, db.ForeignKey('banco_conta_caixa.id'))

    banco_conta_caixa_model = db.relationship('BancoContaCaixaModel', foreign_keys=[id_banco_conta_caixa])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_banco_conta_caixa = data.get('idBancoContaCaixa')
        self.instrucao01 = data.get('instrucao01')
        self.instrucao02 = data.get('instrucao02')
        self.caminho_arquivo_remessa = data.get('caminhoArquivoRemessa')
        self.caminho_arquivo_retorno = data.get('caminhoArquivoRetorno')
        self.caminho_arquivo_logotipo = data.get('caminhoArquivoLogotipo')
        self.caminho_arquivo_pdf = data.get('caminhoArquivoPdf')
        self.mensagem = data.get('mensagem')
        self.local_pagamento = data.get('localPagamento')
        self.layout_remessa = data.get('layoutRemessa')
        self.aceite = data.get('aceite')
        self.especie = data.get('especie')
        self.carteira = data.get('carteira')
        self.codigo_convenio = data.get('codigoConvenio')
        self.codigo_cedente = data.get('codigoCedente')
        self.taxa_multa = data.get('taxaMulta')
        self.taxa_juro = data.get('taxaJuro')
        self.dias_protesto = data.get('diasProtesto')
        self.nosso_numero_anterior = data.get('nossoNumeroAnterior')

    def serialize(self):
        return {
            'id': self.id,
            'idBancoContaCaixa': self.id_banco_conta_caixa,
            'instrucao01': self.instrucao01,
            'instrucao02': self.instrucao02,
            'caminhoArquivoRemessa': self.caminho_arquivo_remessa,
            'caminhoArquivoRetorno': self.caminho_arquivo_retorno,
            'caminhoArquivoLogotipo': self.caminho_arquivo_logotipo,
            'caminhoArquivoPdf': self.caminho_arquivo_pdf,
            'mensagem': self.mensagem,
            'localPagamento': self.local_pagamento,
            'layoutRemessa': self.layout_remessa,
            'aceite': self.aceite,
            'especie': self.especie,
            'carteira': self.carteira,
            'codigoConvenio': self.codigo_convenio,
            'codigoCedente': self.codigo_cedente,
            'taxaMulta': self.taxa_multa,
            'taxaJuro': self.taxa_juro,
            'diasProtesto': self.dias_protesto,
            'nossoNumeroAnterior': self.nosso_numero_anterior,
            'bancoContaCaixaModel': self.banco_conta_caixa_model.serialize() if self.banco_conta_caixa_model else None,
        }