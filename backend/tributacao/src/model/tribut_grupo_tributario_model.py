from src import db


class TributGrupoTributarioModel(db.Model):
    __tablename__ = 'tribut_grupo_tributario'

    id = db.Column(db.Integer, primary_key=True)
    descricao = db.Column(db.String(100))
    origem_mercadoria = db.Column(db.String(1))
    observacao = db.Column(db.Text)


    def mapping(self, data):
        self.id = data.get('id')
        self.descricao = data.get('descricao')
        self.origem_mercadoria = data.get('origemMercadoria')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'descricao': self.descricao,
            'origemMercadoria': self.origem_mercadoria,
            'observacao': self.observacao,
        }