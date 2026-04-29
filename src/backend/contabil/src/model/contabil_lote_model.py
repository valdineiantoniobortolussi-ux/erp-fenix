from src import db


class ContabilLoteModel(db.Model):
    __tablename__ = 'contabil_lote'

    id = db.Column(db.Integer, primary_key=True)
    descricao = db.Column(db.String(100))
    data_inclusao = db.Column(db.DateTime)
    data_liberacao = db.Column(db.DateTime)
    liberado = db.Column(db.String(1))
    programado = db.Column(db.String(1))
    valor = db.Column(db.Float)


    def mapping(self, data):
        self.id = data.get('id')
        self.descricao = data.get('descricao')
        self.data_inclusao = data.get('dataInclusao')
        self.data_liberacao = data.get('dataLiberacao')
        self.liberado = data.get('liberado')
        self.programado = data.get('programado')
        self.valor = data.get('valor')

    def serialize(self):
        return {
            'id': self.id,
            'descricao': self.descricao,
            'dataInclusao': self.data_inclusao.isoformat(),
            'dataLiberacao': self.data_liberacao.isoformat(),
            'liberado': self.liberado,
            'programado': self.programado,
            'valor': self.valor,
        }