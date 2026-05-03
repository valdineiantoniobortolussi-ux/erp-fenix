from src import db


class ProdutoModel(db.Model):
    __tablename__ = 'produto'

    id = db.Column(db.Integer, primary_key=True)
    id_tribut_icms_custom_cab = db.Column(db.Integer)
    id_tribut_grupo_tributario = db.Column(db.Integer)
    nome = db.Column(db.String(100))
    descricao = db.Column(db.String(250))
    gtin = db.Column(db.String(14))
    codigo_interno = db.Column(db.String(50))
    valor_compra = db.Column(db.Float)
    valor_venda = db.Column(db.Float)
    codigo_ncm = db.Column(db.String(8))
    estoque_minimo = db.Column(db.Float)
    estoque_maximo = db.Column(db.Float)
    quantidade_estoque = db.Column(db.Float)
    data_cadastro = db.Column(db.DateTime)


    def mapping(self, data):
        self.id = data.get('id')
        self.id_tribut_icms_custom_cab = data.get('idTributIcmsCustomCab')
        self.id_tribut_grupo_tributario = data.get('idTributGrupoTributario')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')
        self.gtin = data.get('gtin')
        self.codigo_interno = data.get('codigoInterno')
        self.valor_compra = data.get('valorCompra')
        self.valor_venda = data.get('valorVenda')
        self.codigo_ncm = data.get('codigoNcm')
        self.estoque_minimo = data.get('estoqueMinimo')
        self.estoque_maximo = data.get('estoqueMaximo')
        self.quantidade_estoque = data.get('quantidadeEstoque')
        self.data_cadastro = data.get('dataCadastro')

    def serialize(self):
        return {
            'id': self.id,
            'idTributIcmsCustomCab': self.id_tribut_icms_custom_cab,
            'idTributGrupoTributario': self.id_tribut_grupo_tributario,
            'nome': self.nome,
            'descricao': self.descricao,
            'gtin': self.gtin,
            'codigoInterno': self.codigo_interno,
            'valorCompra': self.valor_compra,
            'valorVenda': self.valor_venda,
            'codigoNcm': self.codigo_ncm,
            'estoqueMinimo': self.estoque_minimo,
            'estoqueMaximo': self.estoque_maximo,
            'quantidadeEstoque': self.quantidade_estoque,
            'dataCadastro': self.data_cadastro.isoformat(),
        }