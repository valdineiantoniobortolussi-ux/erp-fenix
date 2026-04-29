from src import db
from src.model.cte_rodoviario_model import CteRodoviarioModel


class CteRodoviarioMotoristaModel(db.Model):
    __tablename__ = 'cte_rodoviario_motorista'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(60))
    cpf = db.Column(db.String(11))
    id_cte_rodoviario = db.Column(db.Integer, db.ForeignKey('cte_rodoviario.id'))

    cte_rodoviario_model = db.relationship('CteRodoviarioModel', foreign_keys=[id_cte_rodoviario])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_rodoviario = data.get('idCteRodoviario')
        self.nome = data.get('nome')
        self.cpf = data.get('cpf')

    def serialize(self):
        return {
            'id': self.id,
            'idCteRodoviario': self.id_cte_rodoviario,
            'nome': self.nome,
            'cpf': self.cpf,
            'cteRodoviarioModel': self.cte_rodoviario_model.serialize() if self.cte_rodoviario_model else None,
        }