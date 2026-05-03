from src import db
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel


class ProjetoStakeholdersModel(db.Model):
    __tablename__ = 'projeto_stakeholders'

    id = db.Column(db.Integer, primary_key=True)
    id_projeto_principal = db.Column(db.Integer, db.ForeignKey('projeto_principal.id'))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_projeto_principal = data.get('idProjetoPrincipal')
        self.id_colaborador = data.get('idColaborador')

    def serialize(self):
        return {
            'id': self.id,
            'idProjetoPrincipal': self.id_projeto_principal,
            'idColaborador': self.id_colaborador,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
        }