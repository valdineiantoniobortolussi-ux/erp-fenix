from src import db


class FeriadosModel(db.Model):
    __tablename__ = 'feriados'

    id = db.Column(db.Integer, primary_key=True)
    ano = db.Column(db.String(4))
    nome = db.Column(db.String(50))
    abrangencia = db.Column(db.String(1))
    uf = db.Column(db.String(2))
    municipio_ibge = db.Column(db.Integer)
    tipo = db.Column(db.String(1))
    data_feriado = db.Column(db.DateTime)


    def mapping(self, data):
        self.id = data.get('id')
        self.ano = data.get('ano')
        self.nome = data.get('nome')
        self.abrangencia = data.get('abrangencia')
        self.uf = data.get('uf')
        self.municipio_ibge = data.get('municipioIbge')
        self.tipo = data.get('tipo')
        self.data_feriado = data.get('dataFeriado')

    def serialize(self):
        return {
            'id': self.id,
            'ano': self.ano,
            'nome': self.nome,
            'abrangencia': self.abrangencia,
            'uf': self.uf,
            'municipioIbge': self.municipio_ibge,
            'tipo': self.tipo,
            'dataFeriado': self.data_feriado.isoformat(),
        }