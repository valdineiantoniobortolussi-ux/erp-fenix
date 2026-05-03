from src import db


class NfeNfReferenciadaModel(db.Model):
    __tablename__ = 'nfe_nf_referenciada'

    id = db.Column(db.Integer, primary_key=True)
    codigo_uf = db.Column(db.Integer)
    ano_mes = db.Column(db.String(4))
    cnpj = db.Column(db.String(14))
    modelo = db.Column(db.String(2))
    serie = db.Column(db.String(3))
    numero_nf = db.Column(db.Integer)
    id_nfe_cabecalho = db.Column(db.Integer, db.ForeignKey('nfe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_cabecalho = data.get('idNfeCabecalho')
        self.codigo_uf = data.get('codigoUf')
        self.ano_mes = data.get('anoMes')
        self.cnpj = data.get('cnpj')
        self.modelo = data.get('modelo')
        self.serie = data.get('serie')
        self.numero_nf = data.get('numeroNf')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeCabecalho': self.id_nfe_cabecalho,
            'codigoUf': self.codigo_uf,
            'anoMes': self.ano_mes,
            'cnpj': self.cnpj,
            'modelo': self.modelo,
            'serie': self.serie,
            'numeroNf': self.numero_nf,
        }