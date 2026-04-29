from src import db
from src.model.patrim_bem_model import PatrimBemModel


class PcpServicoEquipamentoModel(db.Model):
    __tablename__ = 'pcp_servico_equipamento'

    id = db.Column(db.Integer, primary_key=True)
    id_pcp_servico = db.Column(db.Integer, db.ForeignKey('pcp_servico.id'))
    id_patrim_bem = db.Column(db.Integer, db.ForeignKey('patrim_bem.id'))

    patrim_bem_model = db.relationship('PatrimBemModel', foreign_keys=[id_patrim_bem])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_pcp_servico = data.get('idPcpServico')
        self.id_patrim_bem = data.get('idPatrimBem')

    def serialize(self):
        return {
            'id': self.id,
            'idPcpServico': self.id_pcp_servico,
            'idPatrimBem': self.id_patrim_bem,
            'patrimBemModel': self.patrim_bem_model.serialize() if self.patrim_bem_model else None,
        }