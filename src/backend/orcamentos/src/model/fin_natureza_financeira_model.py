from src import db


class FinNaturezaFinanceiraModel(db.Model):
    __tablename__ = 'fin_natureza_financeira'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(4))
    descricao = db.Column(db.String(100))
    tipo = db.Column(db.String(1))
    aplicacao = db.Column(db.String(250))


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.descricao = data.get('descricao')
        self.tipo = data.get('tipo')
        self.aplicacao = data.get('aplicacao')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'descricao': self.descricao,
            'tipo': self.tipo,
            'aplicacao': self.aplicacao,
        }