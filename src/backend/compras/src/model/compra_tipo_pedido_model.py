from src import db


class CompraTipoPedidoModel(db.Model):
    __tablename__ = 'compra_tipo_pedido'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(2))
    nome = db.Column(db.String(30))
    descricao = db.Column(db.Text)


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'nome': self.nome,
            'descricao': self.descricao,
        }