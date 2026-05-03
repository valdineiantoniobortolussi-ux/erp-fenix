from src import db
from src.model.mdfe_rodoviario_model import MdfeRodoviarioModel


class MdfeRodoviarioCiotModel(db.Model):
    __tablename__ = 'mdfe_rodoviario_ciot'

    id = db.Column(db.Integer, primary_key=True)
    ciot = db.Column(db.String(12))
    cpf = db.Column(db.String(11))
    cnpj = db.Column(db.String(14))
    id_mdfe_rodoviario = db.Column(db.Integer, db.ForeignKey('mdfe_rodoviario.id'))

    mdfe_rodoviario_model = db.relationship('MdfeRodoviarioModel', foreign_keys=[id_mdfe_rodoviario])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_mdfe_rodoviario = data.get('idMdfeRodoviario')
        self.ciot = data.get('ciot')
        self.cpf = data.get('cpf')
        self.cnpj = data.get('cnpj')

    def serialize(self):
        return {
            'id': self.id,
            'idMdfeRodoviario': self.id_mdfe_rodoviario,
            'ciot': self.ciot,
            'cpf': self.cpf,
            'cnpj': self.cnpj,
            'mdfeRodoviarioModel': self.mdfe_rodoviario_model.serialize() if self.mdfe_rodoviario_model else None,
        }