from src import db
from src.model.compra_fornecedor_cotacao_model import CompraFornecedorCotacaoModel
from src.model.compra_requisicao_model import CompraRequisicaoModel
from src.model.compra_cotacao_detalhe_model import CompraCotacaoDetalheModel


class CompraCotacaoModel(db.Model):
    __tablename__ = 'compra_cotacao'

    id = db.Column(db.Integer, primary_key=True)
    data_cotacao = db.Column(db.DateTime)
    descricao = db.Column(db.String(100))
    id_compra_requisicao = db.Column(db.Integer, db.ForeignKey('compra_requisicao.id'))

    compra_fornecedor_cotacao_model_list = db.relationship('CompraFornecedorCotacaoModel', lazy='dynamic')
    compra_requisicao_model = db.relationship('CompraRequisicaoModel', foreign_keys=[id_compra_requisicao])
    compra_cotacao_detalhe_model_list = db.relationship('CompraCotacaoDetalheModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.id_compra_requisicao = data.get('idCompraRequisicao')
        self.data_cotacao = data.get('dataCotacao')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'idCompraRequisicao': self.id_compra_requisicao,
            'dataCotacao': self.data_cotacao.isoformat(),
            'descricao': self.descricao,
            'compraFornecedorCotacaoModelList': [compra_fornecedor_cotacao_model.serialize() for compra_fornecedor_cotacao_model in self.compra_fornecedor_cotacao_model_list],
            'compraRequisicaoModel': self.compra_requisicao_model.serialize() if self.compra_requisicao_model else None,
            'compraCotacaoDetalheModelList': [compra_cotacao_detalhe_model.serialize() for compra_cotacao_detalhe_model in self.compra_cotacao_detalhe_model_list],
        }