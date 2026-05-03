from src import db
from src.model.gondola_rua_model import GondolaRuaModel


class GondolaEstanteModel(db.Model):
    __tablename__ = 'gondola_estante'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(10))
    quantidade_caixa = db.Column(db.Integer)
    id_gondola_rua = db.Column(db.Integer, db.ForeignKey('gondola_rua.id'))

    gondola_rua_model = db.relationship('GondolaRuaModel', foreign_keys=[id_gondola_rua])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_gondola_rua = data.get('idGondolaRua')
        self.codigo = data.get('codigo')
        self.quantidade_caixa = data.get('quantidadeCaixa')

    def serialize(self):
        return {
            'id': self.id,
            'idGondolaRua': self.id_gondola_rua,
            'codigo': self.codigo,
            'quantidadeCaixa': self.quantidade_caixa,
            'gondolaRuaModel': self.gondola_rua_model.serialize() if self.gondola_rua_model else None,
        }