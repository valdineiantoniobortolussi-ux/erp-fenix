from src import db


class CstCofinsModel(db.Model):
    __tablename__ = 'cst_cofins'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(2))
    descricao = db.Column(db.String(250))
    observacao = db.Column(db.String(250))


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.descricao = data.get('descricao')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'descricao': self.descricao,
            'observacao': self.observacao,
        }