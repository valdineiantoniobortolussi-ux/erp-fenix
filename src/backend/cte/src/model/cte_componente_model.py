from src import db


class CteComponenteModel(db.Model):
    __tablename__ = 'cte_componente'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(15))
    valor = db.Column(db.Float)
    id_cte_cabecalho = db.Column(db.Integer, db.ForeignKey('cte_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_cabecalho = data.get('idCteCabecalho')
        self.nome = data.get('nome')
        self.valor = data.get('valor')

    def serialize(self):
        return {
            'id': self.id,
            'idCteCabecalho': self.id_cte_cabecalho,
            'nome': self.nome,
            'valor': self.valor,
        }