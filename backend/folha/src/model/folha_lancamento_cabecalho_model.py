from src import db
from src.model.folha_lancamento_detalhe_model import FolhaLancamentoDetalheModel
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel


class FolhaLancamentoCabecalhoModel(db.Model):
    __tablename__ = 'folha_lancamento_cabecalho'

    id = db.Column(db.Integer, primary_key=True)
    competencia = db.Column(db.String(7))
    tipo = db.Column(db.String(1))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    folha_lancamento_detalhe_model_list = db.relationship('FolhaLancamentoDetalheModel', lazy='dynamic')
    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_colaborador = data.get('idColaborador')
        self.competencia = data.get('competencia')
        self.tipo = data.get('tipo')

    def serialize(self):
        return {
            'id': self.id,
            'idColaborador': self.id_colaborador,
            'competencia': self.competencia,
            'tipo': self.tipo,
            'folhaLancamentoDetalheModelList': [folha_lancamento_detalhe_model.serialize() for folha_lancamento_detalhe_model in self.folha_lancamento_detalhe_model_list],
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
        }