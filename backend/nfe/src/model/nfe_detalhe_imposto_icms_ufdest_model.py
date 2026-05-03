from src import db


class NfeDetalheImpostoIcmsUfdestModel(db.Model):
    __tablename__ = 'nfe_detalhe_imposto_icms_ufdest'

    id = db.Column(db.Integer, primary_key=True)
    valor_bc_icms_uf_destino = db.Column(db.Float)
    valor_bc_fcp_uf_destino = db.Column(db.Float)
    percentual_fcp_uf_destino = db.Column(db.Float)
    aliquota_interna_uf_destino = db.Column(db.Float)
    aliquota_interesdatual_uf_envolvidas = db.Column(db.Float)
    percentual_provisorio_partilha_icms = db.Column(db.Float)
    valor_icms_fcp_uf_destino = db.Column(db.Float)
    valor_interestadual_uf_destino = db.Column(db.Float)
    valor_interestadual_uf_remetente = db.Column(db.Float)
    id_nfe_detalhe = db.Column(db.Integer, db.ForeignKey('nfe_detalhe.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_detalhe = data.get('idNfeDetalhe')
        self.valor_bc_icms_uf_destino = data.get('valorBcIcmsUfDestino')
        self.valor_bc_fcp_uf_destino = data.get('valorBcFcpUfDestino')
        self.percentual_fcp_uf_destino = data.get('percentualFcpUfDestino')
        self.aliquota_interna_uf_destino = data.get('aliquotaInternaUfDestino')
        self.aliquota_interesdatual_uf_envolvidas = data.get('aliquotaInteresdatualUfEnvolvidas')
        self.percentual_provisorio_partilha_icms = data.get('percentualProvisorioPartilhaIcms')
        self.valor_icms_fcp_uf_destino = data.get('valorIcmsFcpUfDestino')
        self.valor_interestadual_uf_destino = data.get('valorInterestadualUfDestino')
        self.valor_interestadual_uf_remetente = data.get('valorInterestadualUfRemetente')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeDetalhe': self.id_nfe_detalhe,
            'valorBcIcmsUfDestino': self.valor_bc_icms_uf_destino,
            'valorBcFcpUfDestino': self.valor_bc_fcp_uf_destino,
            'percentualFcpUfDestino': self.percentual_fcp_uf_destino,
            'aliquotaInternaUfDestino': self.aliquota_interna_uf_destino,
            'aliquotaInteresdatualUfEnvolvidas': self.aliquota_interesdatual_uf_envolvidas,
            'percentualProvisorioPartilhaIcms': self.percentual_provisorio_partilha_icms,
            'valorIcmsFcpUfDestino': self.valor_icms_fcp_uf_destino,
            'valorInterestadualUfDestino': self.valor_interestadual_uf_destino,
            'valorInterestadualUfRemetente': self.valor_interestadual_uf_remetente,
        }