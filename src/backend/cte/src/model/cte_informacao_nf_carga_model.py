from src import db
from src.model.cte_informacao_nf_outros_model import CteInformacaoNfOutrosModel


class CteInformacaoNfCargaModel(db.Model):
    __tablename__ = 'cte_informacao_nf_carga'

    id = db.Column(db.Integer, primary_key=True)
    tipo_unidade_carga = db.Column(db.String(1))
    id_unidade_carga = db.Column(db.String(20))
    id_cte_informacao_nf = db.Column(db.Integer, db.ForeignKey('cte_informacao_nf_outros.id'))

    cte_informacao_nf_outros_model = db.relationship('CteInformacaoNfOutrosModel', foreign_keys=[id_cte_informacao_nf])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_informacao_nf = data.get('idCteInformacaoNf')
        self.tipo_unidade_carga = data.get('tipoUnidadeCarga')
        self.id_unidade_carga = data.get('idUnidadeCarga')

    def serialize(self):
        return {
            'id': self.id,
            'idCteInformacaoNf': self.id_cte_informacao_nf,
            'tipoUnidadeCarga': self.tipo_unidade_carga,
            'idUnidadeCarga': self.id_unidade_carga,
            'cteInformacaoNfOutrosModel': self.cte_informacao_nf_outros_model.serialize() if self.cte_informacao_nf_outros_model else None,
        }