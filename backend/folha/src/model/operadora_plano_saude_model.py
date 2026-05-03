from src import db


class OperadoraPlanoSaudeModel(db.Model):
    __tablename__ = 'operadora_plano_saude'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    registro_ans = db.Column(db.String(20))
    classificacao_contabil_conta = db.Column(db.String(30))


    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.registro_ans = data.get('registroAns')
        self.classificacao_contabil_conta = data.get('classificacaoContabilConta')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'registroAns': self.registro_ans,
            'classificacaoContabilConta': self.classificacao_contabil_conta,
        }