from src import db


class PontoBancoHorasUtilizacaoModel(db.Model):
    __tablename__ = 'ponto_banco_horas_utilizacao'

    id = db.Column(db.Integer, primary_key=True)
    data_utilizacao = db.Column(db.DateTime)
    quantidade_utilizada = db.Column(db.String(8))
    observacao = db.Column(db.Text)
    id_ponto_banco_horas = db.Column(db.Integer, db.ForeignKey('ponto_banco_horas.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_ponto_banco_horas = data.get('idPontoBancoHoras')
        self.data_utilizacao = data.get('dataUtilizacao')
        self.quantidade_utilizada = data.get('quantidadeUtilizada')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idPontoBancoHoras': self.id_ponto_banco_horas,
            'dataUtilizacao': self.data_utilizacao.isoformat(),
            'quantidadeUtilizada': self.quantidade_utilizada,
            'observacao': self.observacao,
        }