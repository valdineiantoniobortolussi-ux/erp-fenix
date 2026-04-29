from src import db
from src.model.ponto_abono_utilizacao_model import PontoAbonoUtilizacaoModel
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel


class PontoAbonoModel(db.Model):
    __tablename__ = 'ponto_abono'

    id = db.Column(db.Integer, primary_key=True)
    quantidade = db.Column(db.Integer)
    utilizado = db.Column(db.Integer)
    saldo = db.Column(db.Integer)
    data_cadastro = db.Column(db.DateTime)
    inicio_utilizacao = db.Column(db.DateTime)
    data_validade = db.Column(db.DateTime)
    observacao = db.Column(db.Text)
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    ponto_abono_utilizacao_model_list = db.relationship('PontoAbonoUtilizacaoModel', lazy='dynamic')
    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_colaborador = data.get('idColaborador')
        self.quantidade = data.get('quantidade')
        self.utilizado = data.get('utilizado')
        self.saldo = data.get('saldo')
        self.data_cadastro = data.get('dataCadastro')
        self.inicio_utilizacao = data.get('inicioUtilizacao')
        self.data_validade = data.get('dataValidade')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idColaborador': self.id_colaborador,
            'quantidade': self.quantidade,
            'utilizado': self.utilizado,
            'saldo': self.saldo,
            'dataCadastro': self.data_cadastro.isoformat(),
            'inicioUtilizacao': self.inicio_utilizacao.isoformat(),
            'dataValidade': self.data_validade.isoformat(),
            'observacao': self.observacao,
            'pontoAbonoUtilizacaoModelList': [ponto_abono_utilizacao_model.serialize() for ponto_abono_utilizacao_model in self.ponto_abono_utilizacao_model_list],
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
        }