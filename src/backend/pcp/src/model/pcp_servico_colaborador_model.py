from src import db
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel


class PcpServicoColaboradorModel(db.Model):
    __tablename__ = 'pcp_servico_colaborador'

    id = db.Column(db.Integer, primary_key=True)
    id_pcp_servico = db.Column(db.Integer, db.ForeignKey('pcp_servico.id'))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_pcp_servico = data.get('idPcpServico')
        self.id_colaborador = data.get('idColaborador')

    def serialize(self):
        return {
            'id': self.id,
            'idPcpServico': self.id_pcp_servico,
            'idColaborador': self.id_colaborador,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
        }