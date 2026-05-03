from src import db


class PatrimDepreciacaoBemModel(db.Model):
    __tablename__ = 'patrim_depreciacao_bem'

    id = db.Column(db.Integer, primary_key=True)
    data_depreciacao = db.Column(db.DateTime)
    dias = db.Column(db.Integer)
    taxa = db.Column(db.Float)
    indice = db.Column(db.Float)
    valor = db.Column(db.Float)
    depreciacao_acumulada = db.Column(db.Float)
    id_patrim_bem = db.Column(db.Integer, db.ForeignKey('patrim_bem.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_patrim_bem = data.get('idPatrimBem')
        self.data_depreciacao = data.get('dataDepreciacao')
        self.dias = data.get('dias')
        self.taxa = data.get('taxa')
        self.indice = data.get('indice')
        self.valor = data.get('valor')
        self.depreciacao_acumulada = data.get('depreciacaoAcumulada')

    def serialize(self):
        return {
            'id': self.id,
            'idPatrimBem': self.id_patrim_bem,
            'dataDepreciacao': self.data_depreciacao.isoformat(),
            'dias': self.dias,
            'taxa': self.taxa,
            'indice': self.indice,
            'valor': self.valor,
            'depreciacaoAcumulada': self.depreciacao_acumulada,
        }