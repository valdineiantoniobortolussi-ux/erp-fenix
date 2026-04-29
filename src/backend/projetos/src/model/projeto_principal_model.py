from src import db
from src.model.projeto_cronograma_model import ProjetoCronogramaModel
from src.model.projeto_risco_model import ProjetoRiscoModel
from src.model.projeto_custo_model import ProjetoCustoModel
from src.model.projeto_stakeholders_model import ProjetoStakeholdersModel


class ProjetoPrincipalModel(db.Model):
    __tablename__ = 'projeto_principal'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    data_inicio = db.Column(db.DateTime)
    data_previsao_fim = db.Column(db.DateTime)
    data_fim = db.Column(db.DateTime)
    valor_orcamento = db.Column(db.Float)
    link_quadro_kanban = db.Column(db.String(100))
    observacao = db.Column(db.Text)

    projeto_cronograma_model_list = db.relationship('ProjetoCronogramaModel', lazy='dynamic')
    projeto_risco_model_list = db.relationship('ProjetoRiscoModel', lazy='dynamic')
    projeto_custo_model_list = db.relationship('ProjetoCustoModel', lazy='dynamic')
    projeto_stakeholders_model_list = db.relationship('ProjetoStakeholdersModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.data_inicio = data.get('dataInicio')
        self.data_previsao_fim = data.get('dataPrevisaoFim')
        self.data_fim = data.get('dataFim')
        self.valor_orcamento = data.get('valorOrcamento')
        self.link_quadro_kanban = data.get('linkQuadroKanban')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'dataInicio': self.data_inicio.isoformat(),
            'dataPrevisaoFim': self.data_previsao_fim.isoformat(),
            'dataFim': self.data_fim.isoformat(),
            'valorOrcamento': self.valor_orcamento,
            'linkQuadroKanban': self.link_quadro_kanban,
            'observacao': self.observacao,
            'projetoCronogramaModelList': [projeto_cronograma_model.serialize() for projeto_cronograma_model in self.projeto_cronograma_model_list],
            'projetoRiscoModelList': [projeto_risco_model.serialize() for projeto_risco_model in self.projeto_risco_model_list],
            'projetoCustoModelList': [projeto_custo_model.serialize() for projeto_custo_model in self.projeto_custo_model_list],
            'projetoStakeholdersModelList': [projeto_stakeholders_model.serialize() for projeto_stakeholders_model in self.projeto_stakeholders_model_list],
        }