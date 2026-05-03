from src import db


class EfdReinfModel(db.Model):
    __tablename__ = 'efd_reinf'

    id = db.Column(db.Integer, primary_key=True)
    data_emissao = db.Column(db.DateTime)
    periodo_inicial = db.Column(db.DateTime)
    periodo_final = db.Column(db.DateTime)
    finalidade_arquivo = db.Column(db.String(100))


    def mapping(self, data):
        self.id = data.get('id')
        self.data_emissao = data.get('dataEmissao')
        self.periodo_inicial = data.get('periodoInicial')
        self.periodo_final = data.get('periodoFinal')
        self.finalidade_arquivo = data.get('finalidadeArquivo')

    def serialize(self):
        return {
            'id': self.id,
            'dataEmissao': self.data_emissao.isoformat(),
            'periodoInicial': self.periodo_inicial.isoformat(),
            'periodoFinal': self.periodo_final.isoformat(),
            'finalidadeArquivo': self.finalidade_arquivo,
        }