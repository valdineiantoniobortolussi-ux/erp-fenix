from src import db
from src.model.empresa_transporte_itinerario_model import EmpresaTransporteItinerarioModel


class EmpresaTransporteModel(db.Model):
    __tablename__ = 'empresa_transporte'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    uf = db.Column(db.String(2))
    classificacao_contabil_conta = db.Column(db.String(30))

    empresa_transporte_itinerario_model_list = db.relationship('EmpresaTransporteItinerarioModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.uf = data.get('uf')
        self.classificacao_contabil_conta = data.get('classificacaoContabilConta')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'uf': self.uf,
            'classificacaoContabilConta': self.classificacao_contabil_conta,
            'empresaTransporteItinerarioModelList': [empresa_transporte_itinerario_model.serialize() for empresa_transporte_itinerario_model in self.empresa_transporte_itinerario_model_list],
        }