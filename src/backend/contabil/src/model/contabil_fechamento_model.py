from src import db


class ContabilFechamentoModel(db.Model):
    __tablename__ = 'contabil_fechamento'

    id = db.Column(db.Integer, primary_key=True)
    data_inicio = db.Column(db.DateTime)
    data_fim = db.Column(db.DateTime)
    criterio_lancamento = db.Column(db.String(1))


    def mapping(self, data):
        self.id = data.get('id')
        self.data_inicio = data.get('dataInicio')
        self.data_fim = data.get('dataFim')
        self.criterio_lancamento = data.get('criterioLancamento')

    def serialize(self):
        return {
            'id': self.id,
            'dataInicio': self.data_inicio.isoformat(),
            'dataFim': self.data_fim.isoformat(),
            'criterioLancamento': self.criterio_lancamento,
        }