from src import db
from src.model.cte_informacao_nf_outros_model import CteInformacaoNfOutrosModel


class CteInformacaoNfTransporteModel(db.Model):
    __tablename__ = 'cte_informacao_nf_transporte'

    id = db.Column(db.Integer, primary_key=True)
    tipo_unidade_transporte = db.Column(db.String(1))
    id_unidade_transporte = db.Column(db.String(20))
    id_cte_informacao_nf = db.Column(db.Integer, db.ForeignKey('cte_informacao_nf_outros.id'))

    cte_informacao_nf_outros_model = db.relationship('CteInformacaoNfOutrosModel', foreign_keys=[id_cte_informacao_nf])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_informacao_nf = data.get('idCteInformacaoNf')
        self.tipo_unidade_transporte = data.get('tipoUnidadeTransporte')
        self.id_unidade_transporte = data.get('idUnidadeTransporte')

    def serialize(self):
        return {
            'id': self.id,
            'idCteInformacaoNf': self.id_cte_informacao_nf,
            'tipoUnidadeTransporte': self.tipo_unidade_transporte,
            'idUnidadeTransporte': self.id_unidade_transporte,
            'cteInformacaoNfOutrosModel': self.cte_informacao_nf_outros_model.serialize() if self.cte_informacao_nf_outros_model else None,
        }