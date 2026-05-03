from src import db


class NfeDetalheImpostoIpiModel(db.Model):
    __tablename__ = 'nfe_detalhe_imposto_ipi'

    id = db.Column(db.Integer, primary_key=True)
    cnpj_produtor = db.Column(db.String(14))
    codigo_selo_ipi = db.Column(db.String(60))
    quantidade_selo_ipi = db.Column(db.Integer)
    enquadramento_legal_ipi = db.Column(db.String(3))
    cst_ipi = db.Column(db.String(2))
    valor_base_calculo_ipi = db.Column(db.Float)
    quantidade_unidade_tributavel = db.Column(db.Float)
    valor_unidade_tributavel = db.Column(db.Float)
    aliquota_ipi = db.Column(db.Float)
    valor_ipi = db.Column(db.Float)
    id_nfe_detalhe = db.Column(db.Integer, db.ForeignKey('nfe_detalhe.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_detalhe = data.get('idNfeDetalhe')
        self.cnpj_produtor = data.get('cnpjProdutor')
        self.codigo_selo_ipi = data.get('codigoSeloIpi')
        self.quantidade_selo_ipi = data.get('quantidadeSeloIpi')
        self.enquadramento_legal_ipi = data.get('enquadramentoLegalIpi')
        self.cst_ipi = data.get('cstIpi')
        self.valor_base_calculo_ipi = data.get('valorBaseCalculoIpi')
        self.quantidade_unidade_tributavel = data.get('quantidadeUnidadeTributavel')
        self.valor_unidade_tributavel = data.get('valorUnidadeTributavel')
        self.aliquota_ipi = data.get('aliquotaIpi')
        self.valor_ipi = data.get('valorIpi')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeDetalhe': self.id_nfe_detalhe,
            'cnpjProdutor': self.cnpj_produtor,
            'codigoSeloIpi': self.codigo_selo_ipi,
            'quantidadeSeloIpi': self.quantidade_selo_ipi,
            'enquadramentoLegalIpi': self.enquadramento_legal_ipi,
            'cstIpi': self.cst_ipi,
            'valorBaseCalculoIpi': self.valor_base_calculo_ipi,
            'quantidadeUnidadeTributavel': self.quantidade_unidade_tributavel,
            'valorUnidadeTributavel': self.valor_unidade_tributavel,
            'aliquotaIpi': self.aliquota_ipi,
            'valorIpi': self.valor_ipi,
        }