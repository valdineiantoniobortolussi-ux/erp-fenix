from src import db


class FrotaVeiculoManutencaoModel(db.Model):
    __tablename__ = 'frota_veiculo_manutencao'

    id = db.Column(db.Integer, primary_key=True)
    tipo = db.Column(db.String(1))
    data_manutencao = db.Column(db.DateTime)
    valor_manutencao = db.Column(db.Float)
    observacao = db.Column(db.Text)
    id_frota_veiculo = db.Column(db.Integer, db.ForeignKey('frota_veiculo.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_frota_veiculo = data.get('idFrotaVeiculo')
        self.tipo = data.get('tipo')
        self.data_manutencao = data.get('dataManutencao')
        self.valor_manutencao = data.get('valorManutencao')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idFrotaVeiculo': self.id_frota_veiculo,
            'tipo': self.tipo,
            'dataManutencao': self.data_manutencao.isoformat(),
            'valorManutencao': self.valor_manutencao,
            'observacao': self.observacao,
        }