from src import db


class NotaFiscalModeloModel(db.Model):
    __tablename__ = 'nota_fiscal_modelo'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(2))
    descricao = db.Column(db.String(100))
    modelo = db.Column(db.String(10))


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.descricao = data.get('descricao')
        self.modelo = data.get('modelo')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'descricao': self.descricao,
            'modelo': self.modelo,
        }