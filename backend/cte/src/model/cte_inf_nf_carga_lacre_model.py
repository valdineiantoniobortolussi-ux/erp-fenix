from src import db
from src.model.cte_informacao_nf_carga_model import CteInformacaoNfCargaModel


class CteInfNfCargaLacreModel(db.Model):
    __tablename__ = 'cte_inf_nf_carga_lacre'

    id = db.Column(db.Integer, primary_key=True)
    numero = db.Column(db.String(20))
    quantidade_rateada = db.Column(db.Float)
    id_cte_informacao_nf_carga = db.Column(db.Integer, db.ForeignKey('cte_informacao_nf_carga.id'))

    cte_informacao_nf_carga_model = db.relationship('CteInformacaoNfCargaModel', foreign_keys=[id_cte_informacao_nf_carga])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_informacao_nf_carga = data.get('idCteInformacaoNfCarga')
        self.numero = data.get('numero')
        self.quantidade_rateada = data.get('quantidadeRateada')

    def serialize(self):
        return {
            'id': self.id,
            'idCteInformacaoNfCarga': self.id_cte_informacao_nf_carga,
            'numero': self.numero,
            'quantidadeRateada': self.quantidade_rateada,
            'cteInformacaoNfCargaModel': self.cte_informacao_nf_carga_model.serialize() if self.cte_informacao_nf_carga_model else None,
        }