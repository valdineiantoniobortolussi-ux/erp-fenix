from src import db
from src.model.comissao_perfil_model import ComissaoPerfilModel


class ComissaoObjetivoModel(db.Model):
    __tablename__ = 'comissao_objetivo'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(3))
    nome = db.Column(db.String(100))
    descricao = db.Column(db.Text)
    taxa_pagamento = db.Column(db.Float)
    valor_pagamento = db.Column(db.Float)
    valor_meta = db.Column(db.Float)
    data_inicio = db.Column(db.DateTime)
    data_fim = db.Column(db.DateTime)
    id_comissao_perfil = db.Column(db.Integer, db.ForeignKey('comissao_perfil.id'))

    comissao_perfil_model = db.relationship('ComissaoPerfilModel', foreign_keys=[id_comissao_perfil])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_comissao_perfil = data.get('idComissaoPerfil')
        self.codigo = data.get('codigo')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')
        self.taxa_pagamento = data.get('taxaPagamento')
        self.valor_pagamento = data.get('valorPagamento')
        self.valor_meta = data.get('valorMeta')
        self.data_inicio = data.get('dataInicio')
        self.data_fim = data.get('dataFim')

    def serialize(self):
        return {
            'id': self.id,
            'idComissaoPerfil': self.id_comissao_perfil,
            'codigo': self.codigo,
            'nome': self.nome,
            'descricao': self.descricao,
            'taxaPagamento': self.taxa_pagamento,
            'valorPagamento': self.valor_pagamento,
            'valorMeta': self.valor_meta,
            'dataInicio': self.data_inicio.isoformat(),
            'dataFim': self.data_fim.isoformat(),
            'comissaoPerfilModel': self.comissao_perfil_model.serialize() if self.comissao_perfil_model else None,
        }