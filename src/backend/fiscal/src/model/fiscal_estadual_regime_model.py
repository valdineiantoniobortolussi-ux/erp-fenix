from src import db


class FiscalEstadualRegimeModel(db.Model):
    __tablename__ = 'fiscal_estadual_regime'

    id = db.Column(db.Integer, primary_key=True)
    uf = db.Column(db.String(2))
    codigo = db.Column(db.String(20))
    nome = db.Column(db.String(50))


    def mapping(self, data):
        self.id = data.get('id')
        self.uf = data.get('uf')
        self.codigo = data.get('codigo')
        self.nome = data.get('nome')

    def serialize(self):
        return {
            'id': self.id,
            'uf': self.uf,
            'codigo': self.codigo,
            'nome': self.nome,
        }