from src import db
from src.model.cte_rodoviario_model import CteRodoviarioModel


class CteRodoviarioOccModel(db.Model):
    __tablename__ = 'cte_rodoviario_occ'

    id = db.Column(db.Integer, primary_key=True)
    serie = db.Column(db.String(3))
    numero = db.Column(db.Integer)
    data_emissao = db.Column(db.DateTime)
    cnpj = db.Column(db.String(14))
    codigo_interno = db.Column(db.String(10))
    ie = db.Column(db.String(14))
    uf = db.Column(db.String(2))
    telefone = db.Column(db.String(14))
    id_cte_rodoviario = db.Column(db.Integer, db.ForeignKey('cte_rodoviario.id'))

    cte_rodoviario_model = db.relationship('CteRodoviarioModel', foreign_keys=[id_cte_rodoviario])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_rodoviario = data.get('idCteRodoviario')
        self.serie = data.get('serie')
        self.numero = data.get('numero')
        self.data_emissao = data.get('dataEmissao')
        self.cnpj = data.get('cnpj')
        self.codigo_interno = data.get('codigoInterno')
        self.ie = data.get('ie')
        self.uf = data.get('uf')
        self.telefone = data.get('telefone')

    def serialize(self):
        return {
            'id': self.id,
            'idCteRodoviario': self.id_cte_rodoviario,
            'serie': self.serie,
            'numero': self.numero,
            'dataEmissao': self.data_emissao.isoformat(),
            'cnpj': self.cnpj,
            'codigoInterno': self.codigo_interno,
            'ie': self.ie,
            'uf': self.uf,
            'telefone': self.telefone,
            'cteRodoviarioModel': self.cte_rodoviario_model.serialize() if self.cte_rodoviario_model else None,
        }