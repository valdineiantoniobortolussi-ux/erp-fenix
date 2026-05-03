from src import db


class FolhaPppCatModel(db.Model):
    __tablename__ = 'folha_ppp_cat'

    id = db.Column(db.Integer, primary_key=True)
    numero_cat = db.Column(db.Integer)
    data_afastamento = db.Column(db.DateTime)
    data_registro = db.Column(db.DateTime)
    id_folha_ppp = db.Column(db.Integer, db.ForeignKey('folha_ppp.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_folha_ppp = data.get('idFolhaPpp')
        self.numero_cat = data.get('numeroCat')
        self.data_afastamento = data.get('dataAfastamento')
        self.data_registro = data.get('dataRegistro')

    def serialize(self):
        return {
            'id': self.id,
            'idFolhaPpp': self.id_folha_ppp,
            'numeroCat': self.numero_cat,
            'dataAfastamento': self.data_afastamento.isoformat(),
            'dataRegistro': self.data_registro.isoformat(),
        }