from src import db
from src.model.recado_destinatario_model import RecadoDestinatarioModel
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel


class RecadoRemetenteModel(db.Model):
    __tablename__ = 'recado_remetente'

    id = db.Column(db.Integer, primary_key=True)
    data_envio = db.Column(db.DateTime)
    hora_envio = db.Column(db.String(8))
    assunto = db.Column(db.String(100))
    texto = db.Column(db.Text)
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    recado_destinatario_model_list = db.relationship('RecadoDestinatarioModel', lazy='dynamic')
    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_colaborador = data.get('idColaborador')
        self.data_envio = data.get('dataEnvio')
        self.hora_envio = data.get('horaEnvio')
        self.assunto = data.get('assunto')
        self.texto = data.get('texto')

    def serialize(self):
        return {
            'id': self.id,
            'idColaborador': self.id_colaborador,
            'dataEnvio': self.data_envio.isoformat(),
            'horaEnvio': self.hora_envio,
            'assunto': self.assunto,
            'texto': self.texto,
            'recadoDestinatarioModelList': [recado_destinatario_model.serialize() for recado_destinatario_model in self.recado_destinatario_model_list],
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
        }