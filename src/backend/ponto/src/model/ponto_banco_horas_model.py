from src import db
from src.model.ponto_banco_horas_utilizacao_model import PontoBancoHorasUtilizacaoModel
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel


class PontoBancoHorasModel(db.Model):
    __tablename__ = 'ponto_banco_horas'

    id = db.Column(db.Integer, primary_key=True)
    data_trabalho = db.Column(db.DateTime)
    quantidade = db.Column(db.String(8))
    situacao = db.Column(db.String(1))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    ponto_banco_horas_utilizacao_model_list = db.relationship('PontoBancoHorasUtilizacaoModel', lazy='dynamic')
    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_colaborador = data.get('idColaborador')
        self.data_trabalho = data.get('dataTrabalho')
        self.quantidade = data.get('quantidade')
        self.situacao = data.get('situacao')

    def serialize(self):
        return {
            'id': self.id,
            'idColaborador': self.id_colaborador,
            'dataTrabalho': self.data_trabalho.isoformat(),
            'quantidade': self.quantidade,
            'situacao': self.situacao,
            'pontoBancoHorasUtilizacaoModelList': [ponto_banco_horas_utilizacao_model.serialize() for ponto_banco_horas_utilizacao_model in self.ponto_banco_horas_utilizacao_model_list],
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
        }