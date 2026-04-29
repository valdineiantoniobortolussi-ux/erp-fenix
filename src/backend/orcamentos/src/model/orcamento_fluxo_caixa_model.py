from src import db
from src.model.orcamento_fluxo_caixa_detalhe_model import OrcamentoFluxoCaixaDetalheModel
from src.model.orcamento_fluxo_caixa_periodo_model import OrcamentoFluxoCaixaPeriodoModel


class OrcamentoFluxoCaixaModel(db.Model):
    __tablename__ = 'orcamento_fluxo_caixa'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(30))
    data_inicial = db.Column(db.DateTime)
    numero_periodos = db.Column(db.Integer)
    data_base = db.Column(db.DateTime)
    descricao = db.Column(db.Text)
    id_orc_fluxo_caixa_periodo = db.Column(db.Integer, db.ForeignKey('orcamento_fluxo_caixa_periodo.id'))

    orcamento_fluxo_caixa_detalhe_model_list = db.relationship('OrcamentoFluxoCaixaDetalheModel', lazy='dynamic')
    orcamento_fluxo_caixa_periodo_model = db.relationship('OrcamentoFluxoCaixaPeriodoModel', foreign_keys=[id_orc_fluxo_caixa_periodo])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_orc_fluxo_caixa_periodo = data.get('idOrcFluxoCaixaPeriodo')
        self.nome = data.get('nome')
        self.data_inicial = data.get('dataInicial')
        self.numero_periodos = data.get('numeroPeriodos')
        self.data_base = data.get('dataBase')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'idOrcFluxoCaixaPeriodo': self.id_orc_fluxo_caixa_periodo,
            'nome': self.nome,
            'dataInicial': self.data_inicial.isoformat(),
            'numeroPeriodos': self.numero_periodos,
            'dataBase': self.data_base.isoformat(),
            'descricao': self.descricao,
            'orcamentoFluxoCaixaDetalheModelList': [orcamento_fluxo_caixa_detalhe_model.serialize() for orcamento_fluxo_caixa_detalhe_model in self.orcamento_fluxo_caixa_detalhe_model_list],
            'orcamentoFluxoCaixaPeriodoModel': self.orcamento_fluxo_caixa_periodo_model.serialize() if self.orcamento_fluxo_caixa_periodo_model else None,
        }