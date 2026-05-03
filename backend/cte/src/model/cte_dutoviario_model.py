from src import db


class CteDutoviarioModel(db.Model):
    __tablename__ = 'cte_dutoviario'

    id = db.Column(db.Integer, primary_key=True)
    valor_tarifa = db.Column(db.Float)
    data_inicio = db.Column(db.DateTime)
    data_fim = db.Column(db.DateTime)
    id_cte_cabecalho = db.Column(db.Integer, db.ForeignKey('cte_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_cabecalho = data.get('idCteCabecalho')
        self.valor_tarifa = data.get('valorTarifa')
        self.data_inicio = data.get('dataInicio')
        self.data_fim = data.get('dataFim')

    def serialize(self):
        return {
            'id': self.id,
            'idCteCabecalho': self.id_cte_cabecalho,
            'valorTarifa': self.valor_tarifa,
            'dataInicio': self.data_inicio.isoformat(),
            'dataFim': self.data_fim.isoformat(),
        }