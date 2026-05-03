from src import db


class FrotaVeiculoSinistroModel(db.Model):
    __tablename__ = 'frota_veiculo_sinistro'

    id = db.Column(db.Integer, primary_key=True)
    data_sinistro = db.Column(db.DateTime)
    observacao = db.Column(db.Text)
    id_frota_veiculo = db.Column(db.Integer, db.ForeignKey('frota_veiculo.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_frota_veiculo = data.get('idFrotaVeiculo')
        self.data_sinistro = data.get('dataSinistro')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idFrotaVeiculo': self.id_frota_veiculo,
            'dataSinistro': self.data_sinistro.isoformat(),
            'observacao': self.observacao,
        }