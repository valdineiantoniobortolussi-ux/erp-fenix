from src import db
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel


class FrotaMotoristaModel(db.Model):
    __tablename__ = 'frota_motorista'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    numero_cnh = db.Column(db.String(11))
    cnh_categoria = db.Column(db.String(1))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_colaborador = data.get('idColaborador')
        self.nome = data.get('nome')
        self.numero_cnh = data.get('numeroCnh')
        self.cnh_categoria = data.get('cnhCategoria')

    def serialize(self):
        return {
            'id': self.id,
            'idColaborador': self.id_colaborador,
            'nome': self.nome,
            'numeroCnh': self.numero_cnh,
            'cnhCategoria': self.cnh_categoria,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
        }