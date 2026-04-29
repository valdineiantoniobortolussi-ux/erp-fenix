from src import db


class AgendaNotificacaoModel(db.Model):
    __tablename__ = 'agenda_notificacao'

    id = db.Column(db.Integer, primary_key=True)
    data_notificacao = db.Column(db.DateTime)
    hora = db.Column(db.String(8))
    tipo = db.Column(db.String(1))
    id_agenda_compromisso = db.Column(db.Integer, db.ForeignKey('agenda_compromisso.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_agenda_compromisso = data.get('idAgendaCompromisso')
        self.data_notificacao = data.get('dataNotificacao')
        self.hora = data.get('hora')
        self.tipo = data.get('tipo')

    def serialize(self):
        return {
            'id': self.id,
            'idAgendaCompromisso': self.id_agenda_compromisso,
            'dataNotificacao': self.data_notificacao.isoformat(),
            'hora': self.hora,
            'tipo': self.tipo,
        }