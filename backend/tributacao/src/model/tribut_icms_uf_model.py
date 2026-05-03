from src import db


class TributIcmsUfModel(db.Model):
    __tablename__ = 'tribut_icms_uf'

    id = db.Column(db.Integer, primary_key=True)
    uf_destino = db.Column(db.String(2))
    cst = db.Column(db.String(2))
    csosn = db.Column(db.String(3))
    modalidade_bc = db.Column(db.String(1))
    cfop = db.Column(db.Integer)
    aliquota = db.Column(db.Float)
    valor_pauta = db.Column(db.Float)
    valor_preco_maximo = db.Column(db.Float)
    mva = db.Column(db.Float)
    porcento_bc = db.Column(db.Float)
    modalidade_bc_st = db.Column(db.String(1))
    aliquota_interna_st = db.Column(db.Float)
    aliquota_interestadual_st = db.Column(db.Float)
    porcento_bc_st = db.Column(db.Float)
    aliquota_icms_st = db.Column(db.Float)
    valor_pauta_st = db.Column(db.Float)
    valor_preco_maximo_st = db.Column(db.Float)
    id_tribut_configura_of_gt = db.Column(db.Integer, db.ForeignKey('tribut_configura_of_gt.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_tribut_configura_of_gt = data.get('idTributConfiguraOfGt')
        self.uf_destino = data.get('ufDestino')
        self.cst = data.get('cst')
        self.csosn = data.get('csosn')
        self.modalidade_bc = data.get('modalidadeBc')
        self.cfop = data.get('cfop')
        self.aliquota = data.get('aliquota')
        self.valor_pauta = data.get('valorPauta')
        self.valor_preco_maximo = data.get('valorPrecoMaximo')
        self.mva = data.get('mva')
        self.porcento_bc = data.get('porcentoBc')
        self.modalidade_bc_st = data.get('modalidadeBcSt')
        self.aliquota_interna_st = data.get('aliquotaInternaSt')
        self.aliquota_interestadual_st = data.get('aliquotaInterestadualSt')
        self.porcento_bc_st = data.get('porcentoBcSt')
        self.aliquota_icms_st = data.get('aliquotaIcmsSt')
        self.valor_pauta_st = data.get('valorPautaSt')
        self.valor_preco_maximo_st = data.get('valorPrecoMaximoSt')

    def serialize(self):
        return {
            'id': self.id,
            'idTributConfiguraOfGt': self.id_tribut_configura_of_gt,
            'ufDestino': self.uf_destino,
            'cst': self.cst,
            'csosn': self.csosn,
            'modalidadeBc': self.modalidade_bc,
            'cfop': self.cfop,
            'aliquota': self.aliquota,
            'valorPauta': self.valor_pauta,
            'valorPrecoMaximo': self.valor_preco_maximo,
            'mva': self.mva,
            'porcentoBc': self.porcento_bc,
            'modalidadeBcSt': self.modalidade_bc_st,
            'aliquotaInternaSt': self.aliquota_interna_st,
            'aliquotaInterestadualSt': self.aliquota_interestadual_st,
            'porcentoBcSt': self.porcento_bc_st,
            'aliquotaIcmsSt': self.aliquota_icms_st,
            'valorPautaSt': self.valor_pauta_st,
            'valorPrecoMaximoSt': self.valor_preco_maximo_st,
        }