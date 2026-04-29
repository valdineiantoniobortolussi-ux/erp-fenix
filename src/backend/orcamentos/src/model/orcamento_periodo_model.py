from src import db


class OrcamentoPeriodoModel(db.Model):
    __tablename__ = 'orcamento_periodo'

    id = db.Column(db.Integer, primary_key=True)
    periodo = db.Column(db.String(1))
    nome = db.Column(db.String(30))


    def mapping(self, data):
        self.id = data.get('id')
        self.periodo = data.get('periodo')
        self.nome = data.get('nome')

    def serialize(self):
        return {
            'id': self.id,
            'periodo': self.periodo,
            'nome': self.nome,
        }