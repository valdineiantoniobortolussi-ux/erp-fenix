from src import db
from src.model.cte_rodoviario_model import CteRodoviarioModel


class CteRodoviarioLacreModel(db.Model):
    __tablename__ = 'cte_rodoviario_lacre'

    id = db.Column(db.Integer, primary_key=True)
    numero = db.Column(db.String(20))
    id_cte_rodoviario = db.Column(db.Integer, db.ForeignKey('cte_rodoviario.id'))

    cte_rodoviario_model = db.relationship('CteRodoviarioModel', foreign_keys=[id_cte_rodoviario])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_rodoviario = data.get('idCteRodoviario')
        self.numero = data.get('numero')

    def serialize(self):
        return {
            'id': self.id,
            'idCteRodoviario': self.id_cte_rodoviario,
            'numero': self.numero,
            'cteRodoviarioModel': self.cte_rodoviario_model.serialize() if self.cte_rodoviario_model else None,
        }