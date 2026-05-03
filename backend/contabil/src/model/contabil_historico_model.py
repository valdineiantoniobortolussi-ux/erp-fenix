from src import db


class ContabilHistoricoModel(db.Model):
    __tablename__ = 'contabil_historico'

    id = db.Column(db.Integer, primary_key=True)
    descricao = db.Column(db.String(100))
    pede_complemento = db.Column(db.String(1))
    historico = db.Column(db.String(250))


    def mapping(self, data):
        self.id = data.get('id')
        self.descricao = data.get('descricao')
        self.pede_complemento = data.get('pedeComplemento')
        self.historico = data.get('historico')

    def serialize(self):
        return {
            'id': self.id,
            'descricao': self.descricao,
            'pedeComplemento': self.pede_complemento,
            'historico': self.historico,
        }