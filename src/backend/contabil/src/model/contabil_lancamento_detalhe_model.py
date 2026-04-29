from src import db
from src.model.contabil_historico_model import ContabilHistoricoModel
from src.model.contabil_conta_model import ContabilContaModel


class ContabilLancamentoDetalheModel(db.Model):
    __tablename__ = 'contabil_lancamento_detalhe'

    id = db.Column(db.Integer, primary_key=True)
    tipo = db.Column(db.String(1))
    valor = db.Column(db.Float)
    historico = db.Column(db.String(250))
    id_contabil_lancamento_cab = db.Column(db.Integer, db.ForeignKey('contabil_lancamento_cabecalho.id'))
    id_contabil_historico = db.Column(db.Integer, db.ForeignKey('contabil_historico.id'))
    id_contabil_conta = db.Column(db.Integer, db.ForeignKey('contabil_conta.id'))

    contabil_historico_model = db.relationship('ContabilHistoricoModel', foreign_keys=[id_contabil_historico])
    contabil_conta_model = db.relationship('ContabilContaModel', foreign_keys=[id_contabil_conta])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_contabil_lancamento_cab = data.get('idContabilLancamentoCab')
        self.id_contabil_conta = data.get('idContabilConta')
        self.id_contabil_historico = data.get('idContabilHistorico')
        self.tipo = data.get('tipo')
        self.valor = data.get('valor')
        self.historico = data.get('historico')

    def serialize(self):
        return {
            'id': self.id,
            'idContabilLancamentoCab': self.id_contabil_lancamento_cab,
            'idContabilConta': self.id_contabil_conta,
            'idContabilHistorico': self.id_contabil_historico,
            'tipo': self.tipo,
            'valor': self.valor,
            'historico': self.historico,
            'contabilHistoricoModel': self.contabil_historico_model.serialize() if self.contabil_historico_model else None,
            'contabilContaModel': self.contabil_conta_model.serialize() if self.contabil_conta_model else None,
        }