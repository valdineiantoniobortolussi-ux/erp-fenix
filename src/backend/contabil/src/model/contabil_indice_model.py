from src import db
from src.model.contabil_indice_valor_model import ContabilIndiceValorModel


class ContabilIndiceModel(db.Model):
    __tablename__ = 'contabil_indice'

    id = db.Column(db.Integer, primary_key=True)
    indice = db.Column(db.String(50))
    periodicidade = db.Column(db.String(1))
    diario_a_partir_de = db.Column(db.DateTime)
    mensal_mes_ano = db.Column(db.String(7))

    contabil_indice_valor_model_list = db.relationship('ContabilIndiceValorModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.indice = data.get('indice')
        self.periodicidade = data.get('periodicidade')
        self.diario_a_partir_de = data.get('diarioAPartirDe')
        self.mensal_mes_ano = data.get('mensalMesAno')

    def serialize(self):
        return {
            'id': self.id,
            'indice': self.indice,
            'periodicidade': self.periodicidade,
            'diarioAPartirDe': self.diario_a_partir_de.isoformat(),
            'mensalMesAno': self.mensal_mes_ano,
            'contabilIndiceValorModelList': [contabil_indice_valor_model.serialize() for contabil_indice_valor_model in self.contabil_indice_valor_model_list],
        }