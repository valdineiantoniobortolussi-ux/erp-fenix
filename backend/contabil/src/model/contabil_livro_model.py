from src import db
from src.model.contabil_termo_model import ContabilTermoModel


class ContabilLivroModel(db.Model):
    __tablename__ = 'contabil_livro'

    id = db.Column(db.Integer, primary_key=True)
    competencia = db.Column(db.String(7))
    forma_escrituracao = db.Column(db.String(1))
    descricao = db.Column(db.String(100))

    contabil_termo_model_list = db.relationship('ContabilTermoModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.competencia = data.get('competencia')
        self.forma_escrituracao = data.get('formaEscrituracao')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'competencia': self.competencia,
            'formaEscrituracao': self.forma_escrituracao,
            'descricao': self.descricao,
            'contabilTermoModelList': [contabil_termo_model.serialize() for contabil_termo_model in self.contabil_termo_model_list],
        }