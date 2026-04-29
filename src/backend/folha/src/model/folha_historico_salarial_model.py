from src import db
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel


class FolhaHistoricoSalarialModel(db.Model):
    __tablename__ = 'folha_historico_salarial'

    id = db.Column(db.Integer, primary_key=True)
    competencia = db.Column(db.String(7))
    salario_atual = db.Column(db.Float)
    percentual_aumento = db.Column(db.Float)
    salario_novo = db.Column(db.Float)
    valido_a_partir = db.Column(db.String(7))
    motivo = db.Column(db.String(100))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_colaborador = data.get('idColaborador')
        self.competencia = data.get('competencia')
        self.salario_atual = data.get('salarioAtual')
        self.percentual_aumento = data.get('percentualAumento')
        self.salario_novo = data.get('salarioNovo')
        self.valido_a_partir = data.get('validoAPartir')
        self.motivo = data.get('motivo')

    def serialize(self):
        return {
            'id': self.id,
            'idColaborador': self.id_colaborador,
            'competencia': self.competencia,
            'salarioAtual': self.salario_atual,
            'percentualAumento': self.percentual_aumento,
            'salarioNovo': self.salario_novo,
            'validoAPartir': self.valido_a_partir,
            'motivo': self.motivo,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
        }