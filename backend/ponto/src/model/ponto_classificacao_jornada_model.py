from src import db


class PontoClassificacaoJornadaModel(db.Model):
    __tablename__ = 'ponto_classificacao_jornada'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(3))
    nome = db.Column(db.String(50))
    descricao = db.Column(db.Text)
    padrao = db.Column(db.String(1))
    descontar_horas = db.Column(db.String(1))


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')
        self.padrao = data.get('padrao')
        self.descontar_horas = data.get('descontarHoras')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'nome': self.nome,
            'descricao': self.descricao,
            'padrao': self.padrao,
            'descontarHoras': self.descontar_horas,
        }