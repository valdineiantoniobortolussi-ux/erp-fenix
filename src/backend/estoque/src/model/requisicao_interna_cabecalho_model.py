from src import db
from src.model.requisicao_interna_detalhe_model import RequisicaoInternaDetalheModel
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel


class RequisicaoInternaCabecalhoModel(db.Model):
    __tablename__ = 'requisicao_interna_cabecalho'

    id = db.Column(db.Integer, primary_key=True)
    data_requisicao = db.Column(db.DateTime)
    situacao = db.Column(db.String(1))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    requisicao_interna_detalhe_model_list = db.relationship('RequisicaoInternaDetalheModel', lazy='dynamic')
    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_colaborador = data.get('idColaborador')
        self.data_requisicao = data.get('dataRequisicao')
        self.situacao = data.get('situacao')

    def serialize(self):
        return {
            'id': self.id,
            'idColaborador': self.id_colaborador,
            'dataRequisicao': self.data_requisicao.isoformat(),
            'situacao': self.situacao,
            'requisicaoInternaDetalheModelList': [requisicao_interna_detalhe_model.serialize() for requisicao_interna_detalhe_model in self.requisicao_interna_detalhe_model_list],
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
        }