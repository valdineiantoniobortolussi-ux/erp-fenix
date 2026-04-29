from src import db


class FolhaPppExameMedicoModel(db.Model):
    __tablename__ = 'folha_ppp_exame_medico'

    id = db.Column(db.Integer, primary_key=True)
    data_ultimo = db.Column(db.DateTime)
    tipo = db.Column(db.String(1))
    exame = db.Column(db.String(1))
    natureza = db.Column(db.String(50))
    indicacao_resultados = db.Column(db.String(50))
    id_folha_ppp = db.Column(db.Integer, db.ForeignKey('folha_ppp.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_folha_ppp = data.get('idFolhaPpp')
        self.data_ultimo = data.get('dataUltimo')
        self.tipo = data.get('tipo')
        self.exame = data.get('exame')
        self.natureza = data.get('natureza')
        self.indicacao_resultados = data.get('indicacaoResultados')

    def serialize(self):
        return {
            'id': self.id,
            'idFolhaPpp': self.id_folha_ppp,
            'dataUltimo': self.data_ultimo.isoformat(),
            'tipo': self.tipo,
            'exame': self.exame,
            'natureza': self.natureza,
            'indicacaoResultados': self.indicacao_resultados,
        }