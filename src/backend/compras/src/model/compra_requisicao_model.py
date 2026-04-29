from src import db
from src.model.compra_requisicao_detalhe_model import CompraRequisicaoDetalheModel
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel
from src.model.compra_tipo_requisicao_model import CompraTipoRequisicaoModel


class CompraRequisicaoModel(db.Model):
    __tablename__ = 'compra_requisicao'

    id = db.Column(db.Integer, primary_key=True)
    descricao = db.Column(db.String(100))
    data_requisicao = db.Column(db.DateTime)
    observacao = db.Column(db.Text)
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))
    id_compra_tipo_requisicao = db.Column(db.Integer, db.ForeignKey('compra_tipo_requisicao.id'))

    compra_requisicao_detalhe_model_list = db.relationship('CompraRequisicaoDetalheModel', lazy='dynamic')
    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])
    compra_tipo_requisicao_model = db.relationship('CompraTipoRequisicaoModel', foreign_keys=[id_compra_tipo_requisicao])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_compra_tipo_requisicao = data.get('idCompraTipoRequisicao')
        self.id_colaborador = data.get('idColaborador')
        self.descricao = data.get('descricao')
        self.data_requisicao = data.get('dataRequisicao')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idCompraTipoRequisicao': self.id_compra_tipo_requisicao,
            'idColaborador': self.id_colaborador,
            'descricao': self.descricao,
            'dataRequisicao': self.data_requisicao.isoformat(),
            'observacao': self.observacao,
            'compraRequisicaoDetalheModelList': [compra_requisicao_detalhe_model.serialize() for compra_requisicao_detalhe_model in self.compra_requisicao_detalhe_model_list],
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
            'compraTipoRequisicaoModel': self.compra_tipo_requisicao_model.serialize() if self.compra_tipo_requisicao_model else None,
        }