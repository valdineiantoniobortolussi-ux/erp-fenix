from src import db
from src.model.pcp_instrucao_model import PcpInstrucaoModel


class PcpInstrucaoOpModel(db.Model):
    __tablename__ = 'pcp_instrucao_op'

    id = db.Column(db.Integer, primary_key=True)
    id_pcp_op_cabecalho = db.Column(db.Integer, db.ForeignKey('pcp_op_cabecalho.id'))
    id_pcp_instrucao = db.Column(db.Integer, db.ForeignKey('pcp_instrucao.id'))

    pcp_instrucao_model = db.relationship('PcpInstrucaoModel', foreign_keys=[id_pcp_instrucao])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_pcp_op_cabecalho = data.get('idPcpOpCabecalho')
        self.id_pcp_instrucao = data.get('idPcpInstrucao')

    def serialize(self):
        return {
            'id': self.id,
            'idPcpOpCabecalho': self.id_pcp_op_cabecalho,
            'idPcpInstrucao': self.id_pcp_instrucao,
            'pcpInstrucaoModel': self.pcp_instrucao_model.serialize() if self.pcp_instrucao_model else None,
        }