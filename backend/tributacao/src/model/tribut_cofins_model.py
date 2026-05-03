from src import db


class TributCofinsModel(db.Model):
    __tablename__ = 'tribut_cofins'

    id = db.Column(db.Integer, primary_key=True)
    cst_cofins = db.Column(db.String(2))
    modalidade_base_calculo = db.Column(db.String(1))
    efd_tabela_435 = db.Column(db.String(2))
    porcento_base_calculo = db.Column(db.Float)
    aliquota_porcento = db.Column(db.Float)
    aliquota_unidade = db.Column(db.Float)
    valor_preco_maximo = db.Column(db.Float)
    valor_pauta_fiscal = db.Column(db.Float)
    id_tribut_configura_of_gt = db.Column(db.Integer, db.ForeignKey('tribut_configura_of_gt.id'), unique=True)


    def mapping(self, data):
        self.id = data.get('id')
        self.id_tribut_configura_of_gt = data.get('idTributConfiguraOfGt')
        self.cst_cofins = data.get('cstCofins')
        self.modalidade_base_calculo = data.get('modalidadeBaseCalculo')
        self.efd_tabela_435 = data.get('efdTabela435')
        self.porcento_base_calculo = data.get('porcentoBaseCalculo')
        self.aliquota_porcento = data.get('aliquotaPorcento')
        self.aliquota_unidade = data.get('aliquotaUnidade')
        self.valor_preco_maximo = data.get('valorPrecoMaximo')
        self.valor_pauta_fiscal = data.get('valorPautaFiscal')

    def serialize(self):
        return {
            'id': self.id,
            'idTributConfiguraOfGt': self.id_tribut_configura_of_gt,
            'cstCofins': self.cst_cofins,
            'modalidadeBaseCalculo': self.modalidade_base_calculo,
            'efdTabela435': self.efd_tabela_435,
            'porcentoBaseCalculo': self.porcento_base_calculo,
            'aliquotaPorcento': self.aliquota_porcento,
            'aliquotaUnidade': self.aliquota_unidade,
            'valorPrecoMaximo': self.valor_preco_maximo,
            'valorPautaFiscal': self.valor_pauta_fiscal,
        }