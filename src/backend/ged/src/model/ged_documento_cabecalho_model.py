from src import db
from src.model.ged_documento_detalhe_model import GedDocumentoDetalheModel


class GedDocumentoCabecalhoModel(db.Model):
    __tablename__ = 'ged_documento_cabecalho'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    data_inclusao = db.Column(db.DateTime)
    descricao = db.Column(db.String(250))

    ged_documento_detalhe_model_list = db.relationship('GedDocumentoDetalheModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.data_inclusao = data.get('dataInclusao')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'dataInclusao': self.data_inclusao.isoformat(),
            'descricao': self.descricao,
            'gedDocumentoDetalheModelList': [ged_documento_detalhe_model.serialize() for ged_documento_detalhe_model in self.ged_documento_detalhe_model_list],
        }