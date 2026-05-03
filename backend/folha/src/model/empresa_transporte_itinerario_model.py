from src import db


class EmpresaTransporteItinerarioModel(db.Model):
    __tablename__ = 'empresa_transporte_itinerario'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    tarifa = db.Column(db.Float)
    trajeto = db.Column(db.Text)
    id_empresa_transporte = db.Column(db.Integer, db.ForeignKey('empresa_transporte.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_empresa_transporte = data.get('idEmpresaTransporte')
        self.nome = data.get('nome')
        self.tarifa = data.get('tarifa')
        self.trajeto = data.get('trajeto')

    def serialize(self):
        return {
            'id': self.id,
            'idEmpresaTransporte': self.id_empresa_transporte,
            'nome': self.nome,
            'tarifa': self.tarifa,
            'trajeto': self.trajeto,
        }