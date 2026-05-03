from src import db


class CargoModel(db.Model):
    __tablename__ = 'cargo'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    descricao = db.Column(db.String(250))
    salario = db.Column(db.Float)
    cbo_1994 = db.Column(db.String(10))
    cbo_2002 = db.Column(db.String(10))


    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')
        self.salario = data.get('salario')
        self.cbo_1994 = data.get('cbo1994')
        self.cbo_2002 = data.get('cbo2002')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'descricao': self.descricao,
            'salario': self.salario,
            'cbo1994': self.cbo_1994,
            'cbo2002': self.cbo_2002,
        }