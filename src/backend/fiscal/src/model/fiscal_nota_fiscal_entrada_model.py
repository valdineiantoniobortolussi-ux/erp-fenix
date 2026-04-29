from src import db
from src.model.nfe_cabecalho_model import NfeCabecalhoModel


class FiscalNotaFiscalEntradaModel(db.Model):
    __tablename__ = 'fiscal_nota_fiscal_entrada'

    id = db.Column(db.Integer, primary_key=True)
    competencia = db.Column(db.String(7))
    cfop_entrada = db.Column(db.Integer)
    valor_rateio_frete = db.Column(db.Float)
    valor_custo_medio = db.Column(db.Float)
    valor_icms_antecipado = db.Column(db.Float)
    valor_bc_icms_antecipado = db.Column(db.Float)
    valor_bc_icms_creditado = db.Column(db.Float)
    valor_bc_pis_creditado = db.Column(db.Float)
    valor_bc_cofins_creditado = db.Column(db.Float)
    valor_bc_ipi_creditado = db.Column(db.Float)
    cst_credito_icms = db.Column(db.String(3))
    cst_credito_pis = db.Column(db.String(2))
    cst_credito_cofins = db.Column(db.String(2))
    cst_credito_ipi = db.Column(db.String(2))
    valor_icms_creditado = db.Column(db.Float)
    valor_pis_creditado = db.Column(db.Float)
    valor_cofins_creditado = db.Column(db.Float)
    valor_ipi_creditado = db.Column(db.Float)
    qtde_parcela_credito_pis = db.Column(db.Integer)
    qtde_parcela_credito_cofins = db.Column(db.Integer)
    qtde_parcela_credito_icms = db.Column(db.Integer)
    qtde_parcela_credito_ipi = db.Column(db.Integer)
    aliquota_credito_icms = db.Column(db.Float)
    aliquota_credito_pis = db.Column(db.Float)
    aliquota_credito_cofins = db.Column(db.Float)
    aliquota_credito_ipi = db.Column(db.Float)
    id_nfe_cabecalho = db.Column(db.Integer, db.ForeignKey('nfe_cabecalho.id'))

    nfe_cabecalho_model = db.relationship('NfeCabecalhoModel', foreign_keys=[id_nfe_cabecalho])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_cabecalho = data.get('idNfeCabecalho')
        self.competencia = data.get('competencia')
        self.cfop_entrada = data.get('cfopEntrada')
        self.valor_rateio_frete = data.get('valorRateioFrete')
        self.valor_custo_medio = data.get('valorCustoMedio')
        self.valor_icms_antecipado = data.get('valorIcmsAntecipado')
        self.valor_bc_icms_antecipado = data.get('valorBcIcmsAntecipado')
        self.valor_bc_icms_creditado = data.get('valorBcIcmsCreditado')
        self.valor_bc_pis_creditado = data.get('valorBcPisCreditado')
        self.valor_bc_cofins_creditado = data.get('valorBcCofinsCreditado')
        self.valor_bc_ipi_creditado = data.get('valorBcIpiCreditado')
        self.cst_credito_icms = data.get('cstCreditoIcms')
        self.cst_credito_pis = data.get('cstCreditoPis')
        self.cst_credito_cofins = data.get('cstCreditoCofins')
        self.cst_credito_ipi = data.get('cstCreditoIpi')
        self.valor_icms_creditado = data.get('valorIcmsCreditado')
        self.valor_pis_creditado = data.get('valorPisCreditado')
        self.valor_cofins_creditado = data.get('valorCofinsCreditado')
        self.valor_ipi_creditado = data.get('valorIpiCreditado')
        self.qtde_parcela_credito_pis = data.get('qtdeParcelaCreditoPis')
        self.qtde_parcela_credito_cofins = data.get('qtdeParcelaCreditoCofins')
        self.qtde_parcela_credito_icms = data.get('qtdeParcelaCreditoIcms')
        self.qtde_parcela_credito_ipi = data.get('qtdeParcelaCreditoIpi')
        self.aliquota_credito_icms = data.get('aliquotaCreditoIcms')
        self.aliquota_credito_pis = data.get('aliquotaCreditoPis')
        self.aliquota_credito_cofins = data.get('aliquotaCreditoCofins')
        self.aliquota_credito_ipi = data.get('aliquotaCreditoIpi')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeCabecalho': self.id_nfe_cabecalho,
            'competencia': self.competencia,
            'cfopEntrada': self.cfop_entrada,
            'valorRateioFrete': self.valor_rateio_frete,
            'valorCustoMedio': self.valor_custo_medio,
            'valorIcmsAntecipado': self.valor_icms_antecipado,
            'valorBcIcmsAntecipado': self.valor_bc_icms_antecipado,
            'valorBcIcmsCreditado': self.valor_bc_icms_creditado,
            'valorBcPisCreditado': self.valor_bc_pis_creditado,
            'valorBcCofinsCreditado': self.valor_bc_cofins_creditado,
            'valorBcIpiCreditado': self.valor_bc_ipi_creditado,
            'cstCreditoIcms': self.cst_credito_icms,
            'cstCreditoPis': self.cst_credito_pis,
            'cstCreditoCofins': self.cst_credito_cofins,
            'cstCreditoIpi': self.cst_credito_ipi,
            'valorIcmsCreditado': self.valor_icms_creditado,
            'valorPisCreditado': self.valor_pis_creditado,
            'valorCofinsCreditado': self.valor_cofins_creditado,
            'valorIpiCreditado': self.valor_ipi_creditado,
            'qtdeParcelaCreditoPis': self.qtde_parcela_credito_pis,
            'qtdeParcelaCreditoCofins': self.qtde_parcela_credito_cofins,
            'qtdeParcelaCreditoIcms': self.qtde_parcela_credito_icms,
            'qtdeParcelaCreditoIpi': self.qtde_parcela_credito_ipi,
            'aliquotaCreditoIcms': self.aliquota_credito_icms,
            'aliquotaCreditoPis': self.aliquota_credito_pis,
            'aliquotaCreditoCofins': self.aliquota_credito_cofins,
            'aliquotaCreditoIpi': self.aliquota_credito_ipi,
            'nfeCabecalhoModel': self.nfe_cabecalho_model.serialize() if self.nfe_cabecalho_model else None,
        }