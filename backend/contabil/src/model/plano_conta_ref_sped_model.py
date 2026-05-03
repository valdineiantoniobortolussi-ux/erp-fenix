from src import db


class PlanoContaRefSpedModel(db.Model):
    __tablename__ = 'plano_conta_ref_sped'

    id = db.Column(db.Integer, primary_key=True)
    cod_cta_ref = db.Column(db.String(30))
    inicio_validade = db.Column(db.DateTime)
    fim_validade = db.Column(db.DateTime)
    tipo = db.Column(db.String(1))
    descricao = db.Column(db.Text)
    orientacoes = db.Column(db.Text)


    def mapping(self, data):
        self.id = data.get('id')
        self.cod_cta_ref = data.get('codCtaRef')
        self.inicio_validade = data.get('inicioValidade')
        self.fim_validade = data.get('fimValidade')
        self.tipo = data.get('tipo')
        self.descricao = data.get('descricao')
        self.orientacoes = data.get('orientacoes')

    def serialize(self):
        return {
            'id': self.id,
            'codCtaRef': self.cod_cta_ref,
            'inicioValidade': self.inicio_validade.isoformat(),
            'fimValidade': self.fim_validade.isoformat(),
            'tipo': self.tipo,
            'descricao': self.descricao,
            'orientacoes': self.orientacoes,
        }