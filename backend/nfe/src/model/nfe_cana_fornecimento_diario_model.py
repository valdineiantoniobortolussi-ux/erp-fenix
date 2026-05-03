from src import db
from src.model.nfe_cana_model import NfeCanaModel


class NfeCanaFornecimentoDiarioModel(db.Model):
    __tablename__ = 'nfe_cana_fornecimento_diario'

    id = db.Column(db.Integer, primary_key=True)
    dia = db.Column(db.String(2))
    quantidade = db.Column(db.Float)
    quantidade_total_mes = db.Column(db.Float)
    quantidade_total_anterior = db.Column(db.Float)
    quantidade_total_geral = db.Column(db.Float)
    id_nfe_cana = db.Column(db.Integer, db.ForeignKey('nfe_cana.id'))

    nfe_cana_model = db.relationship('NfeCanaModel', foreign_keys=[id_nfe_cana])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_cana = data.get('idNfeCana')
        self.dia = data.get('dia')
        self.quantidade = data.get('quantidade')
        self.quantidade_total_mes = data.get('quantidadeTotalMes')
        self.quantidade_total_anterior = data.get('quantidadeTotalAnterior')
        self.quantidade_total_geral = data.get('quantidadeTotalGeral')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeCana': self.id_nfe_cana,
            'dia': self.dia,
            'quantidade': self.quantidade,
            'quantidadeTotalMes': self.quantidade_total_mes,
            'quantidadeTotalAnterior': self.quantidade_total_anterior,
            'quantidadeTotalGeral': self.quantidade_total_geral,
            'nfeCanaModel': self.nfe_cana_model.serialize() if self.nfe_cana_model else None,
        }