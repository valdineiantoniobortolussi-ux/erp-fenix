from src import db
from src.model.agenda_notificacao_model import AgendaNotificacaoModel
from src.model.agenda_compromisso_convidado_model import AgendaCompromissoConvidadoModel
from src.model.reuniao_sala_evento_model import ReuniaoSalaEventoModel
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel
from src.model.agenda_categoria_compromisso_model import AgendaCategoriaCompromissoModel


class AgendaCompromissoModel(db.Model):
    __tablename__ = 'agenda_compromisso'

    id = db.Column(db.Integer, primary_key=True)
    data_compromisso = db.Column(db.DateTime)
    hora = db.Column(db.String(8))
    duracao = db.Column(db.Integer)
    tipo = db.Column(db.String(1))
    onde = db.Column(db.String(100))
    descricao = db.Column(db.String(100))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))
    id_agenda_categoria_compromisso = db.Column(db.Integer, db.ForeignKey('agenda_categoria_compromisso.id'))

    agenda_notificacao_model_list = db.relationship('AgendaNotificacaoModel', lazy='dynamic')
    agenda_compromisso_convidado_model_list = db.relationship('AgendaCompromissoConvidadoModel', lazy='dynamic')
    reuniao_sala_evento_model_list = db.relationship('ReuniaoSalaEventoModel', lazy='dynamic')
    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])
    agenda_categoria_compromisso_model = db.relationship('AgendaCategoriaCompromissoModel', foreign_keys=[id_agenda_categoria_compromisso])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_agenda_categoria_compromisso = data.get('idAgendaCategoriaCompromisso')
        self.id_colaborador = data.get('idColaborador')
        self.data_compromisso = data.get('dataCompromisso')
        self.hora = data.get('hora')
        self.duracao = data.get('duracao')
        self.tipo = data.get('tipo')
        self.onde = data.get('onde')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'idAgendaCategoriaCompromisso': self.id_agenda_categoria_compromisso,
            'idColaborador': self.id_colaborador,
            'dataCompromisso': self.data_compromisso.isoformat(),
            'hora': self.hora,
            'duracao': self.duracao,
            'tipo': self.tipo,
            'onde': self.onde,
            'descricao': self.descricao,
            'agendaNotificacaoModelList': [agenda_notificacao_model.serialize() for agenda_notificacao_model in self.agenda_notificacao_model_list],
            'agendaCompromissoConvidadoModelList': [agenda_compromisso_convidado_model.serialize() for agenda_compromisso_convidado_model in self.agenda_compromisso_convidado_model_list],
            'reuniaoSalaEventoModelList': [reuniao_sala_evento_model.serialize() for reuniao_sala_evento_model in self.reuniao_sala_evento_model_list],
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
            'agendaCategoriaCompromissoModel': self.agenda_categoria_compromisso_model.serialize() if self.agenda_categoria_compromisso_model else None,
        }