from src import db
from src.model.cte_rodoviario_model import CteRodoviarioModel


class CteRodoviarioPedagioModel(db.Model):
    __tablename__ = 'cte_rodoviario_pedagio'

    id = db.Column(db.Integer, primary_key=True)
    cnpj_fornecedor = db.Column(db.String(14))
    comprovante_compra = db.Column(db.String(20))
    cnpj_responsavel = db.Column(db.String(14))
    valor = db.Column(db.Float)
    id_cte_rodoviario = db.Column(db.Integer, db.ForeignKey('cte_rodoviario.id'))

    cte_rodoviario_model = db.relationship('CteRodoviarioModel', foreign_keys=[id_cte_rodoviario])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_rodoviario = data.get('idCteRodoviario')
        self.cnpj_fornecedor = data.get('cnpjFornecedor')
        self.comprovante_compra = data.get('comprovanteCompra')
        self.cnpj_responsavel = data.get('cnpjResponsavel')
        self.valor = data.get('valor')

    def serialize(self):
        return {
            'id': self.id,
            'idCteRodoviario': self.id_cte_rodoviario,
            'cnpjFornecedor': self.cnpj_fornecedor,
            'comprovanteCompra': self.comprovante_compra,
            'cnpjResponsavel': self.cnpj_responsavel,
            'valor': self.valor,
            'cteRodoviarioModel': self.cte_rodoviario_model.serialize() if self.cte_rodoviario_model else None,
        }