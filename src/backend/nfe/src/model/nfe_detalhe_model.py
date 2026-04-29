from src import db
from src.model.nfe_det_especifico_veiculo_model import NfeDetEspecificoVeiculoModel
from src.model.nfe_det_especifico_medicamento_model import NfeDetEspecificoMedicamentoModel
from src.model.nfe_det_especifico_armamento_model import NfeDetEspecificoArmamentoModel
from src.model.nfe_det_especifico_combustivel_model import NfeDetEspecificoCombustivelModel
from src.model.nfe_declaracao_importacao_model import NfeDeclaracaoImportacaoModel
from src.model.nfe_detalhe_imposto_icms_model import NfeDetalheImpostoIcmsModel
from src.model.nfe_detalhe_imposto_ipi_model import NfeDetalheImpostoIpiModel
from src.model.nfe_detalhe_imposto_ii_model import NfeDetalheImpostoIiModel
from src.model.nfe_detalhe_imposto_pis_model import NfeDetalheImpostoPisModel
from src.model.nfe_detalhe_imposto_cofins_model import NfeDetalheImpostoCofinsModel
from src.model.nfe_detalhe_imposto_issqn_model import NfeDetalheImpostoIssqnModel
from src.model.nfe_exportacao_model import NfeExportacaoModel
from src.model.nfe_item_rastreado_model import NfeItemRastreadoModel
from src.model.nfe_detalhe_imposto_pis_st_model import NfeDetalheImpostoPisStModel
from src.model.nfe_detalhe_imposto_icms_ufdest_model import NfeDetalheImpostoIcmsUfdestModel
from src.model.nfe_detalhe_imposto_cofins_st_model import NfeDetalheImpostoCofinsStModel
from src.model.nfe_cabecalho_model import NfeCabecalhoModel
from src.model.produto_model import ProdutoModel


class NfeDetalheModel(db.Model):
    __tablename__ = 'nfe_detalhe'

    id = db.Column(db.Integer, primary_key=True)
    numero_item = db.Column(db.Integer)
    codigo_produto = db.Column(db.String(60))
    gtin = db.Column(db.String(14))
    nome_produto = db.Column(db.String(120))
    ncm = db.Column(db.String(8))
    nve = db.Column(db.String(6))
    cest = db.Column(db.String(7))
    indicador_escala_relevante = db.Column(db.String(1))
    cnpj_fabricante = db.Column(db.String(14))
    codigo_beneficio_fiscal = db.Column(db.String(10))
    ex_tipi = db.Column(db.Integer)
    cfop = db.Column(db.Integer)
    unidade_comercial = db.Column(db.String(6))
    quantidade_comercial = db.Column(db.Float)
    numero_pedido_compra = db.Column(db.String(15))
    item_pedido_compra = db.Column(db.Integer)
    numero_fci = db.Column(db.String(36))
    numero_recopi = db.Column(db.String(20))
    valor_unitario_comercial = db.Column(db.Float)
    valor_bruto_produto = db.Column(db.Float)
    gtin_unidade_tributavel = db.Column(db.String(14))
    unidade_tributavel = db.Column(db.String(6))
    quantidade_tributavel = db.Column(db.Float)
    valor_unitario_tributavel = db.Column(db.Float)
    valor_frete = db.Column(db.Float)
    valor_seguro = db.Column(db.Float)
    valor_desconto = db.Column(db.Float)
    valor_outras_despesas = db.Column(db.Float)
    entra_total = db.Column(db.String(1))
    valor_total_tributos = db.Column(db.Float)
    percentual_devolvido = db.Column(db.Float)
    valor_ipi_devolvido = db.Column(db.Float)
    informacoes_adicionais = db.Column(db.Text)
    valor_subtotal = db.Column(db.Float)
    valor_total = db.Column(db.Float)
    id_nfe_cabecalho = db.Column(db.Integer, db.ForeignKey('nfe_cabecalho.id'))
    id_produto = db.Column(db.Integer, db.ForeignKey('produto.id'))

    nfe_det_especifico_veiculo_model_list = db.relationship('NfeDetEspecificoVeiculoModel', lazy='dynamic')
    nfe_det_especifico_medicamento_model_list = db.relationship('NfeDetEspecificoMedicamentoModel', lazy='dynamic')
    nfe_det_especifico_armamento_model_list = db.relationship('NfeDetEspecificoArmamentoModel', lazy='dynamic')
    nfe_det_especifico_combustivel_model_list = db.relationship('NfeDetEspecificoCombustivelModel', lazy='dynamic')
    nfe_declaracao_importacao_model_list = db.relationship('NfeDeclaracaoImportacaoModel', lazy='dynamic')
    nfe_detalhe_imposto_icms_model_list = db.relationship('NfeDetalheImpostoIcmsModel', lazy='dynamic')
    nfe_detalhe_imposto_ipi_model_list = db.relationship('NfeDetalheImpostoIpiModel', lazy='dynamic')
    nfe_detalhe_imposto_ii_model_list = db.relationship('NfeDetalheImpostoIiModel', lazy='dynamic')
    nfe_detalhe_imposto_pis_model_list = db.relationship('NfeDetalheImpostoPisModel', lazy='dynamic')
    nfe_detalhe_imposto_cofins_model_list = db.relationship('NfeDetalheImpostoCofinsModel', lazy='dynamic')
    nfe_detalhe_imposto_issqn_model_list = db.relationship('NfeDetalheImpostoIssqnModel', lazy='dynamic')
    nfe_exportacao_model_list = db.relationship('NfeExportacaoModel', lazy='dynamic')
    nfe_item_rastreado_model_list = db.relationship('NfeItemRastreadoModel', lazy='dynamic')
    nfe_detalhe_imposto_pis_st_model_list = db.relationship('NfeDetalheImpostoPisStModel', lazy='dynamic')
    nfe_detalhe_imposto_icms_ufdest_model_list = db.relationship('NfeDetalheImpostoIcmsUfdestModel', lazy='dynamic')
    nfe_detalhe_imposto_cofins_st_model_list = db.relationship('NfeDetalheImpostoCofinsStModel', lazy='dynamic')
    nfe_cabecalho_model = db.relationship('NfeCabecalhoModel', foreign_keys=[id_nfe_cabecalho])
    produto_model = db.relationship('ProdutoModel', foreign_keys=[id_produto])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_cabecalho = data.get('idNfeCabecalho')
        self.id_produto = data.get('idProduto')
        self.numero_item = data.get('numeroItem')
        self.codigo_produto = data.get('codigoProduto')
        self.gtin = data.get('gtin')
        self.nome_produto = data.get('nomeProduto')
        self.ncm = data.get('ncm')
        self.nve = data.get('nve')
        self.cest = data.get('cest')
        self.indicador_escala_relevante = data.get('indicadorEscalaRelevante')
        self.cnpj_fabricante = data.get('cnpjFabricante')
        self.codigo_beneficio_fiscal = data.get('codigoBeneficioFiscal')
        self.ex_tipi = data.get('exTipi')
        self.cfop = data.get('cfop')
        self.unidade_comercial = data.get('unidadeComercial')
        self.quantidade_comercial = data.get('quantidadeComercial')
        self.numero_pedido_compra = data.get('numeroPedidoCompra')
        self.item_pedido_compra = data.get('itemPedidoCompra')
        self.numero_fci = data.get('numeroFci')
        self.numero_recopi = data.get('numeroRecopi')
        self.valor_unitario_comercial = data.get('valorUnitarioComercial')
        self.valor_bruto_produto = data.get('valorBrutoProduto')
        self.gtin_unidade_tributavel = data.get('gtinUnidadeTributavel')
        self.unidade_tributavel = data.get('unidadeTributavel')
        self.quantidade_tributavel = data.get('quantidadeTributavel')
        self.valor_unitario_tributavel = data.get('valorUnitarioTributavel')
        self.valor_frete = data.get('valorFrete')
        self.valor_seguro = data.get('valorSeguro')
        self.valor_desconto = data.get('valorDesconto')
        self.valor_outras_despesas = data.get('valorOutrasDespesas')
        self.entra_total = data.get('entraTotal')
        self.valor_total_tributos = data.get('valorTotalTributos')
        self.percentual_devolvido = data.get('percentualDevolvido')
        self.valor_ipi_devolvido = data.get('valorIpiDevolvido')
        self.informacoes_adicionais = data.get('informacoesAdicionais')
        self.valor_subtotal = data.get('valorSubtotal')
        self.valor_total = data.get('valorTotal')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeCabecalho': self.id_nfe_cabecalho,
            'idProduto': self.id_produto,
            'numeroItem': self.numero_item,
            'codigoProduto': self.codigo_produto,
            'gtin': self.gtin,
            'nomeProduto': self.nome_produto,
            'ncm': self.ncm,
            'nve': self.nve,
            'cest': self.cest,
            'indicadorEscalaRelevante': self.indicador_escala_relevante,
            'cnpjFabricante': self.cnpj_fabricante,
            'codigoBeneficioFiscal': self.codigo_beneficio_fiscal,
            'exTipi': self.ex_tipi,
            'cfop': self.cfop,
            'unidadeComercial': self.unidade_comercial,
            'quantidadeComercial': self.quantidade_comercial,
            'numeroPedidoCompra': self.numero_pedido_compra,
            'itemPedidoCompra': self.item_pedido_compra,
            'numeroFci': self.numero_fci,
            'numeroRecopi': self.numero_recopi,
            'valorUnitarioComercial': self.valor_unitario_comercial,
            'valorBrutoProduto': self.valor_bruto_produto,
            'gtinUnidadeTributavel': self.gtin_unidade_tributavel,
            'unidadeTributavel': self.unidade_tributavel,
            'quantidadeTributavel': self.quantidade_tributavel,
            'valorUnitarioTributavel': self.valor_unitario_tributavel,
            'valorFrete': self.valor_frete,
            'valorSeguro': self.valor_seguro,
            'valorDesconto': self.valor_desconto,
            'valorOutrasDespesas': self.valor_outras_despesas,
            'entraTotal': self.entra_total,
            'valorTotalTributos': self.valor_total_tributos,
            'percentualDevolvido': self.percentual_devolvido,
            'valorIpiDevolvido': self.valor_ipi_devolvido,
            'informacoesAdicionais': self.informacoes_adicionais,
            'valorSubtotal': self.valor_subtotal,
            'valorTotal': self.valor_total,
            'nfeDetEspecificoVeiculoModelList': [nfe_det_especifico_veiculo_model.serialize() for nfe_det_especifico_veiculo_model in self.nfe_det_especifico_veiculo_model_list],
            'nfeDetEspecificoMedicamentoModelList': [nfe_det_especifico_medicamento_model.serialize() for nfe_det_especifico_medicamento_model in self.nfe_det_especifico_medicamento_model_list],
            'nfeDetEspecificoArmamentoModelList': [nfe_det_especifico_armamento_model.serialize() for nfe_det_especifico_armamento_model in self.nfe_det_especifico_armamento_model_list],
            'nfeDetEspecificoCombustivelModelList': [nfe_det_especifico_combustivel_model.serialize() for nfe_det_especifico_combustivel_model in self.nfe_det_especifico_combustivel_model_list],
            'nfeDeclaracaoImportacaoModelList': [nfe_declaracao_importacao_model.serialize() for nfe_declaracao_importacao_model in self.nfe_declaracao_importacao_model_list],
            'nfeDetalheImpostoIcmsModelList': [nfe_detalhe_imposto_icms_model.serialize() for nfe_detalhe_imposto_icms_model in self.nfe_detalhe_imposto_icms_model_list],
            'nfeDetalheImpostoIpiModelList': [nfe_detalhe_imposto_ipi_model.serialize() for nfe_detalhe_imposto_ipi_model in self.nfe_detalhe_imposto_ipi_model_list],
            'nfeDetalheImpostoIiModelList': [nfe_detalhe_imposto_ii_model.serialize() for nfe_detalhe_imposto_ii_model in self.nfe_detalhe_imposto_ii_model_list],
            'nfeDetalheImpostoPisModelList': [nfe_detalhe_imposto_pis_model.serialize() for nfe_detalhe_imposto_pis_model in self.nfe_detalhe_imposto_pis_model_list],
            'nfeDetalheImpostoCofinsModelList': [nfe_detalhe_imposto_cofins_model.serialize() for nfe_detalhe_imposto_cofins_model in self.nfe_detalhe_imposto_cofins_model_list],
            'nfeDetalheImpostoIssqnModelList': [nfe_detalhe_imposto_issqn_model.serialize() for nfe_detalhe_imposto_issqn_model in self.nfe_detalhe_imposto_issqn_model_list],
            'nfeExportacaoModelList': [nfe_exportacao_model.serialize() for nfe_exportacao_model in self.nfe_exportacao_model_list],
            'nfeItemRastreadoModelList': [nfe_item_rastreado_model.serialize() for nfe_item_rastreado_model in self.nfe_item_rastreado_model_list],
            'nfeDetalheImpostoPisStModelList': [nfe_detalhe_imposto_pis_st_model.serialize() for nfe_detalhe_imposto_pis_st_model in self.nfe_detalhe_imposto_pis_st_model_list],
            'nfeDetalheImpostoIcmsUfdestModelList': [nfe_detalhe_imposto_icms_ufdest_model.serialize() for nfe_detalhe_imposto_icms_ufdest_model in self.nfe_detalhe_imposto_icms_ufdest_model_list],
            'nfeDetalheImpostoCofinsStModelList': [nfe_detalhe_imposto_cofins_st_model.serialize() for nfe_detalhe_imposto_cofins_st_model in self.nfe_detalhe_imposto_cofins_st_model_list],
            'nfeCabecalhoModel': self.nfe_cabecalho_model.serialize() if self.nfe_cabecalho_model else None,
            'produtoModel': self.produto_model.serialize() if self.produto_model else None,
        }