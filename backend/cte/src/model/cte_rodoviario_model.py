from src import db


class CteRodoviarioModel(db.Model):
    __tablename__ = 'cte_rodoviario'

    id = db.Column(db.Integer, primary_key=True)
    rntrc = db.Column(db.String(8))
    data_prevista_entrega = db.Column(db.DateTime)
    indicador_lotacao = db.Column(db.String(1))
    ciot = db.Column(db.Integer)
    id_cte_cabecalho = db.Column(db.Integer, db.ForeignKey('cte_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_cabecalho = data.get('idCteCabecalho')
        self.rntrc = data.get('rntrc')
        self.data_prevista_entrega = data.get('dataPrevistaEntrega')
        self.indicador_lotacao = data.get('indicadorLotacao')
        self.ciot = data.get('ciot')

    def serialize(self):
        return {
            'id': self.id,
            'idCteCabecalho': self.id_cte_cabecalho,
            'rntrc': self.rntrc,
            'dataPrevistaEntrega': self.data_prevista_entrega.isoformat(),
            'indicadorLotacao': self.indicador_lotacao,
            'ciot': self.ciot,
        }