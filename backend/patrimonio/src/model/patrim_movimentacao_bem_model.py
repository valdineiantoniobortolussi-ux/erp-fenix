from src import db
from src.model.patrim_tipo_movimentacao_model import PatrimTipoMovimentacaoModel


class PatrimMovimentacaoBemModel(db.Model):
    __tablename__ = 'patrim_movimentacao_bem'

    id = db.Column(db.Integer, primary_key=True)
    data_movimentacao = db.Column(db.DateTime)
    responsavel = db.Column(db.String(50))
    id_patrim_bem = db.Column(db.Integer, db.ForeignKey('patrim_bem.id'))
    id_patrim_tipo_movimentacao = db.Column(db.Integer, db.ForeignKey('patrim_tipo_movimentacao.id'))

    patrim_tipo_movimentacao_model = db.relationship('PatrimTipoMovimentacaoModel', foreign_keys=[id_patrim_tipo_movimentacao])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_patrim_bem = data.get('idPatrimBem')
        self.id_patrim_tipo_movimentacao = data.get('idPatrimTipoMovimentacao')
        self.data_movimentacao = data.get('dataMovimentacao')
        self.responsavel = data.get('responsavel')

    def serialize(self):
        return {
            'id': self.id,
            'idPatrimBem': self.id_patrim_bem,
            'idPatrimTipoMovimentacao': self.id_patrim_tipo_movimentacao,
            'dataMovimentacao': self.data_movimentacao.isoformat(),
            'responsavel': self.responsavel,
            'patrimTipoMovimentacaoModel': self.patrim_tipo_movimentacao_model.serialize() if self.patrim_tipo_movimentacao_model else None,
        }