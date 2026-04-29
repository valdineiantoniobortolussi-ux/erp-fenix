from src import db


class PontoTurmaModel(db.Model):
    __tablename__ = 'ponto_turma'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(5))
    nome = db.Column(db.String(50))
    id_ponto_escala = db.Column(db.Integer, db.ForeignKey('ponto_escala.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_ponto_escala = data.get('idPontoEscala')
        self.codigo = data.get('codigo')
        self.nome = data.get('nome')

    def serialize(self):
        return {
            'id': self.id,
            'idPontoEscala': self.id_ponto_escala,
            'codigo': self.codigo,
            'nome': self.nome,
        }