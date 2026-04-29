from src import db


class MdfePercursoModel(db.Model):
    __tablename__ = 'mdfe_percurso'

    id = db.Column(db.Integer, primary_key=True)
    uf_percurso = db.Column(db.String(2))
    data_inicio_viagem = db.Column(db.DateTime)
    id_mdfe_cabecalho = db.Column(db.Integer, db.ForeignKey('mdfe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_mdfe_cabecalho = data.get('idMdfeCabecalho')
        self.uf_percurso = data.get('ufPercurso')
        self.data_inicio_viagem = data.get('dataInicioViagem')

    def serialize(self):
        return {
            'id': self.id,
            'idMdfeCabecalho': self.id_mdfe_cabecalho,
            'ufPercurso': self.uf_percurso,
            'dataInicioViagem': self.data_inicio_viagem.isoformat(),
        }