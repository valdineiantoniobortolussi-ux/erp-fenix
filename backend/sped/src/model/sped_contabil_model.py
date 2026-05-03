from src import db


class SpedContabilModel(db.Model):
    __tablename__ = 'sped_contabil'

    id = db.Column(db.Integer, primary_key=True)
    data_emissao = db.Column(db.DateTime)
    periodo_inicial = db.Column(db.DateTime)
    periodo_final = db.Column(db.DateTime)
    forma_escrituracao = db.Column(db.String(1))
    versao_layout = db.Column(db.String(100))


    def mapping(self, data):
        self.id = data.get('id')
        self.data_emissao = data.get('dataEmissao')
        self.periodo_inicial = data.get('periodoInicial')
        self.periodo_final = data.get('periodoFinal')
        self.forma_escrituracao = data.get('formaEscrituracao')
        self.versao_layout = data.get('versaoLayout')

    def serialize(self):
        return {
            'id': self.id,
            'dataEmissao': self.data_emissao.isoformat(),
            'periodoInicial': self.periodo_inicial.isoformat(),
            'periodoFinal': self.periodo_final.isoformat(),
            'formaEscrituracao': self.forma_escrituracao,
            'versaoLayout': self.versao_layout,
        }