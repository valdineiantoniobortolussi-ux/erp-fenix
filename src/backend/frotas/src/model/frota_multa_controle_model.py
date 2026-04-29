from src import db


class FrotaMultaControleModel(db.Model):
    __tablename__ = 'frota_multa_controle'

    id = db.Column(db.Integer, primary_key=True)
    data_multa = db.Column(db.DateTime)
    pontos = db.Column(db.Integer)
    valor = db.Column(db.Float)
    observacao = db.Column(db.Text)
    id_frota_veiculo = db.Column(db.Integer, db.ForeignKey('frota_veiculo.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_frota_veiculo = data.get('idFrotaVeiculo')
        self.data_multa = data.get('dataMulta')
        self.pontos = data.get('pontos')
        self.valor = data.get('valor')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idFrotaVeiculo': self.id_frota_veiculo,
            'dataMulta': self.data_multa.isoformat(),
            'pontos': self.pontos,
            'valor': self.valor,
            'observacao': self.observacao,
        }