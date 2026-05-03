from src import db


class TributIpiModel(db.Model):
    __tablename__ = 'tribut_ipi'

    id = db.Column(db.Integer, primary_key=True)
    cst_ipi = db.Column(db.String(2))
    modalidade_base_calculo = db.Column(db.String(1))
    porcento_base_calculo = db.Column(db.Float)
    aliquota_porcento = db.Column(db.Float)
    aliquota_unidade = db.Column(db.Float)
    valor_preco_maximo = db.Column(db.Float)
    valor_pauta_fiscal = db.Column(db.Float)
    id_tribut_configura_of_gt = db.Column(db.Integer, db.ForeignKey('tribut_configura_of_gt.id'), unique=True)


    def mapping(self, data):
        self.id = data.get('id')
        self.id_tribut_configura_of_gt = data.get('idTributConfiguraOfGt')
        self.cst_ipi = data.get('cstIpi')
        self.modalidade_base_calculo = data.get('modalidadeBaseCalculo')
        self.porcento_base_calculo = data.get('porcentoBaseCalculo')
        self.aliquota_porcento = data.get('aliquotaPorcento')
        self.aliquota_unidade = data.get('aliquotaUnidade')
        self.valor_preco_maximo = data.get('valorPrecoMaximo')
        self.valor_pauta_fiscal = data.get('valorPautaFiscal')

    def serialize(self):
        return {
            'id': self.id,
            'idTributConfiguraOfGt': self.id_tribut_configura_of_gt,
            'cstIpi': self.cst_ipi,
            'modalidadeBaseCalculo': self.modalidade_base_calculo,
            'porcentoBaseCalculo': self.porcento_base_calculo,
            'aliquotaPorcento': self.aliquota_porcento,
            'aliquotaUnidade': self.aliquota_unidade,
            'valorPrecoMaximo': self.valor_preco_maximo,
            'valorPautaFiscal': self.valor_pauta_fiscal,
        }