from src import db


class OsEvolucaoModel(db.Model):
    __tablename__ = 'os_evolucao'

    id = db.Column(db.Integer, primary_key=True)
    data_registro = db.Column(db.DateTime)
    hora_registro = db.Column(db.String(8))
    enviar_email = db.Column(db.String(1))
    observacao = db.Column(db.Text)
    id_os_abertura = db.Column(db.Integer, db.ForeignKey('os_abertura.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_os_abertura = data.get('idOsAbertura')
        self.data_registro = data.get('dataRegistro')
        self.hora_registro = data.get('horaRegistro')
        self.enviar_email = data.get('enviarEmail')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idOsAbertura': self.id_os_abertura,
            'dataRegistro': self.data_registro.isoformat(),
            'horaRegistro': self.hora_registro,
            'enviarEmail': self.enviar_email,
            'observacao': self.observacao,
        }