from src import db
from src.model.centro_resultado_model import CentroResultadoModel


class EncerraCentroResultadoModel(db.Model):
    __tablename__ = 'encerra_centro_resultado'

    id = db.Column(db.Integer, primary_key=True)
    competencia = db.Column(db.String(7))
    valor_total = db.Column(db.Float)
    valor_sub_rateio = db.Column(db.Float)
    id_centro_resultado = db.Column(db.Integer, db.ForeignKey('centro_resultado.id'))

    centro_resultado_model = db.relationship('CentroResultadoModel', foreign_keys=[id_centro_resultado])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_centro_resultado = data.get('idCentroResultado')
        self.competencia = data.get('competencia')
        self.valor_total = data.get('valorTotal')
        self.valor_sub_rateio = data.get('valorSubRateio')

    def serialize(self):
        return {
            'id': self.id,
            'idCentroResultado': self.id_centro_resultado,
            'competencia': self.competencia,
            'valorTotal': self.valor_total,
            'valorSubRateio': self.valor_sub_rateio,
            'centroResultadoModel': self.centro_resultado_model.serialize() if self.centro_resultado_model else None,
        }