from src import db
from src.model.plano_conta_model import PlanoContaModel
from src.model.plano_conta_ref_sped_model import PlanoContaRefSpedModel


class ContabilContaModel(db.Model):
    __tablename__ = 'contabil_conta'

    id = db.Column(db.Integer, primary_key=True)
    id_contabil_conta = db.Column(db.Integer)
    classificacao = db.Column(db.String(30))
    tipo = db.Column(db.String(1))
    descricao = db.Column(db.String(100))
    data_inclusao = db.Column(db.DateTime)
    situacao = db.Column(db.String(1))
    natureza = db.Column(db.String(1))
    patrimonio_resultado = db.Column(db.String(1))
    livro_caixa = db.Column(db.String(1))
    dfc = db.Column(db.String(1))
    codigo_efd = db.Column(db.String(2))
    ordem = db.Column(db.String(20))
    codigo_reduzido = db.Column(db.String(10))
    id_plano_conta = db.Column(db.Integer, db.ForeignKey('plano_conta.id'))
    id_plano_conta_ref_sped = db.Column(db.Integer, db.ForeignKey('plano_conta_ref_sped.id'))

    plano_conta_model = db.relationship('PlanoContaModel', foreign_keys=[id_plano_conta])
    plano_conta_ref_sped_model = db.relationship('PlanoContaRefSpedModel', foreign_keys=[id_plano_conta_ref_sped])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_plano_conta = data.get('idPlanoConta')
        self.id_plano_conta_ref_sped = data.get('idPlanoContaRefSped')
        self.id_contabil_conta = data.get('idContabilConta')
        self.classificacao = data.get('classificacao')
        self.tipo = data.get('tipo')
        self.descricao = data.get('descricao')
        self.data_inclusao = data.get('dataInclusao')
        self.situacao = data.get('situacao')
        self.natureza = data.get('natureza')
        self.patrimonio_resultado = data.get('patrimonioResultado')
        self.livro_caixa = data.get('livroCaixa')
        self.dfc = data.get('dfc')
        self.codigo_efd = data.get('codigoEfd')
        self.ordem = data.get('ordem')
        self.codigo_reduzido = data.get('codigoReduzido')

    def serialize(self):
        return {
            'id': self.id,
            'idPlanoConta': self.id_plano_conta,
            'idPlanoContaRefSped': self.id_plano_conta_ref_sped,
            'idContabilConta': self.id_contabil_conta,
            'classificacao': self.classificacao,
            'tipo': self.tipo,
            'descricao': self.descricao,
            'dataInclusao': self.data_inclusao.isoformat(),
            'situacao': self.situacao,
            'natureza': self.natureza,
            'patrimonioResultado': self.patrimonio_resultado,
            'livroCaixa': self.livro_caixa,
            'dfc': self.dfc,
            'codigoEfd': self.codigo_efd,
            'ordem': self.ordem,
            'codigoReduzido': self.codigo_reduzido,
            'planoContaModel': self.plano_conta_model.serialize() if self.plano_conta_model else None,
            'planoContaRefSpedModel': self.plano_conta_ref_sped_model.serialize() if self.plano_conta_ref_sped_model else None,
        }