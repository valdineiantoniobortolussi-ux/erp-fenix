from src import db
from src.model.wms_recebimento_detalhe_model import WmsRecebimentoDetalheModel
from src.model.wms_agendamento_model import WmsAgendamentoModel


class WmsRecebimentoCabecalhoModel(db.Model):
    __tablename__ = 'wms_recebimento_cabecalho'

    id = db.Column(db.Integer, primary_key=True)
    data_recebimento = db.Column(db.DateTime)
    hora_inicio = db.Column(db.String(8))
    hora_fim = db.Column(db.String(8))
    volume_recebido = db.Column(db.Integer)
    peso_recebido = db.Column(db.Float)
    inconsistencia = db.Column(db.String(1))
    observacao = db.Column(db.Text)
    id_wms_agendamento = db.Column(db.Integer, db.ForeignKey('wms_agendamento.id'))

    wms_recebimento_detalhe_model_list = db.relationship('WmsRecebimentoDetalheModel', lazy='dynamic')
    wms_agendamento_model = db.relationship('WmsAgendamentoModel', foreign_keys=[id_wms_agendamento])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_wms_agendamento = data.get('idWmsAgendamento')
        self.data_recebimento = data.get('dataRecebimento')
        self.hora_inicio = data.get('horaInicio')
        self.hora_fim = data.get('horaFim')
        self.volume_recebido = data.get('volumeRecebido')
        self.peso_recebido = data.get('pesoRecebido')
        self.inconsistencia = data.get('inconsistencia')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idWmsAgendamento': self.id_wms_agendamento,
            'dataRecebimento': self.data_recebimento.isoformat(),
            'horaInicio': self.hora_inicio,
            'horaFim': self.hora_fim,
            'volumeRecebido': self.volume_recebido,
            'pesoRecebido': self.peso_recebido,
            'inconsistencia': self.inconsistencia,
            'observacao': self.observacao,
            'wmsRecebimentoDetalheModelList': [wms_recebimento_detalhe_model.serialize() for wms_recebimento_detalhe_model in self.wms_recebimento_detalhe_model_list],
            'wmsAgendamentoModel': self.wms_agendamento_model.serialize() if self.wms_agendamento_model else None,
        }