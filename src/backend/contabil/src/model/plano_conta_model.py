from src import db


class PlanoContaModel(db.Model):
    __tablename__ = 'plano_conta'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    data_inclusao = db.Column(db.DateTime)
    mascara = db.Column(db.String(50))
    niveis = db.Column(db.Integer)


    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.data_inclusao = data.get('dataInclusao')
        self.mascara = data.get('mascara')
        self.niveis = data.get('niveis')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'dataInclusao': self.data_inclusao.isoformat(),
            'mascara': self.mascara,
            'niveis': self.niveis,
        }