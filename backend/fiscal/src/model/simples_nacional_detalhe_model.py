from src import db


class SimplesNacionalDetalheModel(db.Model):
    __tablename__ = 'simples_nacional_detalhe'

    id = db.Column(db.Integer, primary_key=True)
    faixa = db.Column(db.Integer)
    valor_inicial = db.Column(db.Float)
    valor_final = db.Column(db.Float)
    aliquota = db.Column(db.Float)
    irpj = db.Column(db.Float)
    csll = db.Column(db.Float)
    cofins = db.Column(db.Float)
    pis_pasep = db.Column(db.Float)
    cpp = db.Column(db.Float)
    icms = db.Column(db.Float)
    ipi = db.Column(db.Float)
    iss = db.Column(db.Float)
    id_simples_nacional_cabecalho = db.Column(db.Integer, db.ForeignKey('simples_nacional_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_simples_nacional_cabecalho = data.get('idSimplesNacionalCabecalho')
        self.faixa = data.get('faixa')
        self.valor_inicial = data.get('valorInicial')
        self.valor_final = data.get('valorFinal')
        self.aliquota = data.get('aliquota')
        self.irpj = data.get('irpj')
        self.csll = data.get('csll')
        self.cofins = data.get('cofins')
        self.pis_pasep = data.get('pisPasep')
        self.cpp = data.get('cpp')
        self.icms = data.get('icms')
        self.ipi = data.get('ipi')
        self.iss = data.get('iss')

    def serialize(self):
        return {
            'id': self.id,
            'idSimplesNacionalCabecalho': self.id_simples_nacional_cabecalho,
            'faixa': self.faixa,
            'valorInicial': self.valor_inicial,
            'valorFinal': self.valor_final,
            'aliquota': self.aliquota,
            'irpj': self.irpj,
            'csll': self.csll,
            'cofins': self.cofins,
            'pisPasep': self.pis_pasep,
            'cpp': self.cpp,
            'icms': self.icms,
            'ipi': self.ipi,
            'iss': self.iss,
        }