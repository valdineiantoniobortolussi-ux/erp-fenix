from src import db


class ContabilIndiceValorModel(db.Model):
    __tablename__ = 'contabil_indice_valor'

    id = db.Column(db.Integer, primary_key=True)
    data_indice = db.Column(db.DateTime)
    valor = db.Column(db.Float)
    id_contabil_indice = db.Column(db.Integer, db.ForeignKey('contabil_indice.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_contabil_indice = data.get('idContabilIndice')
        self.data_indice = data.get('dataIndice')
        self.valor = data.get('valor')

    def serialize(self):
        return {
            'id': self.id,
            'idContabilIndice': self.id_contabil_indice,
            'dataIndice': self.data_indice.isoformat(),
            'valor': self.valor,
        }