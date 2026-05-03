from src import db


class PlanoCentroResultadoModel(db.Model):
    __tablename__ = 'plano_centro_resultado'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    mascara = db.Column(db.String(50))
    niveis = db.Column(db.Integer)
    data_inclusao = db.Column(db.DateTime)


    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.mascara = data.get('mascara')
        self.niveis = data.get('niveis')
        self.data_inclusao = data.get('dataInclusao')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'mascara': self.mascara,
            'niveis': self.niveis,
            'dataInclusao': self.data_inclusao.isoformat(),
        }