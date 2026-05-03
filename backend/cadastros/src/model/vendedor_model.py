from src import db
from src.model.comissao_perfil_model import ComissaoPerfilModel


class VendedorModel(db.Model):
    __tablename__ = 'vendedor'

    id = db.Column(db.Integer, primary_key=True)
    comissao = db.Column(db.Float)
    meta_venda = db.Column(db.Float)
    id_colaborador = db.Column(db.Integer, db.ForeignKey('colaborador.id'), unique=True)
    id_comissao_perfil = db.Column(db.Integer, db.ForeignKey('comissao_perfil.id'))

    comissao_perfil_model = db.relationship('ComissaoPerfilModel', foreign_keys=[id_comissao_perfil])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_colaborador = data.get('idColaborador')
        self.id_comissao_perfil = data.get('idComissaoPerfil')
        self.comissao = data.get('comissao')
        self.meta_venda = data.get('metaVenda')

    def serialize(self):
        return {
            'id': self.id,
            'idColaborador': self.id_colaborador,
            'idComissaoPerfil': self.id_comissao_perfil,
            'comissao': self.comissao,
            'metaVenda': self.meta_venda,
            'comissaoPerfilModel': self.comissao_perfil_model.serialize() if self.comissao_perfil_model else None,
        }