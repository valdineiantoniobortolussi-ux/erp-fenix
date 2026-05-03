from src import db


class NfeDetalheImpostoIcmsModel(db.Model):
    __tablename__ = 'nfe_detalhe_imposto_icms'

    id = db.Column(db.Integer, primary_key=True)
    origem_mercadoria = db.Column(db.String(1))
    cst_icms = db.Column(db.String(2))
    csosn = db.Column(db.String(3))
    modalidade_bc_icms = db.Column(db.String(1))
    percentual_reducao_bc_icms = db.Column(db.Float)
    valor_bc_icms = db.Column(db.Float)
    aliquota_icms = db.Column(db.Float)
    valor_icms_operacao = db.Column(db.Float)
    percentual_diferimento = db.Column(db.Float)
    valor_icms_diferido = db.Column(db.Float)
    valor_icms = db.Column(db.Float)
    base_calculo_fcp = db.Column(db.Float)
    percentual_fcp = db.Column(db.Float)
    valor_fcp = db.Column(db.Float)
    modalidade_bc_icms_st = db.Column(db.String(1))
    percentual_mva_icms_st = db.Column(db.Float)
    percentual_reducao_bc_icms_st = db.Column(db.Float)
    valor_base_calculo_icms_st = db.Column(db.Float)
    aliquota_icms_st = db.Column(db.Float)
    valor_icms_st = db.Column(db.Float)
    base_calculo_fcp_st = db.Column(db.Float)
    percentual_fcp_st = db.Column(db.Float)
    valor_fcp_st = db.Column(db.Float)
    uf_st = db.Column(db.String(2))
    percentual_bc_operacao_propria = db.Column(db.Float)
    valor_bc_icms_st_retido = db.Column(db.Float)
    aliquota_suportada_consumidor = db.Column(db.Float)
    valor_icms_substituto = db.Column(db.Float)
    valor_icms_st_retido = db.Column(db.Float)
    base_calculo_fcp_st_retido = db.Column(db.Float)
    percentual_fcp_st_retido = db.Column(db.Float)
    valor_fcp_st_retido = db.Column(db.Float)
    motivo_desoneracao_icms = db.Column(db.String(2))
    valor_icms_desonerado = db.Column(db.Float)
    aliquota_credito_icms_sn = db.Column(db.Float)
    valor_credito_icms_sn = db.Column(db.Float)
    valor_bc_icms_st_destino = db.Column(db.Float)
    valor_icms_st_destino = db.Column(db.Float)
    percentual_reducao_bc_efetivo = db.Column(db.Float)
    valor_bc_efetivo = db.Column(db.Float)
    aliquota_icms_efetivo = db.Column(db.Float)
    valor_icms_efetivo = db.Column(db.Float)
    id_nfe_detalhe = db.Column(db.Integer, db.ForeignKey('nfe_detalhe.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_detalhe = data.get('idNfeDetalhe')
        self.origem_mercadoria = data.get('origemMercadoria')
        self.cst_icms = data.get('cstIcms')
        self.csosn = data.get('csosn')
        self.modalidade_bc_icms = data.get('modalidadeBcIcms')
        self.percentual_reducao_bc_icms = data.get('percentualReducaoBcIcms')
        self.valor_bc_icms = data.get('valorBcIcms')
        self.aliquota_icms = data.get('aliquotaIcms')
        self.valor_icms_operacao = data.get('valorIcmsOperacao')
        self.percentual_diferimento = data.get('percentualDiferimento')
        self.valor_icms_diferido = data.get('valorIcmsDiferido')
        self.valor_icms = data.get('valorIcms')
        self.base_calculo_fcp = data.get('baseCalculoFcp')
        self.percentual_fcp = data.get('percentualFcp')
        self.valor_fcp = data.get('valorFcp')
        self.modalidade_bc_icms_st = data.get('modalidadeBcIcmsSt')
        self.percentual_mva_icms_st = data.get('percentualMvaIcmsSt')
        self.percentual_reducao_bc_icms_st = data.get('percentualReducaoBcIcmsSt')
        self.valor_base_calculo_icms_st = data.get('valorBaseCalculoIcmsSt')
        self.aliquota_icms_st = data.get('aliquotaIcmsSt')
        self.valor_icms_st = data.get('valorIcmsSt')
        self.base_calculo_fcp_st = data.get('baseCalculoFcpSt')
        self.percentual_fcp_st = data.get('percentualFcpSt')
        self.valor_fcp_st = data.get('valorFcpSt')
        self.uf_st = data.get('ufSt')
        self.percentual_bc_operacao_propria = data.get('percentualBcOperacaoPropria')
        self.valor_bc_icms_st_retido = data.get('valorBcIcmsStRetido')
        self.aliquota_suportada_consumidor = data.get('aliquotaSuportadaConsumidor')
        self.valor_icms_substituto = data.get('valorIcmsSubstituto')
        self.valor_icms_st_retido = data.get('valorIcmsStRetido')
        self.base_calculo_fcp_st_retido = data.get('baseCalculoFcpStRetido')
        self.percentual_fcp_st_retido = data.get('percentualFcpStRetido')
        self.valor_fcp_st_retido = data.get('valorFcpStRetido')
        self.motivo_desoneracao_icms = data.get('motivoDesoneracaoIcms')
        self.valor_icms_desonerado = data.get('valorIcmsDesonerado')
        self.aliquota_credito_icms_sn = data.get('aliquotaCreditoIcmsSn')
        self.valor_credito_icms_sn = data.get('valorCreditoIcmsSn')
        self.valor_bc_icms_st_destino = data.get('valorBcIcmsStDestino')
        self.valor_icms_st_destino = data.get('valorIcmsStDestino')
        self.percentual_reducao_bc_efetivo = data.get('percentualReducaoBcEfetivo')
        self.valor_bc_efetivo = data.get('valorBcEfetivo')
        self.aliquota_icms_efetivo = data.get('aliquotaIcmsEfetivo')
        self.valor_icms_efetivo = data.get('valorIcmsEfetivo')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeDetalhe': self.id_nfe_detalhe,
            'origemMercadoria': self.origem_mercadoria,
            'cstIcms': self.cst_icms,
            'csosn': self.csosn,
            'modalidadeBcIcms': self.modalidade_bc_icms,
            'percentualReducaoBcIcms': self.percentual_reducao_bc_icms,
            'valorBcIcms': self.valor_bc_icms,
            'aliquotaIcms': self.aliquota_icms,
            'valorIcmsOperacao': self.valor_icms_operacao,
            'percentualDiferimento': self.percentual_diferimento,
            'valorIcmsDiferido': self.valor_icms_diferido,
            'valorIcms': self.valor_icms,
            'baseCalculoFcp': self.base_calculo_fcp,
            'percentualFcp': self.percentual_fcp,
            'valorFcp': self.valor_fcp,
            'modalidadeBcIcmsSt': self.modalidade_bc_icms_st,
            'percentualMvaIcmsSt': self.percentual_mva_icms_st,
            'percentualReducaoBcIcmsSt': self.percentual_reducao_bc_icms_st,
            'valorBaseCalculoIcmsSt': self.valor_base_calculo_icms_st,
            'aliquotaIcmsSt': self.aliquota_icms_st,
            'valorIcmsSt': self.valor_icms_st,
            'baseCalculoFcpSt': self.base_calculo_fcp_st,
            'percentualFcpSt': self.percentual_fcp_st,
            'valorFcpSt': self.valor_fcp_st,
            'ufSt': self.uf_st,
            'percentualBcOperacaoPropria': self.percentual_bc_operacao_propria,
            'valorBcIcmsStRetido': self.valor_bc_icms_st_retido,
            'aliquotaSuportadaConsumidor': self.aliquota_suportada_consumidor,
            'valorIcmsSubstituto': self.valor_icms_substituto,
            'valorIcmsStRetido': self.valor_icms_st_retido,
            'baseCalculoFcpStRetido': self.base_calculo_fcp_st_retido,
            'percentualFcpStRetido': self.percentual_fcp_st_retido,
            'valorFcpStRetido': self.valor_fcp_st_retido,
            'motivoDesoneracaoIcms': self.motivo_desoneracao_icms,
            'valorIcmsDesonerado': self.valor_icms_desonerado,
            'aliquotaCreditoIcmsSn': self.aliquota_credito_icms_sn,
            'valorCreditoIcmsSn': self.valor_credito_icms_sn,
            'valorBcIcmsStDestino': self.valor_bc_icms_st_destino,
            'valorIcmsStDestino': self.valor_icms_st_destino,
            'percentualReducaoBcEfetivo': self.percentual_reducao_bc_efetivo,
            'valorBcEfetivo': self.valor_bc_efetivo,
            'aliquotaIcmsEfetivo': self.aliquota_icms_efetivo,
            'valorIcmsEfetivo': self.valor_icms_efetivo,
        }