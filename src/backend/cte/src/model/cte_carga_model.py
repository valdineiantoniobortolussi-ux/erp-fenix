from src import db


class CteCargaModel(db.Model):
    __tablename__ = 'cte_carga'

    id = db.Column(db.Integer, primary_key=True)
    codigo_unidade_medida = db.Column(db.String(2))
    tipo_medida = db.Column(db.String(20))
    quantidade = db.Column(db.Float)
    id_cte_cabecalho = db.Column(db.Integer, db.ForeignKey('cte_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_cabecalho = data.get('idCteCabecalho')
        self.codigo_unidade_medida = data.get('codigoUnidadeMedida')
        self.tipo_medida = data.get('tipoMedida')
        self.quantidade = data.get('quantidade')

    def serialize(self):
        return {
            'id': self.id,
            'idCteCabecalho': self.id_cte_cabecalho,
            'codigoUnidadeMedida': self.codigo_unidade_medida,
            'tipoMedida': self.tipo_medida,
            'quantidade': self.quantidade,
        }