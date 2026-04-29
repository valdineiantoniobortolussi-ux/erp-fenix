from src import db
from src.model.mdfe_rodoviario_model import MdfeRodoviarioModel


class MdfeRodoviarioPedagioModel(db.Model):
    __tablename__ = 'mdfe_rodoviario_pedagio'

    id = db.Column(db.Integer, primary_key=True)
    cnpj_fornecedor = db.Column(db.String(14))
    cnpj_responsavel = db.Column(db.String(14))
    cpf_responsavel = db.Column(db.String(11))
    numero_comprovante = db.Column(db.String(20))
    valor = db.Column(db.Float)
    id_mdfe_rodoviario = db.Column(db.Integer, db.ForeignKey('mdfe_rodoviario.id'))

    mdfe_rodoviario_model = db.relationship('MdfeRodoviarioModel', foreign_keys=[id_mdfe_rodoviario])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_mdfe_rodoviario = data.get('idMdfeRodoviario')
        self.cnpj_fornecedor = data.get('cnpjFornecedor')
        self.cnpj_responsavel = data.get('cnpjResponsavel')
        self.cpf_responsavel = data.get('cpfResponsavel')
        self.numero_comprovante = data.get('numeroComprovante')
        self.valor = data.get('valor')

    def serialize(self):
        return {
            'id': self.id,
            'idMdfeRodoviario': self.id_mdfe_rodoviario,
            'cnpjFornecedor': self.cnpj_fornecedor,
            'cnpjResponsavel': self.cnpj_responsavel,
            'cpfResponsavel': self.cpf_responsavel,
            'numeroComprovante': self.numero_comprovante,
            'valor': self.valor,
            'mdfeRodoviarioModel': self.mdfe_rodoviario_model.serialize() if self.mdfe_rodoviario_model else None,
        }