from src import db
from src.model.mdfe_rodoviario_model import MdfeRodoviarioModel


class MdfeRodoviarioMotoristaModel(db.Model):
    __tablename__ = 'mdfe_rodoviario_motorista'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(60))
    cpf = db.Column(db.String(11))
    id_mdfe_rodoviario = db.Column(db.Integer, db.ForeignKey('mdfe_rodoviario.id'))

    mdfe_rodoviario_model = db.relationship('MdfeRodoviarioModel', foreign_keys=[id_mdfe_rodoviario])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_mdfe_rodoviario = data.get('idMdfeRodoviario')
        self.nome = data.get('nome')
        self.cpf = data.get('cpf')

    def serialize(self):
        return {
            'id': self.id,
            'idMdfeRodoviario': self.id_mdfe_rodoviario,
            'nome': self.nome,
            'cpf': self.cpf,
            'mdfeRodoviarioModel': self.mdfe_rodoviario_model.serialize() if self.mdfe_rodoviario_model else None,
        }