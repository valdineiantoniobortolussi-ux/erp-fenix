from src import db
from src.model.os_equipamento_model import OsEquipamentoModel


class OsAberturaEquipamentoModel(db.Model):
    __tablename__ = 'os_abertura_equipamento'

    id = db.Column(db.Integer, primary_key=True)
    tipo_cobertura = db.Column(db.String(1))
    numero_serie = db.Column(db.String(50))
    id_os_abertura = db.Column(db.Integer, db.ForeignKey('os_abertura.id'))
    id_os_equipamento = db.Column(db.Integer, db.ForeignKey('os_equipamento.id'))

    os_equipamento_model = db.relationship('OsEquipamentoModel', foreign_keys=[id_os_equipamento])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_os_abertura = data.get('idOsAbertura')
        self.id_os_equipamento = data.get('idOsEquipamento')
        self.tipo_cobertura = data.get('tipoCobertura')
        self.numero_serie = data.get('numeroSerie')

    def serialize(self):
        return {
            'id': self.id,
            'idOsAbertura': self.id_os_abertura,
            'idOsEquipamento': self.id_os_equipamento,
            'tipoCobertura': self.tipo_cobertura,
            'numeroSerie': self.numero_serie,
            'osEquipamentoModel': self.os_equipamento_model.serialize() if self.os_equipamento_model else None,
        }