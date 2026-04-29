from src import db


class FpasModel(db.Model):
    __tablename__ = 'fpas'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.Integer)
    cnae = db.Column(db.String(14))
    aliquota_sat = db.Column(db.Float)
    descricao = db.Column(db.String(250))
    percentual_inss_patronal = db.Column(db.Float)
    codigo_terceiro = db.Column(db.String(4))
    percentual_terceiros = db.Column(db.Float)


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.cnae = data.get('cnae')
        self.aliquota_sat = data.get('aliquotaSat')
        self.descricao = data.get('descricao')
        self.percentual_inss_patronal = data.get('percentualInssPatronal')
        self.codigo_terceiro = data.get('codigoTerceiro')
        self.percentual_terceiros = data.get('percentualTerceiros')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'cnae': self.cnae,
            'aliquotaSat': self.aliquota_sat,
            'descricao': self.descricao,
            'percentualInssPatronal': self.percentual_inss_patronal,
            'codigoTerceiro': self.codigo_terceiro,
            'percentualTerceiros': self.percentual_terceiros,
        }