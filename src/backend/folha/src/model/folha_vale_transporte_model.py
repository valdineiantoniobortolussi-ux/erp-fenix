from src import db
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel
from src.model.empresa_transporte_itinerario_model import EmpresaTransporteItinerarioModel


class FolhaValeTransporteModel(db.Model):
    __tablename__ = 'folha_vale_transporte'

    id = db.Column(db.Integer, primary_key=True)
    quantidade = db.Column(db.Integer)
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))
    id_empresa_transp_itin = db.Column(db.Integer, db.ForeignKey('empresa_transporte_itinerario.id'))

    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])
    empresa_transporte_itinerario_model = db.relationship('EmpresaTransporteItinerarioModel', foreign_keys=[id_empresa_transp_itin])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_colaborador = data.get('idColaborador')
        self.id_empresa_transp_itin = data.get('idEmpresaTranspItin')
        self.quantidade = data.get('quantidade')

    def serialize(self):
        return {
            'id': self.id,
            'idColaborador': self.id_colaborador,
            'idEmpresaTranspItin': self.id_empresa_transp_itin,
            'quantidade': self.quantidade,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
            'empresaTransporteItinerarioModel': self.empresa_transporte_itinerario_model.serialize() if self.empresa_transporte_itinerario_model else None,
        }