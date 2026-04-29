from src import db
from src.model.cte_informacao_nf_transporte_model import CteInformacaoNfTransporteModel


class CteInfNfTransporteLacreModel(db.Model):
    __tablename__ = 'cte_inf_nf_transporte_lacre'

    id = db.Column(db.Integer, primary_key=True)
    numero = db.Column(db.String(20))
    id_cte_informacao_nf_transporte = db.Column(db.Integer, db.ForeignKey('cte_informacao_nf_transporte.id'))

    cte_informacao_nf_transporte_model = db.relationship('CteInformacaoNfTransporteModel', foreign_keys=[id_cte_informacao_nf_transporte])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_informacao_nf_transporte = data.get('idCteInformacaoNfTransporte')
        self.numero = data.get('numero')

    def serialize(self):
        return {
            'id': self.id,
            'idCteInformacaoNfTransporte': self.id_cte_informacao_nf_transporte,
            'numero': self.numero,
            'cteInformacaoNfTransporteModel': self.cte_informacao_nf_transporte_model.serialize() if self.cte_informacao_nf_transporte_model else None,
        }