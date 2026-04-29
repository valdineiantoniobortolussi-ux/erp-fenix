from src import db
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel


class RecadoDestinatarioModel(db.Model):
    __tablename__ = 'recado_destinatario'

    id = db.Column(db.Integer, primary_key=True)
    id_recado_remetente = db.Column(db.Integer, db.ForeignKey('recado_remetente.id'))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_recado_remetente = data.get('idRecadoRemetente')
        self.id_colaborador = data.get('idColaborador')

    def serialize(self):
        return {
            'id': self.id,
            'idRecadoRemetente': self.id_recado_remetente,
            'idColaborador': self.id_colaborador,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
        }