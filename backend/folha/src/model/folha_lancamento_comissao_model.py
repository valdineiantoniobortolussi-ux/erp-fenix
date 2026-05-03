from src import db
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel


class FolhaLancamentoComissaoModel(db.Model):
    __tablename__ = 'folha_lancamento_comissao'

    id = db.Column(db.Integer, primary_key=True)
    competencia = db.Column(db.String(7))
    vencimento = db.Column(db.DateTime)
    base_calculo = db.Column(db.Float)
    valor_comissao = db.Column(db.Float)
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_colaborador = data.get('idColaborador')
        self.competencia = data.get('competencia')
        self.vencimento = data.get('vencimento')
        self.base_calculo = data.get('baseCalculo')
        self.valor_comissao = data.get('valorComissao')

    def serialize(self):
        return {
            'id': self.id,
            'idColaborador': self.id_colaborador,
            'competencia': self.competencia,
            'vencimento': self.vencimento.isoformat(),
            'baseCalculo': self.base_calculo,
            'valorComissao': self.valor_comissao,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
        }