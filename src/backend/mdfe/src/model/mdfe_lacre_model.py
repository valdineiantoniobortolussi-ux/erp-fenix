from src import db


class MdfeLacreModel(db.Model):
    __tablename__ = 'mdfe_lacre'

    id = db.Column(db.Integer, primary_key=True)
    numero_lacre = db.Column(db.String(20))
    id_mdfe_cabecalho = db.Column(db.Integer, db.ForeignKey('mdfe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_mdfe_cabecalho = data.get('idMdfeCabecalho')
        self.numero_lacre = data.get('numeroLacre')

    def serialize(self):
        return {
            'id': self.id,
            'idMdfeCabecalho': self.id_mdfe_cabecalho,
            'numeroLacre': self.numero_lacre,
        }