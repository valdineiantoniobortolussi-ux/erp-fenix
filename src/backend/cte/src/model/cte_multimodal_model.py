from src import db


class CteMultimodalModel(db.Model):
    __tablename__ = 'cte_multimodal'

    id = db.Column(db.Integer, primary_key=True)
    cotm = db.Column(db.String(20))
    indicador_negociavel = db.Column(db.String(1))
    id_cte_cabecalho = db.Column(db.Integer, db.ForeignKey('cte_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_cabecalho = data.get('idCteCabecalho')
        self.cotm = data.get('cotm')
        self.indicador_negociavel = data.get('indicadorNegociavel')

    def serialize(self):
        return {
            'id': self.id,
            'idCteCabecalho': self.id_cte_cabecalho,
            'cotm': self.cotm,
            'indicadorNegociavel': self.indicador_negociavel,
        }