from src import db


class NfeDetEspecificoArmamentoModel(db.Model):
    __tablename__ = 'nfe_det_especifico_armamento'

    id = db.Column(db.Integer, primary_key=True)
    tipo_arma = db.Column(db.String(1))
    numero_serie_arma = db.Column(db.String(15))
    numero_serie_cano = db.Column(db.String(15))
    descricao = db.Column(db.String(250))
    id_nfe_detalhe = db.Column(db.Integer, db.ForeignKey('nfe_detalhe.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_detalhe = data.get('idNfeDetalhe')
        self.tipo_arma = data.get('tipoArma')
        self.numero_serie_arma = data.get('numeroSerieArma')
        self.numero_serie_cano = data.get('numeroSerieCano')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeDetalhe': self.id_nfe_detalhe,
            'tipoArma': self.tipo_arma,
            'numeroSerieArma': self.numero_serie_arma,
            'numeroSerieCano': self.numero_serie_cano,
            'descricao': self.descricao,
        }