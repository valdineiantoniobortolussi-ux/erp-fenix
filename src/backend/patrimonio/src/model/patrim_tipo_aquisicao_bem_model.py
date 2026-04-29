from src import db


class PatrimTipoAquisicaoBemModel(db.Model):
    __tablename__ = 'patrim_tipo_aquisicao_bem'

    id = db.Column(db.Integer, primary_key=True)
    tipo = db.Column(db.String(1))
    nome = db.Column(db.String(50))
    descricao = db.Column(db.Text)


    def mapping(self, data):
        self.id = data.get('id')
        self.tipo = data.get('tipo')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'tipo': self.tipo,
            'nome': self.nome,
            'descricao': self.descricao,
        }