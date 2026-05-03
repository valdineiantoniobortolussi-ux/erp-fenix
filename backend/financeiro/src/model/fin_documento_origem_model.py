from src import db


class FinDocumentoOrigemModel(db.Model):
    __tablename__ = 'fin_documento_origem'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(3))
    sigla = db.Column(db.String(10))
    descricao = db.Column(db.Text)


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.sigla = data.get('sigla')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'sigla': self.sigla,
            'descricao': self.descricao,
        }