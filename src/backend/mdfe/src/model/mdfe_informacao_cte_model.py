from src import db
from src.model.mdfe_municipio_descarrega_model import MdfeMunicipioDescarregaModel


class MdfeInformacaoCteModel(db.Model):
    __tablename__ = 'mdfe_informacao_cte'

    id = db.Column(db.Integer, primary_key=True)
    chave_cte = db.Column(db.String(44))
    segundo_codigo_barra = db.Column(db.String(36))
    indicador_reentrega = db.Column(db.Integer)
    id_mdfe_municipio_descarrega = db.Column(db.Integer, db.ForeignKey('mdfe_municipio_descarrega.id'))

    mdfe_municipio_descarrega_model = db.relationship('MdfeMunicipioDescarregaModel', foreign_keys=[id_mdfe_municipio_descarrega])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_mdfe_municipio_descarrega = data.get('idMdfeMunicipioDescarrega')
        self.chave_cte = data.get('chaveCte')
        self.segundo_codigo_barra = data.get('segundoCodigoBarra')
        self.indicador_reentrega = data.get('indicadorReentrega')

    def serialize(self):
        return {
            'id': self.id,
            'idMdfeMunicipioDescarrega': self.id_mdfe_municipio_descarrega,
            'chaveCte': self.chave_cte,
            'segundoCodigoBarra': self.segundo_codigo_barra,
            'indicadorReentrega': self.indicador_reentrega,
            'mdfeMunicipioDescarregaModel': self.mdfe_municipio_descarrega_model.serialize() if self.mdfe_municipio_descarrega_model else None,
        }