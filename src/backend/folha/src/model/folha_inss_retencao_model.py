from src import db
from src.model.folha_inss_servico_model import FolhaInssServicoModel


class FolhaInssRetencaoModel(db.Model):
    __tablename__ = 'folha_inss_retencao'

    id = db.Column(db.Integer, primary_key=True)
    valor_mensal = db.Column(db.Float)
    valor_13 = db.Column(db.Float)
    id_folha_inss = db.Column(db.Integer, db.ForeignKey('folha_inss.id'))
    id_folha_inss_servico = db.Column(db.Integer, db.ForeignKey('folha_inss_servico.id'))

    folha_inss_servico_model = db.relationship('FolhaInssServicoModel', foreign_keys=[id_folha_inss_servico])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_folha_inss = data.get('idFolhaInss')
        self.id_folha_inss_servico = data.get('idFolhaInssServico')
        self.valor_mensal = data.get('valorMensal')
        self.valor_13 = data.get('valor13')

    def serialize(self):
        return {
            'id': self.id,
            'idFolhaInss': self.id_folha_inss,
            'idFolhaInssServico': self.id_folha_inss_servico,
            'valorMensal': self.valor_mensal,
            'valor13': self.valor_13,
            'folhaInssServicoModel': self.folha_inss_servico_model.serialize() if self.folha_inss_servico_model else None,
        }