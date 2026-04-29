from src import db


class WmsParametroModel(db.Model):
    __tablename__ = 'wms_parametro'

    id = db.Column(db.Integer, primary_key=True)
    hora_por_volume = db.Column(db.Integer)
    pessoa_por_volume = db.Column(db.Integer)
    hora_por_peso = db.Column(db.Integer)
    pessoa_por_peso = db.Column(db.Integer)
    item_diferente_caixa = db.Column(db.String(1))


    def mapping(self, data):
        self.id = data.get('id')
        self.hora_por_volume = data.get('horaPorVolume')
        self.pessoa_por_volume = data.get('pessoaPorVolume')
        self.hora_por_peso = data.get('horaPorPeso')
        self.pessoa_por_peso = data.get('pessoaPorPeso')
        self.item_diferente_caixa = data.get('itemDiferenteCaixa')

    def serialize(self):
        return {
            'id': self.id,
            'horaPorVolume': self.hora_por_volume,
            'pessoaPorVolume': self.pessoa_por_volume,
            'horaPorPeso': self.hora_por_peso,
            'pessoaPorPeso': self.pessoa_por_peso,
            'itemDiferenteCaixa': self.item_diferente_caixa,
        }