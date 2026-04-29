from src import db


class SpedFiscalModel(db.Model):
    __tablename__ = 'sped_fiscal'

    id = db.Column(db.Integer, primary_key=True)
    data_emissao = db.Column(db.DateTime)
    periodo_inicial = db.Column(db.DateTime)
    periodo_final = db.Column(db.DateTime)
    perfil_apresentacao = db.Column(db.String(1))
    finalidade_arquivo = db.Column(db.String(100))
    versao_layout = db.Column(db.String(100))


    def mapping(self, data):
        self.id = data.get('id')
        self.data_emissao = data.get('dataEmissao')
        self.periodo_inicial = data.get('periodoInicial')
        self.periodo_final = data.get('periodoFinal')
        self.perfil_apresentacao = data.get('perfilApresentacao')
        self.finalidade_arquivo = data.get('finalidadeArquivo')
        self.versao_layout = data.get('versaoLayout')

    def serialize(self):
        return {
            'id': self.id,
            'dataEmissao': self.data_emissao.isoformat(),
            'periodoInicial': self.periodo_inicial.isoformat(),
            'periodoFinal': self.periodo_final.isoformat(),
            'perfilApresentacao': self.perfil_apresentacao,
            'finalidadeArquivo': self.finalidade_arquivo,
            'versaoLayout': self.versao_layout,
        }