from src import db


class NfeDetEspecificoMedicamentoModel(db.Model):
    __tablename__ = 'nfe_det_especifico_medicamento'

    id = db.Column(db.Integer, primary_key=True)
    codigo_anvisa = db.Column(db.String(13))
    motivo_isencao = db.Column(db.String(250))
    preco_maximo_consumidor = db.Column(db.Float)
    id_nfe_detalhe = db.Column(db.Integer, db.ForeignKey('nfe_detalhe.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_detalhe = data.get('idNfeDetalhe')
        self.codigo_anvisa = data.get('codigoAnvisa')
        self.motivo_isencao = data.get('motivoIsencao')
        self.preco_maximo_consumidor = data.get('precoMaximoConsumidor')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeDetalhe': self.id_nfe_detalhe,
            'codigoAnvisa': self.codigo_anvisa,
            'motivoIsencao': self.motivo_isencao,
            'precoMaximoConsumidor': self.preco_maximo_consumidor,
        }