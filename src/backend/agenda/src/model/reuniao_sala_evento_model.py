from src import db
from src.model.reuniao_sala_model import ReuniaoSalaModel


class ReuniaoSalaEventoModel(db.Model):
    __tablename__ = 'reuniao_sala_evento'

    id = db.Column(db.Integer, primary_key=True)
    data_reserva = db.Column(db.DateTime)
    id_agenda_compromisso = db.Column(db.Integer, db.ForeignKey('agenda_compromisso.id'))
    id_reuniao_sala = db.Column(db.Integer, db.ForeignKey('reuniao_sala.id'))

    reuniao_sala_model = db.relationship('ReuniaoSalaModel', foreign_keys=[id_reuniao_sala])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_agenda_compromisso = data.get('idAgendaCompromisso')
        self.id_reuniao_sala = data.get('idReuniaoSala')
        self.data_reserva = data.get('dataReserva')

    def serialize(self):
        return {
            'id': self.id,
            'idAgendaCompromisso': self.id_agenda_compromisso,
            'idReuniaoSala': self.id_reuniao_sala,
            'dataReserva': self.data_reserva.isoformat(),
            'reuniaoSalaModel': self.reuniao_sala_model.serialize() if self.reuniao_sala_model else None,
        }