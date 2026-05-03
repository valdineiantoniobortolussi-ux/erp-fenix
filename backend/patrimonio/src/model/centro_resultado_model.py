from src import db


class CentroResultadoModel(db.Model):
    __tablename__ = 'centro_resultado'

    id = db.Column(db.Integer, primary_key=True)
    id_plano_centro_resultado = db.Column(db.Integer)
    classificacao = db.Column(db.String(30))
    descricao = db.Column(db.String(100))
    sofre_rateiro = db.Column(db.String(1))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_plano_centro_resultado = data.get('idPlanoCentroResultado')
        self.classificacao = data.get('classificacao')
        self.descricao = data.get('descricao')
        self.sofre_rateiro = data.get('sofreRateiro')

    def serialize(self):
        return {
            'id': self.id,
            'idPlanoCentroResultado': self.id_plano_centro_resultado,
            'classificacao': self.classificacao,
            'descricao': self.descricao,
            'sofreRateiro': self.sofre_rateiro,
        }