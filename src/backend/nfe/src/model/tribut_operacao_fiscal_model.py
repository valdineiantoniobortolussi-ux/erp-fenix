from src import db


class TributOperacaoFiscalModel(db.Model):
    __tablename__ = 'tribut_operacao_fiscal'

    id = db.Column(db.Integer, primary_key=True)
    descricao = db.Column(db.String(100))
    descricao_na_nf = db.Column(db.String(100))
    cfop = db.Column(db.Integer)
    observacao = db.Column(db.Text)


    def mapping(self, data):
        self.id = data.get('id')
        self.descricao = data.get('descricao')
        self.descricao_na_nf = data.get('descricaoNaNf')
        self.cfop = data.get('cfop')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'descricao': self.descricao,
            'descricaoNaNf': self.descricao_na_nf,
            'cfop': self.cfop,
            'observacao': self.observacao,
        }