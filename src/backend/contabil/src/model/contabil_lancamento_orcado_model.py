from src import db
from src.model.contabil_conta_model import ContabilContaModel


class ContabilLancamentoOrcadoModel(db.Model):
    __tablename__ = 'contabil_lancamento_orcado'

    id = db.Column(db.Integer, primary_key=True)
    ano = db.Column(db.String(4))
    janeiro = db.Column(db.Float)
    fevereiro = db.Column(db.Float)
    marco = db.Column(db.Float)
    abril = db.Column(db.Float)
    maio = db.Column(db.Float)
    junho = db.Column(db.Float)
    julho = db.Column(db.Float)
    agosto = db.Column(db.Float)
    setembro = db.Column(db.Float)
    outubro = db.Column(db.Float)
    novembro = db.Column(db.Float)
    dezembro = db.Column(db.Float)
    id_contabil_conta = db.Column(db.Integer, db.ForeignKey('contabil_conta.id'))

    contabil_conta_model = db.relationship('ContabilContaModel', foreign_keys=[id_contabil_conta])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_contabil_conta = data.get('idContabilConta')
        self.ano = data.get('ano')
        self.janeiro = data.get('janeiro')
        self.fevereiro = data.get('fevereiro')
        self.marco = data.get('marco')
        self.abril = data.get('abril')
        self.maio = data.get('maio')
        self.junho = data.get('junho')
        self.julho = data.get('julho')
        self.agosto = data.get('agosto')
        self.setembro = data.get('setembro')
        self.outubro = data.get('outubro')
        self.novembro = data.get('novembro')
        self.dezembro = data.get('dezembro')

    def serialize(self):
        return {
            'id': self.id,
            'idContabilConta': self.id_contabil_conta,
            'ano': self.ano,
            'janeiro': self.janeiro,
            'fevereiro': self.fevereiro,
            'marco': self.marco,
            'abril': self.abril,
            'maio': self.maio,
            'junho': self.junho,
            'julho': self.julho,
            'agosto': self.agosto,
            'setembro': self.setembro,
            'outubro': self.outubro,
            'novembro': self.novembro,
            'dezembro': self.dezembro,
            'contabilContaModel': self.contabil_conta_model.serialize() if self.contabil_conta_model else None,
        }