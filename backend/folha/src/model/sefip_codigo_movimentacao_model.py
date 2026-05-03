from src import db


class SefipCodigoMovimentacaoModel(db.Model):
    __tablename__ = 'sefip_codigo_movimentacao'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(2))
    descricao = db.Column(db.Text)
    aplicacao = db.Column(db.Text)


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.descricao = data.get('descricao')
        self.aplicacao = data.get('aplicacao')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'descricao': self.descricao,
            'aplicacao': self.aplicacao,
        }