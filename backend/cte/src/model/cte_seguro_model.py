from src import db


class CteSeguroModel(db.Model):
    __tablename__ = 'cte_seguro'

    id = db.Column(db.Integer, primary_key=True)
    responsavel = db.Column(db.String(1))
    seguradora = db.Column(db.String(30))
    apolice = db.Column(db.String(20))
    averbacao = db.Column(db.String(20))
    valor_carga = db.Column(db.Float)
    id_cte_cabecalho = db.Column(db.Integer, db.ForeignKey('cte_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_cabecalho = data.get('idCteCabecalho')
        self.responsavel = data.get('responsavel')
        self.seguradora = data.get('seguradora')
        self.apolice = data.get('apolice')
        self.averbacao = data.get('averbacao')
        self.valor_carga = data.get('valorCarga')

    def serialize(self):
        return {
            'id': self.id,
            'idCteCabecalho': self.id_cte_cabecalho,
            'responsavel': self.responsavel,
            'seguradora': self.seguradora,
            'apolice': self.apolice,
            'averbacao': self.averbacao,
            'valorCarga': self.valor_carga,
        }