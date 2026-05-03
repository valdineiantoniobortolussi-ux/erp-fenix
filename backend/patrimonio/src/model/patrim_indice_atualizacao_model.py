from src import db


class PatrimIndiceAtualizacaoModel(db.Model):
    __tablename__ = 'patrim_indice_atualizacao'

    id = db.Column(db.Integer, primary_key=True)
    data_indice = db.Column(db.DateTime)
    nome = db.Column(db.String(10))
    valor = db.Column(db.Float)
    valor_alternativo = db.Column(db.Float)


    def mapping(self, data):
        self.id = data.get('id')
        self.data_indice = data.get('dataIndice')
        self.nome = data.get('nome')
        self.valor = data.get('valor')
        self.valor_alternativo = data.get('valorAlternativo')

    def serialize(self):
        return {
            'id': self.id,
            'dataIndice': self.data_indice.isoformat(),
            'nome': self.nome,
            'valor': self.valor,
            'valorAlternativo': self.valor_alternativo,
        }