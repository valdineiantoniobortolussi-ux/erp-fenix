from src import db


class FinStatusParcelaModel(db.Model):
    __tablename__ = 'fin_status_parcela'

    id = db.Column(db.Integer, primary_key=True)
    situacao = db.Column(db.String(2))
    descricao = db.Column(db.String(30))
    procedimento = db.Column(db.Text)


    def mapping(self, data):
        self.id = data.get('id')
        self.situacao = data.get('situacao')
        self.descricao = data.get('descricao')
        self.procedimento = data.get('procedimento')

    def serialize(self):
        return {
            'id': self.id,
            'situacao': self.situacao,
            'descricao': self.descricao,
            'procedimento': self.procedimento,
        }