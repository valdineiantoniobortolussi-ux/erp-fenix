from src import db


class NfeProcessoReferenciadoModel(db.Model):
    __tablename__ = 'nfe_processo_referenciado'

    id = db.Column(db.Integer, primary_key=True)
    identificador = db.Column(db.String(60))
    origem = db.Column(db.String(1))
    id_nfe_cabecalho = db.Column(db.Integer, db.ForeignKey('nfe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_cabecalho = data.get('idNfeCabecalho')
        self.identificador = data.get('identificador')
        self.origem = data.get('origem')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeCabecalho': self.id_nfe_cabecalho,
            'identificador': self.identificador,
            'origem': self.origem,
        }