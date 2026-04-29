from src import db


class ChequeModel(db.Model):
    __tablename__ = 'cheque'

    id = db.Column(db.Integer, primary_key=True)
    numero = db.Column(db.Integer)
    status_cheque = db.Column(db.String(1))
    data_status = db.Column(db.DateTime)
    id_talonario_cheque = db.Column(db.Integer, db.ForeignKey('talonario_cheque.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_talonario_cheque = data.get('idTalonarioCheque')
        self.numero = data.get('numero')
        self.status_cheque = data.get('statusCheque')
        self.data_status = data.get('dataStatus')

    def serialize(self):
        return {
            'id': self.id,
            'idTalonarioCheque': self.id_talonario_cheque,
            'numero': self.numero,
            'statusCheque': self.status_cheque,
            'dataStatus': self.data_status.isoformat(),
        }