from src import db
from src.model.venda_condicoes_parcelas_model import VendaCondicoesParcelasModel


class VendaCondicoesPagamentoModel(db.Model):
    __tablename__ = 'venda_condicoes_pagamento'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(50))
    descricao = db.Column(db.Text)
    faturamento_minimo = db.Column(db.Float)
    faturamento_maximo = db.Column(db.Float)
    indice_correcao = db.Column(db.Float)
    dias_tolerancia = db.Column(db.Integer)
    valor_tolerancia = db.Column(db.Float)
    prazo_medio = db.Column(db.Integer)
    vista_prazo = db.Column(db.String(1))

    venda_condicoes_parcelas_model_list = db.relationship('VendaCondicoesParcelasModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')
        self.faturamento_minimo = data.get('faturamentoMinimo')
        self.faturamento_maximo = data.get('faturamentoMaximo')
        self.indice_correcao = data.get('indiceCorrecao')
        self.dias_tolerancia = data.get('diasTolerancia')
        self.valor_tolerancia = data.get('valorTolerancia')
        self.prazo_medio = data.get('prazoMedio')
        self.vista_prazo = data.get('vistaPrazo')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'descricao': self.descricao,
            'faturamentoMinimo': self.faturamento_minimo,
            'faturamentoMaximo': self.faturamento_maximo,
            'indiceCorrecao': self.indice_correcao,
            'diasTolerancia': self.dias_tolerancia,
            'valorTolerancia': self.valor_tolerancia,
            'prazoMedio': self.prazo_medio,
            'vistaPrazo': self.vista_prazo,
            'vendaCondicoesParcelasModelList': [venda_condicoes_parcelas_model.serialize() for venda_condicoes_parcelas_model in self.venda_condicoes_parcelas_model_list],
        }