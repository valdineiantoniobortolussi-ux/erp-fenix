from src import db
from src.model.frota_motorista_model import FrotaMotoristaModel


class FrotaVeiculoMovimentacaoModel(db.Model):
    __tablename__ = 'frota_veiculo_movimentacao'

    id = db.Column(db.Integer, primary_key=True)
    data_saida = db.Column(db.DateTime)
    hora_saida = db.Column(db.String(8))
    data_entrada = db.Column(db.DateTime)
    hora_entrada = db.Column(db.String(8))
    observacao = db.Column(db.Text)
    id_frota_veiculo = db.Column(db.Integer, db.ForeignKey('frota_veiculo.id'))
    id_frota_motorista = db.Column(db.Integer, db.ForeignKey('frota_motorista.id'))

    frota_motorista_model = db.relationship('FrotaMotoristaModel', foreign_keys=[id_frota_motorista])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_frota_veiculo = data.get('idFrotaVeiculo')
        self.id_frota_motorista = data.get('idFrotaMotorista')
        self.data_saida = data.get('dataSaida')
        self.hora_saida = data.get('horaSaida')
        self.data_entrada = data.get('dataEntrada')
        self.hora_entrada = data.get('horaEntrada')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idFrotaVeiculo': self.id_frota_veiculo,
            'idFrotaMotorista': self.id_frota_motorista,
            'dataSaida': self.data_saida.isoformat(),
            'horaSaida': self.hora_saida,
            'dataEntrada': self.data_entrada.isoformat(),
            'horaEntrada': self.hora_entrada,
            'observacao': self.observacao,
            'frotaMotoristaModel': self.frota_motorista_model.serialize() if self.frota_motorista_model else None,
        }