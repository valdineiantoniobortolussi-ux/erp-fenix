from src import db
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel


class AgendaCompromissoConvidadoModel(db.Model):
    __tablename__ = 'agenda_compromisso_convidado'

    id = db.Column(db.Integer, primary_key=True)
    id_agenda_compromisso = db.Column(db.Integer, db.ForeignKey('agenda_compromisso.id'))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_agenda_compromisso = data.get('idAgendaCompromisso')
        self.id_colaborador = data.get('idColaborador')

    def serialize(self):
        return {
            'id': self.id,
            'idAgendaCompromisso': self.id_agenda_compromisso,
            'idColaborador': self.id_colaborador,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
        }