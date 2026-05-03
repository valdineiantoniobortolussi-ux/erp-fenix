from src import db


class PatrimGrupoBemModel(db.Model):
    __tablename__ = 'patrim_grupo_bem'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(3))
    nome = db.Column(db.String(50))
    descricao = db.Column(db.Text)
    conta_ativo_imobilizado = db.Column(db.String(30))
    conta_depreciacao_acumulada = db.Column(db.String(30))
    conta_despesa_depreciacao = db.Column(db.String(30))
    codigo_historico = db.Column(db.Integer)


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')
        self.conta_ativo_imobilizado = data.get('contaAtivoImobilizado')
        self.conta_depreciacao_acumulada = data.get('contaDepreciacaoAcumulada')
        self.conta_despesa_depreciacao = data.get('contaDespesaDepreciacao')
        self.codigo_historico = data.get('codigoHistorico')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'nome': self.nome,
            'descricao': self.descricao,
            'contaAtivoImobilizado': self.conta_ativo_imobilizado,
            'contaDepreciacaoAcumulada': self.conta_depreciacao_acumulada,
            'contaDespesaDepreciacao': self.conta_despesa_depreciacao,
            'codigoHistorico': self.codigo_historico,
        }