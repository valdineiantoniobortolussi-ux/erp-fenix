from src import db


class NfeInformacaoPagamentoModel(db.Model):
    __tablename__ = 'nfe_informacao_pagamento'

    id = db.Column(db.Integer, primary_key=True)
    indicador_pagamento = db.Column(db.String(1))
    meio_pagamento = db.Column(db.String(2))
    valor = db.Column(db.Float)
    tipo_integracao = db.Column(db.String(1))
    cnpj_operadora_cartao = db.Column(db.String(14))
    bandeira = db.Column(db.String(2))
    numero_autorizacao = db.Column(db.String(20))
    troco = db.Column(db.Float)
    id_nfe_cabecalho = db.Column(db.Integer, db.ForeignKey('nfe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_cabecalho = data.get('idNfeCabecalho')
        self.indicador_pagamento = data.get('indicadorPagamento')
        self.meio_pagamento = data.get('meioPagamento')
        self.valor = data.get('valor')
        self.tipo_integracao = data.get('tipoIntegracao')
        self.cnpj_operadora_cartao = data.get('cnpjOperadoraCartao')
        self.bandeira = data.get('bandeira')
        self.numero_autorizacao = data.get('numeroAutorizacao')
        self.troco = data.get('troco')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeCabecalho': self.id_nfe_cabecalho,
            'indicadorPagamento': self.indicador_pagamento,
            'meioPagamento': self.meio_pagamento,
            'valor': self.valor,
            'tipoIntegracao': self.tipo_integracao,
            'cnpjOperadoraCartao': self.cnpj_operadora_cartao,
            'bandeira': self.bandeira,
            'numeroAutorizacao': self.numero_autorizacao,
            'troco': self.troco,
        }