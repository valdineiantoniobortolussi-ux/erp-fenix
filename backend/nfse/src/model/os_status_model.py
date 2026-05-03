from src import db
from src.model.os_abertura_model import OsAberturaModel


class OsStatusModel(db.Model):
    __tablename__ = 'os_status'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(2))
    nome = db.Column(db.String(100))

    os_abertura_model_list = db.relationship('OsAberturaModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.nome = data.get('nome')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'nome': self.nome,
            'osAberturaModelList': [os_abertura_model.serialize() for os_abertura_model in self.os_abertura_model_list],
        }