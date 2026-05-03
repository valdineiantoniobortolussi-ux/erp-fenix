from src import db


class WmsAgendamentoModel(db.Model):
    __tablename__ = 'wms_agendamento'

    id = db.Column(db.Integer, primary_key=True)
    data_operacao = db.Column(db.DateTime)
    hora_operacao = db.Column(db.String(8))
    local_operacao = db.Column(db.String(100))
    quantidade_volume = db.Column(db.Integer)
    peso_total_volume = db.Column(db.Float)
    quantidade_pessoa = db.Column(db.Integer)
    quantidade_hora = db.Column(db.Integer)


    def mapping(self, data):
        self.id = data.get('id')
        self.data_operacao = data.get('dataOperacao')
        self.hora_operacao = data.get('horaOperacao')
        self.local_operacao = data.get('localOperacao')
        self.quantidade_volume = data.get('quantidadeVolume')
        self.peso_total_volume = data.get('pesoTotalVolume')
        self.quantidade_pessoa = data.get('quantidadePessoa')
        self.quantidade_hora = data.get('quantidadeHora')

    def serialize(self):
        return {
            'id': self.id,
            'dataOperacao': self.data_operacao.isoformat(),
            'horaOperacao': self.hora_operacao,
            'localOperacao': self.local_operacao,
            'quantidadeVolume': self.quantidade_volume,
            'pesoTotalVolume': self.peso_total_volume,
            'quantidadePessoa': self.quantidade_pessoa,
            'quantidadeHora': self.quantidade_hora,
        }