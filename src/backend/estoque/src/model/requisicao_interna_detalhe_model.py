from src import db
from src.model.produto_model import ProdutoModel


class RequisicaoInternaDetalheModel(db.Model):
    __tablename__ = 'requisicao_interna_detalhe'

    id = db.Column(db.Integer, primary_key=True)
    quantidade = db.Column(db.Float)
    id_requisicao_interna_cabecalho = db.Column(db.Integer, db.ForeignKey('requisicao_interna_cabecalho.id'))
    id_produto = db.Column(db.Integer, db.ForeignKey('produto.id'))

    produto_model = db.relationship('ProdutoModel', foreign_keys=[id_produto])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_requisicao_interna_cabecalho = data.get('idRequisicaoInternaCabecalho')
        self.id_produto = data.get('idProduto')
        self.quantidade = data.get('quantidade')

    def serialize(self):
        return {
            'id': self.id,
            'idRequisicaoInternaCabecalho': self.id_requisicao_interna_cabecalho,
            'idProduto': self.id_produto,
            'quantidade': self.quantidade,
            'produtoModel': self.produto_model.serialize() if self.produto_model else None,
        }