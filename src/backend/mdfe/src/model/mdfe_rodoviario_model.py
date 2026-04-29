from src import db


class MdfeRodoviarioModel(db.Model):
    __tablename__ = 'mdfe_rodoviario'

    id = db.Column(db.Integer, primary_key=True)
    rntrc = db.Column(db.String(8))
    codigo_agendamento = db.Column(db.String(16))
    id_mdfe_cabecalho = db.Column(db.Integer, db.ForeignKey('mdfe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_mdfe_cabecalho = data.get('idMdfeCabecalho')
        self.rntrc = data.get('rntrc')
        self.codigo_agendamento = data.get('codigoAgendamento')

    def serialize(self):
        return {
            'id': self.id,
            'idMdfeCabecalho': self.id_mdfe_cabecalho,
            'rntrc': self.rntrc,
            'codigoAgendamento': self.codigo_agendamento,
        }