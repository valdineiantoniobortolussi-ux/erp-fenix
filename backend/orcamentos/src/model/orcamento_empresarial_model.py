from src import db
from src.model.orcamento_detalhe_model import OrcamentoDetalheModel
from src.model.orcamento_periodo_model import OrcamentoPeriodoModel


class OrcamentoEmpresarialModel(db.Model):
    __tablename__ = 'orcamento_empresarial'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(30))
    data_inicial = db.Column(db.DateTime)
    numero_periodos = db.Column(db.Integer)
    data_base = db.Column(db.DateTime)
    descricao = db.Column(db.Text)
    id_orcamento_periodo = db.Column(db.Integer, db.ForeignKey('orcamento_periodo.id'))

    orcamento_detalhe_model_list = db.relationship('OrcamentoDetalheModel', lazy='dynamic')
    orcamento_periodo_model = db.relationship('OrcamentoPeriodoModel', foreign_keys=[id_orcamento_periodo])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_orcamento_periodo = data.get('idOrcamentoPeriodo')
        self.nome = data.get('nome')
        self.data_inicial = data.get('dataInicial')
        self.numero_periodos = data.get('numeroPeriodos')
        self.data_base = data.get('dataBase')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'idOrcamentoPeriodo': self.id_orcamento_periodo,
            'nome': self.nome,
            'dataInicial': self.data_inicial.isoformat(),
            'numeroPeriodos': self.numero_periodos,
            'dataBase': self.data_base.isoformat(),
            'descricao': self.descricao,
            'orcamentoDetalheModelList': [orcamento_detalhe_model.serialize() for orcamento_detalhe_model in self.orcamento_detalhe_model_list],
            'orcamentoPeriodoModel': self.orcamento_periodo_model.serialize() if self.orcamento_periodo_model else None,
        }