from src import db
from src.model.simples_nacional_detalhe_model import SimplesNacionalDetalheModel


class SimplesNacionalCabecalhoModel(db.Model):
    __tablename__ = 'simples_nacional_cabecalho'

    id = db.Column(db.Integer, primary_key=True)
    vigencia_inicial = db.Column(db.DateTime)
    vigencia_final = db.Column(db.DateTime)
    anexo = db.Column(db.String(10))
    tabela = db.Column(db.String(10))

    simples_nacional_detalhe_model_list = db.relationship('SimplesNacionalDetalheModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.vigencia_inicial = data.get('vigenciaInicial')
        self.vigencia_final = data.get('vigenciaFinal')
        self.anexo = data.get('anexo')
        self.tabela = data.get('tabela')

    def serialize(self):
        return {
            'id': self.id,
            'vigenciaInicial': self.vigencia_inicial.isoformat(),
            'vigenciaFinal': self.vigencia_final.isoformat(),
            'anexo': self.anexo,
            'tabela': self.tabela,
            'simplesNacionalDetalheModelList': [simples_nacional_detalhe_model.serialize() for simples_nacional_detalhe_model in self.simples_nacional_detalhe_model_list],
        }