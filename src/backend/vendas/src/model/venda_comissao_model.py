from src import db
from src.model.view_pessoa_vendedor_model import ViewPessoaVendedorModel


class VendaComissaoModel(db.Model):
    __tablename__ = 'venda_comissao'

    id = db.Column(db.Integer, primary_key=True)
    valor_venda = db.Column(db.Float)
    tipo_contabil = db.Column(db.String(1))
    valor_comissao = db.Column(db.Float)
    situacao = db.Column(db.String(1))
    data_lancamento = db.Column(db.DateTime)
    id_venda_cabecalho = db.Column(db.Integer, db.ForeignKey('venda_cabecalho.id'), unique=True)
    id_vendedor = db.Column(db.Integer, db.ForeignKey('view_pessoa_vendedor.id'))

    view_pessoa_vendedor_model = db.relationship('ViewPessoaVendedorModel', foreign_keys=[id_vendedor])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_venda_cabecalho = data.get('idVendaCabecalho')
        self.id_vendedor = data.get('idVendedor')
        self.valor_venda = data.get('valorVenda')
        self.tipo_contabil = data.get('tipoContabil')
        self.valor_comissao = data.get('valorComissao')
        self.situacao = data.get('situacao')
        self.data_lancamento = data.get('dataLancamento')

    def serialize(self):
        return {
            'id': self.id,
            'idVendaCabecalho': self.id_venda_cabecalho,
            'idVendedor': self.id_vendedor,
            'valorVenda': self.valor_venda,
            'tipoContabil': self.tipo_contabil,
            'valorComissao': self.valor_comissao,
            'situacao': self.situacao,
            'dataLancamento': self.data_lancamento.isoformat(),
            'viewPessoaVendedorModel': self.view_pessoa_vendedor_model.serialize() if self.view_pessoa_vendedor_model else None,
        }