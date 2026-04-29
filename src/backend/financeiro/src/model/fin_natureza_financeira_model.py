from src import db


class FinNaturezaFinanceiraModel(db.Model):
    __tablename__ = 'fin_natureza_financeira'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(4))
    tipo = db.Column(db.String(1))
    descricao = db.Column(db.String(100))
    aplicacao = db.Column(db.String(250))


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.tipo = data.get('tipo')
        self.descricao = data.get('descricao')
        self.aplicacao = data.get('aplicacao')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'tipo': self.tipo,
            'descricao': self.descricao,
            'aplicacao': self.aplicacao,
        }