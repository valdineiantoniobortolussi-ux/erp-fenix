from src import db


class CteAquaviarioModel(db.Model):
    __tablename__ = 'cte_aquaviario'

    id = db.Column(db.Integer, primary_key=True)
    valor_prestacao = db.Column(db.Float)
    afrmm = db.Column(db.Float)
    numero_booking = db.Column(db.String(10))
    numero_controle = db.Column(db.String(10))
    id_navio = db.Column(db.String(60))
    id_cte_cabecalho = db.Column(db.Integer, db.ForeignKey('cte_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_cabecalho = data.get('idCteCabecalho')
        self.valor_prestacao = data.get('valorPrestacao')
        self.afrmm = data.get('afrmm')
        self.numero_booking = data.get('numeroBooking')
        self.numero_controle = data.get('numeroControle')
        self.id_navio = data.get('idNavio')

    def serialize(self):
        return {
            'id': self.id,
            'idCteCabecalho': self.id_cte_cabecalho,
            'valorPrestacao': self.valor_prestacao,
            'afrmm': self.afrmm,
            'numeroBooking': self.numero_booking,
            'numeroControle': self.numero_controle,
            'idNavio': self.id_navio,
        }