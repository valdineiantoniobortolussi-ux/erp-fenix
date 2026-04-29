from src import db


class NfeCupomFiscalReferenciadoModel(db.Model):
    __tablename__ = 'nfe_cupom_fiscal_referenciado'

    id = db.Column(db.Integer, primary_key=True)
    modelo_documento_fiscal = db.Column(db.String(2))
    numero_ordem_ecf = db.Column(db.Integer)
    coo = db.Column(db.Integer)
    data_emissao_cupom = db.Column(db.DateTime)
    numero_caixa = db.Column(db.Integer)
    numero_serie_ecf = db.Column(db.String(21))
    id_nfe_cabecalho = db.Column(db.Integer, db.ForeignKey('nfe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_cabecalho = data.get('idNfeCabecalho')
        self.modelo_documento_fiscal = data.get('modeloDocumentoFiscal')
        self.numero_ordem_ecf = data.get('numeroOrdemEcf')
        self.coo = data.get('coo')
        self.data_emissao_cupom = data.get('dataEmissaoCupom')
        self.numero_caixa = data.get('numeroCaixa')
        self.numero_serie_ecf = data.get('numeroSerieEcf')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeCabecalho': self.id_nfe_cabecalho,
            'modeloDocumentoFiscal': self.modelo_documento_fiscal,
            'numeroOrdemEcf': self.numero_ordem_ecf,
            'coo': self.coo,
            'dataEmissaoCupom': self.data_emissao_cupom.isoformat(),
            'numeroCaixa': self.numero_caixa,
            'numeroSerieEcf': self.numero_serie_ecf,
        }