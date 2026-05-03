from src import db


class CteDocumentoAnteriorIdModel(db.Model):
    __tablename__ = 'cte_documento_anterior_id'

    id = db.Column(db.Integer, primary_key=True)
    tipo = db.Column(db.String(2))
    serie = db.Column(db.String(3))
    subserie = db.Column(db.String(2))
    numero = db.Column(db.String(20))
    data_emissao = db.Column(db.DateTime)
    chave_cte = db.Column(db.String(44))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_documento_anterior = data.get('idCteDocumentoAnterior')
        self.tipo = data.get('tipo')
        self.serie = data.get('serie')
        self.subserie = data.get('subserie')
        self.numero = data.get('numero')
        self.data_emissao = data.get('dataEmissao')
        self.chave_cte = data.get('chaveCte')

    def serialize(self):
        return {
            'id': self.id,
            'idCteDocumentoAnterior': self.id_cte_documento_anterior,
            'tipo': self.tipo,
            'serie': self.serie,
            'subserie': self.subserie,
            'numero': self.numero,
            'dataEmissao': self.data_emissao.isoformat(),
            'chaveCte': self.chave_cte,
        }