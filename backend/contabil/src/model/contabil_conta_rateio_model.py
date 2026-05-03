from src import db
from src.model.contabil_conta_model import ContabilContaModel
from src.model.centro_resultado_model import CentroResultadoModel


class ContabilContaRateioModel(db.Model):
    __tablename__ = 'contabil_conta_rateio'

    id = db.Column(db.Integer, primary_key=True)
    porcento_rateio = db.Column(db.Float)
    id_contabil_conta = db.Column(db.Integer, db.ForeignKey('contabil_conta.id'))
    id_centro_resultado = db.Column(db.Integer, db.ForeignKey('centro_resultado.id'))

    contabil_conta_model = db.relationship('ContabilContaModel', foreign_keys=[id_contabil_conta])
    centro_resultado_model = db.relationship('CentroResultadoModel', foreign_keys=[id_centro_resultado])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_centro_resultado = data.get('idCentroResultado')
        self.id_contabil_conta = data.get('idContabilConta')
        self.porcento_rateio = data.get('porcentoRateio')

    def serialize(self):
        return {
            'id': self.id,
            'idCentroResultado': self.id_centro_resultado,
            'idContabilConta': self.id_contabil_conta,
            'porcentoRateio': self.porcento_rateio,
            'contabilContaModel': self.contabil_conta_model.serialize() if self.contabil_conta_model else None,
            'centroResultadoModel': self.centro_resultado_model.serialize() if self.centro_resultado_model else None,
        }