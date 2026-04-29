from src import db


class MdfeMunicipioCarregamentoModel(db.Model):
    __tablename__ = 'mdfe_municipio_carregamento'

    id = db.Column(db.Integer, primary_key=True)
    codigo_municipio = db.Column(db.String(7))
    nome_municipio = db.Column(db.String(60))
    id_mdfe_cabecalho = db.Column(db.Integer, db.ForeignKey('mdfe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_mdfe_cabecalho = data.get('idMdfeCabecalho')
        self.codigo_municipio = data.get('codigoMunicipio')
        self.nome_municipio = data.get('nomeMunicipio')

    def serialize(self):
        return {
            'id': self.id,
            'idMdfeCabecalho': self.id_mdfe_cabecalho,
            'codigoMunicipio': self.codigo_municipio,
            'nomeMunicipio': self.nome_municipio,
        }