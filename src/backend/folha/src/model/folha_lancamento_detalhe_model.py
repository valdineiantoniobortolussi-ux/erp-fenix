from src import db
from src.model.folha_evento_model import FolhaEventoModel


class FolhaLancamentoDetalheModel(db.Model):
    __tablename__ = 'folha_lancamento_detalhe'

    id = db.Column(db.Integer, primary_key=True)
    origem = db.Column(db.Float)
    provento = db.Column(db.Float)
    desconto = db.Column(db.Float)
    id_folha_lancamento_cabecalho = db.Column(db.Integer, db.ForeignKey('folha_lancamento_cabecalho.id'))
    id_folha_evento = db.Column(db.Integer, db.ForeignKey('folha_evento.id'))

    folha_evento_model = db.relationship('FolhaEventoModel', foreign_keys=[id_folha_evento])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_folha_lancamento_cabecalho = data.get('idFolhaLancamentoCabecalho')
        self.id_folha_evento = data.get('idFolhaEvento')
        self.origem = data.get('origem')
        self.provento = data.get('provento')
        self.desconto = data.get('desconto')

    def serialize(self):
        return {
            'id': self.id,
            'idFolhaLancamentoCabecalho': self.id_folha_lancamento_cabecalho,
            'idFolhaEvento': self.id_folha_evento,
            'origem': self.origem,
            'provento': self.provento,
            'desconto': self.desconto,
            'folhaEventoModel': self.folha_evento_model.serialize() if self.folha_evento_model else None,
        }