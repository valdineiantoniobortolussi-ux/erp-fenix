from src import db


class FrotaCombustivelControleModel(db.Model):
    __tablename__ = 'frota_combustivel_controle'

    id = db.Column(db.Integer, primary_key=True)
    data_abastecimento = db.Column(db.DateTime)
    hora_abastecimento = db.Column(db.String(8))
    valor_abastecimento = db.Column(db.Float)
    id_frota_veiculo = db.Column(db.Integer, db.ForeignKey('frota_veiculo.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_frota_veiculo = data.get('idFrotaVeiculo')
        self.data_abastecimento = data.get('dataAbastecimento')
        self.hora_abastecimento = data.get('horaAbastecimento')
        self.valor_abastecimento = data.get('valorAbastecimento')

    def serialize(self):
        return {
            'id': self.id,
            'idFrotaVeiculo': self.id_frota_veiculo,
            'dataAbastecimento': self.data_abastecimento.isoformat(),
            'horaAbastecimento': self.hora_abastecimento,
            'valorAbastecimento': self.valor_abastecimento,
        }