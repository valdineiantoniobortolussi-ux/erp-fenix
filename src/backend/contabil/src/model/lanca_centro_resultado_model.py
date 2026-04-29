from src import db
from src.model.centro_resultado_model import CentroResultadoModel


class LancaCentroResultadoModel(db.Model):
    __tablename__ = 'lanca_centro_resultado'

    id = db.Column(db.Integer, primary_key=True)
    valor = db.Column(db.Float)
    data_lancamento = db.Column(db.DateTime)
    data_inclusao = db.Column(db.DateTime)
    origem_de_rateio = db.Column(db.String(1))
    historico = db.Column(db.String(250))
    id_centro_resultado = db.Column(db.Integer, db.ForeignKey('centro_resultado.id'))

    centro_resultado_model = db.relationship('CentroResultadoModel', foreign_keys=[id_centro_resultado])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_centro_resultado = data.get('idCentroResultado')
        self.valor = data.get('valor')
        self.data_lancamento = data.get('dataLancamento')
        self.data_inclusao = data.get('dataInclusao')
        self.origem_de_rateio = data.get('origemDeRateio')
        self.historico = data.get('historico')

    def serialize(self):
        return {
            'id': self.id,
            'idCentroResultado': self.id_centro_resultado,
            'valor': self.valor,
            'dataLancamento': self.data_lancamento.isoformat(),
            'dataInclusao': self.data_inclusao.isoformat(),
            'origemDeRateio': self.origem_de_rateio,
            'historico': self.historico,
            'centroResultadoModel': self.centro_resultado_model.serialize() if self.centro_resultado_model else None,
        }