from src import db


class SintegraModel(db.Model):
    __tablename__ = 'sintegra'

    id = db.Column(db.Integer, primary_key=True)
    data_emissao = db.Column(db.DateTime)
    periodo_inicial = db.Column(db.DateTime)
    periodo_final = db.Column(db.DateTime)
    codigo_convenio = db.Column(db.String(1))
    inventario = db.Column(db.String(1))
    finalidade_arquivo = db.Column(db.String(100))


    def mapping(self, data):
        self.id = data.get('id')
        self.data_emissao = data.get('dataEmissao')
        self.periodo_inicial = data.get('periodoInicial')
        self.periodo_final = data.get('periodoFinal')
        self.codigo_convenio = data.get('codigoConvenio')
        self.inventario = data.get('inventario')
        self.finalidade_arquivo = data.get('finalidadeArquivo')

    def serialize(self):
        return {
            'id': self.id,
            'dataEmissao': self.data_emissao.isoformat(),
            'periodoInicial': self.periodo_inicial.isoformat(),
            'periodoFinal': self.periodo_final.isoformat(),
            'codigoConvenio': self.codigo_convenio,
            'inventario': self.inventario,
            'finalidadeArquivo': self.finalidade_arquivo,
        }