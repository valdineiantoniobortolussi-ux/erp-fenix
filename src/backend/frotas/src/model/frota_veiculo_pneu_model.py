from src import db


class FrotaVeiculoPneuModel(db.Model):
    __tablename__ = 'frota_veiculo_pneu'

    id = db.Column(db.Integer, primary_key=True)
    data_troca = db.Column(db.DateTime)
    valor_troca = db.Column(db.Float)
    posicao_pneu = db.Column(db.String(100))
    marca_pneu = db.Column(db.String(100))
    id_frota_veiculo = db.Column(db.Integer, db.ForeignKey('frota_veiculo.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_frota_veiculo = data.get('idFrotaVeiculo')
        self.data_troca = data.get('dataTroca')
        self.valor_troca = data.get('valorTroca')
        self.posicao_pneu = data.get('posicaoPneu')
        self.marca_pneu = data.get('marcaPneu')

    def serialize(self):
        return {
            'id': self.id,
            'idFrotaVeiculo': self.id_frota_veiculo,
            'dataTroca': self.data_troca.isoformat(),
            'valorTroca': self.valor_troca,
            'posicaoPneu': self.posicao_pneu,
            'marcaPneu': self.marca_pneu,
        }