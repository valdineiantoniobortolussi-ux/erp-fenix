from src import db
from src.model.produto_model import ProdutoModel


class PcpOpDetalheModel(db.Model):
    __tablename__ = 'pcp_op_detalhe'

    id = db.Column(db.Integer, primary_key=True)
    quantidade_produzir = db.Column(db.Float)
    quantidade_produzida = db.Column(db.Float)
    quantidade_entregue = db.Column(db.Float)
    custo_previsto = db.Column(db.Float)
    custo_realizado = db.Column(db.Float)
    id_pcp_op_cabecalho = db.Column(db.Integer, db.ForeignKey('pcp_op_cabecalho.id'))
    id_produto = db.Column(db.Integer, db.ForeignKey('produto.id'))

    produto_model = db.relationship('ProdutoModel', foreign_keys=[id_produto])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_pcp_op_cabecalho = data.get('idPcpOpCabecalho')
        self.id_produto = data.get('idProduto')
        self.quantidade_produzir = data.get('quantidadeProduzir')
        self.quantidade_produzida = data.get('quantidadeProduzida')
        self.quantidade_entregue = data.get('quantidadeEntregue')
        self.custo_previsto = data.get('custoPrevisto')
        self.custo_realizado = data.get('custoRealizado')

    def serialize(self):
        return {
            'id': self.id,
            'idPcpOpCabecalho': self.id_pcp_op_cabecalho,
            'idProduto': self.id_produto,
            'quantidadeProduzir': self.quantidade_produzir,
            'quantidadeProduzida': self.quantidade_produzida,
            'quantidadeEntregue': self.quantidade_entregue,
            'custoPrevisto': self.custo_previsto,
            'custoRealizado': self.custo_realizado,
            'produtoModel': self.produto_model.serialize() if self.produto_model else None,
        }