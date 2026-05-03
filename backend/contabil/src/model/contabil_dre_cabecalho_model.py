from src import db
from src.model.contabil_dre_detalhe_model import ContabilDreDetalheModel


class ContabilDreCabecalhoModel(db.Model):
    __tablename__ = 'contabil_dre_cabecalho'

    id = db.Column(db.Integer, primary_key=True)
    descricao = db.Column(db.String(100))
    padrao = db.Column(db.String(1))
    periodo_inicial = db.Column(db.String(7))
    periodo_final = db.Column(db.String(7))

    contabil_dre_detalhe_model_list = db.relationship('ContabilDreDetalheModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.descricao = data.get('descricao')
        self.padrao = data.get('padrao')
        self.periodo_inicial = data.get('periodoInicial')
        self.periodo_final = data.get('periodoFinal')

    def serialize(self):
        return {
            'id': self.id,
            'descricao': self.descricao,
            'padrao': self.padrao,
            'periodoInicial': self.periodo_inicial,
            'periodoFinal': self.periodo_final,
            'contabilDreDetalheModelList': [contabil_dre_detalhe_model.serialize() for contabil_dre_detalhe_model in self.contabil_dre_detalhe_model_list],
        }