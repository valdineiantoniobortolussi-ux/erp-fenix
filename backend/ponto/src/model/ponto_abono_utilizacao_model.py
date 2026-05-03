from src import db


class PontoAbonoUtilizacaoModel(db.Model):
    __tablename__ = 'ponto_abono_utilizacao'

    id = db.Column(db.Integer, primary_key=True)
    data_utilizacao = db.Column(db.DateTime)
    observacao = db.Column(db.Text)
    id_ponto_abono = db.Column(db.Integer, db.ForeignKey('ponto_abono.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_ponto_abono = data.get('idPontoAbono')
        self.data_utilizacao = data.get('dataUtilizacao')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idPontoAbono': self.id_ponto_abono,
            'dataUtilizacao': self.data_utilizacao.isoformat(),
            'observacao': self.observacao,
        }