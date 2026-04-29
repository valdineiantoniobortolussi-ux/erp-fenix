from src import db
from src.model.contabil_lancamento_detalhe_model import ContabilLancamentoDetalheModel
from src.model.contabil_lote_model import ContabilLoteModel


class ContabilLancamentoCabecalhoModel(db.Model):
    __tablename__ = 'contabil_lancamento_cabecalho'

    id = db.Column(db.Integer, primary_key=True)
    data_lancamento = db.Column(db.DateTime)
    data_inclusao = db.Column(db.DateTime)
    tipo = db.Column(db.String(1))
    liberado = db.Column(db.String(1))
    valor = db.Column(db.Float)
    id_contabil_lote = db.Column(db.Integer, db.ForeignKey('contabil_lote.id'))

    contabil_lancamento_detalhe_model_list = db.relationship('ContabilLancamentoDetalheModel', lazy='dynamic')
    contabil_lote_model = db.relationship('ContabilLoteModel', foreign_keys=[id_contabil_lote])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_contabil_lote = data.get('idContabilLote')
        self.data_lancamento = data.get('dataLancamento')
        self.data_inclusao = data.get('dataInclusao')
        self.tipo = data.get('tipo')
        self.liberado = data.get('liberado')
        self.valor = data.get('valor')

    def serialize(self):
        return {
            'id': self.id,
            'idContabilLote': self.id_contabil_lote,
            'dataLancamento': self.data_lancamento.isoformat(),
            'dataInclusao': self.data_inclusao.isoformat(),
            'tipo': self.tipo,
            'liberado': self.liberado,
            'valor': self.valor,
            'contabilLancamentoDetalheModelList': [contabil_lancamento_detalhe_model.serialize() for contabil_lancamento_detalhe_model in self.contabil_lancamento_detalhe_model_list],
            'contabilLoteModel': self.contabil_lote_model.serialize() if self.contabil_lote_model else None,
        }