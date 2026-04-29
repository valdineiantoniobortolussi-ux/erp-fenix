from src import db
from src.model.tabela_preco_model import TabelaPrecoModel


class ClienteModel(db.Model):
    __tablename__ = 'cliente'

    id = db.Column(db.Integer, primary_key=True)
    desde = db.Column(db.DateTime)
    data_cadastro = db.Column(db.DateTime)
    taxa_desconto = db.Column(db.Float)
    limite_credito = db.Column(db.Float)
    observacao = db.Column(db.String(250))
    id_pessoa = db.Column(db.Integer, db.ForeignKey('pessoa.id'), unique=True)
    id_tabela_preco = db.Column(db.Integer, db.ForeignKey('tabela_preco.id'))

    tabela_preco_model = db.relationship('TabelaPrecoModel', foreign_keys=[id_tabela_preco])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_pessoa = data.get('idPessoa')
        self.id_tabela_preco = data.get('idTabelaPreco')
        self.desde = data.get('desde')
        self.data_cadastro = data.get('dataCadastro')
        self.taxa_desconto = data.get('taxaDesconto')
        self.limite_credito = data.get('limiteCredito')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idPessoa': self.id_pessoa,
            'idTabelaPreco': self.id_tabela_preco,
            'desde': self.desde.isoformat(),
            'dataCadastro': self.data_cadastro.isoformat(),
            'taxaDesconto': self.taxa_desconto,
            'limiteCredito': self.limite_credito,
            'observacao': self.observacao,
            'tabelaPrecoModel': self.tabela_preco_model.serialize() if self.tabela_preco_model else None,
        }