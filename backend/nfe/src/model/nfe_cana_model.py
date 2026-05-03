from src import db


class NfeCanaModel(db.Model):
    __tablename__ = 'nfe_cana'

    id = db.Column(db.Integer, primary_key=True)
    safra = db.Column(db.String(9))
    mes_ano_referencia = db.Column(db.String(7))
    id_nfe_cabecalho = db.Column(db.Integer, db.ForeignKey('nfe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_cabecalho = data.get('idNfeCabecalho')
        self.safra = data.get('safra')
        self.mes_ano_referencia = data.get('mesAnoReferencia')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeCabecalho': self.id_nfe_cabecalho,
            'safra': self.safra,
            'mesAnoReferencia': self.mes_ano_referencia,
        }