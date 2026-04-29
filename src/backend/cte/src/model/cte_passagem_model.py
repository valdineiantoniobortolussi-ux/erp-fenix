from src import db


class CtePassagemModel(db.Model):
    __tablename__ = 'cte_passagem'

    id = db.Column(db.Integer, primary_key=True)
    sigla_passagem = db.Column(db.String(15))
    sigla_destino = db.Column(db.String(15))
    rota = db.Column(db.String(10))
    id_cte_cabecalho = db.Column(db.Integer, db.ForeignKey('cte_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_cabecalho = data.get('idCteCabecalho')
        self.sigla_passagem = data.get('siglaPassagem')
        self.sigla_destino = data.get('siglaDestino')
        self.rota = data.get('rota')

    def serialize(self):
        return {
            'id': self.id,
            'idCteCabecalho': self.id_cte_cabecalho,
            'siglaPassagem': self.sigla_passagem,
            'siglaDestino': self.sigla_destino,
            'rota': self.rota,
        }