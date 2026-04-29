from src import db


class TributIcmsCustomCabModel(db.Model):
    __tablename__ = 'tribut_icms_custom_cab'

    id = db.Column(db.Integer, primary_key=True)
    descricao = db.Column(db.String(100))
    origem_mercadoria = db.Column(db.String(1))


    def mapping(self, data):
        self.id = data.get('id')
        self.descricao = data.get('descricao')
        self.origem_mercadoria = data.get('origemMercadoria')

    def serialize(self):
        return {
            'id': self.id,
            'descricao': self.descricao,
            'origemMercadoria': self.origem_mercadoria,
        }