from src import db


class EsocialNaturezaJuridicaModel(db.Model):
    __tablename__ = 'esocial_natureza_juridica'

    id = db.Column(db.Integer, primary_key=True)
    grupo = db.Column(db.Integer)
    codigo = db.Column(db.String(5))
    descricao = db.Column(db.String(100))


    def mapping(self, data):
        self.id = data.get('id')
        self.grupo = data.get('grupo')
        self.codigo = data.get('codigo')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'grupo': self.grupo,
            'codigo': self.codigo,
            'descricao': self.descricao,
        }