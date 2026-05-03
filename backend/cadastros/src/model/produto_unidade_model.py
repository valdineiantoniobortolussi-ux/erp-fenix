from src import db


class ProdutoUnidadeModel(db.Model):
    __tablename__ = 'produto_unidade'

    id = db.Column(db.Integer, primary_key=True)
    sigla = db.Column(db.String(10))
    pode_fracionar = db.Column(db.String(1))
    descricao = db.Column(db.String(250))


    def mapping(self, data):
        self.id = data.get('id')
        self.sigla = data.get('sigla')
        self.pode_fracionar = data.get('podeFracionar')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'sigla': self.sigla,
            'podeFracionar': self.pode_fracionar,
            'descricao': self.descricao,
        }