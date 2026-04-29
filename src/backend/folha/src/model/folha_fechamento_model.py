from src import db


class FolhaFechamentoModel(db.Model):
    __tablename__ = 'folha_fechamento'

    id = db.Column(db.Integer, primary_key=True)
    fechamento_atual = db.Column(db.String(7))
    proximo_fechamento = db.Column(db.String(7))


    def mapping(self, data):
        self.id = data.get('id')
        self.fechamento_atual = data.get('fechamentoAtual')
        self.proximo_fechamento = data.get('proximoFechamento')

    def serialize(self):
        return {
            'id': self.id,
            'fechamentoAtual': self.fechamento_atual,
            'proximoFechamento': self.proximo_fechamento,
        }