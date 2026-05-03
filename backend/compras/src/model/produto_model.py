from src import db
from src.model.produto_marca_model import ProdutoMarcaModel
from src.model.tribut_icms_custom_cab_model import TributIcmsCustomCabModel
from src.model.tribut_grupo_tributario_model import TributGrupoTributarioModel
from src.model.produto_unidade_model import ProdutoUnidadeModel
from src.model.produto_subgrupo_model import ProdutoSubgrupoModel


class ProdutoModel(db.Model):
    __tablename__ = 'produto'

    id = db.Column(db.Integer, primary_key=True)
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
    id_produto_marca = db.Column(db.Integer, db.ForeignKey('produto_marca.id'))
    id_tribut_icms_custom_cab = db.Column(db.Integer, db.ForeignKey('tribut_icms_custom_cab.id'))
    id_tribut_grupo_tributario = db.Column(db.Integer, db.ForeignKey('tribut_grupo_tributario.id'))
    id_produto_unidade = db.Column(db.Integer, db.ForeignKey('produto_unidade.id'))
    id_produto_subgrupo = db.Column(db.Integer, db.ForeignKey('produto_subgrupo.id'))

    produto_marca_model = db.relationship('ProdutoMarcaModel', foreign_keys=[id_produto_marca])
    tribut_icms_custom_cab_model = db.relationship('TributIcmsCustomCabModel', foreign_keys=[id_tribut_icms_custom_cab])
    tribut_grupo_tributario_model = db.relationship('TributGrupoTributarioModel', foreign_keys=[id_tribut_grupo_tributario])
    produto_unidade_model = db.relationship('ProdutoUnidadeModel', foreign_keys=[id_produto_unidade])
    produto_subgrupo_model = db.relationship('ProdutoSubgrupoModel', foreign_keys=[id_produto_subgrupo])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_produto_subgrupo = data.get('idProdutoSubgrupo')
        self.id_produto_marca = data.get('idProdutoMarca')
        self.id_produto_unidade = data.get('idProdutoUnidade')
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
            'idProdutoSubgrupo': self.id_produto_subgrupo,
            'idProdutoMarca': self.id_produto_marca,
            'idProdutoUnidade': self.id_produto_unidade,
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
            'produtoMarcaModel': self.produto_marca_model.serialize() if self.produto_marca_model else None,
            'tributIcmsCustomCabModel': self.tribut_icms_custom_cab_model.serialize() if self.tribut_icms_custom_cab_model else None,
            'tributGrupoTributarioModel': self.tribut_grupo_tributario_model.serialize() if self.tribut_grupo_tributario_model else None,
            'produtoUnidadeModel': self.produto_unidade_model.serialize() if self.produto_unidade_model else None,
            'produtoSubgrupoModel': self.produto_subgrupo_model.serialize() if self.produto_subgrupo_model else None,
        }