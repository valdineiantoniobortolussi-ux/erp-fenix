from src import db
from src.model.tribut_operacao_fiscal_model import TributOperacaoFiscalModel


class TributIssModel(db.Model):
    __tablename__ = 'tribut_iss'

    id = db.Column(db.Integer, primary_key=True)
    modalidade_base_calculo = db.Column(db.String(1))
    codigo_tributacao = db.Column(db.String(1))
    item_lista_servico = db.Column(db.Integer)
    porcento_base_calculo = db.Column(db.Float)
    aliquota_porcento = db.Column(db.Float)
    aliquota_unidade = db.Column(db.Float)
    valor_preco_maximo = db.Column(db.Float)
    valor_pauta_fiscal = db.Column(db.Float)
    id_tribut_operacao_fiscal = db.Column(db.Integer, db.ForeignKey('tribut_operacao_fiscal.id'))

    tribut_operacao_fiscal_model = db.relationship('TributOperacaoFiscalModel', foreign_keys=[id_tribut_operacao_fiscal])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_tribut_operacao_fiscal = data.get('idTributOperacaoFiscal')
        self.modalidade_base_calculo = data.get('modalidadeBaseCalculo')
        self.codigo_tributacao = data.get('codigoTributacao')
        self.item_lista_servico = data.get('itemListaServico')
        self.porcento_base_calculo = data.get('porcentoBaseCalculo')
        self.aliquota_porcento = data.get('aliquotaPorcento')
        self.aliquota_unidade = data.get('aliquotaUnidade')
        self.valor_preco_maximo = data.get('valorPrecoMaximo')
        self.valor_pauta_fiscal = data.get('valorPautaFiscal')

    def serialize(self):
        return {
            'id': self.id,
            'idTributOperacaoFiscal': self.id_tribut_operacao_fiscal,
            'modalidadeBaseCalculo': self.modalidade_base_calculo,
            'codigoTributacao': self.codigo_tributacao,
            'itemListaServico': self.item_lista_servico,
            'porcentoBaseCalculo': self.porcento_base_calculo,
            'aliquotaPorcento': self.aliquota_porcento,
            'aliquotaUnidade': self.aliquota_unidade,
            'valorPrecoMaximo': self.valor_preco_maximo,
            'valorPautaFiscal': self.valor_pauta_fiscal,
            'tributOperacaoFiscalModel': self.tribut_operacao_fiscal_model.serialize() if self.tribut_operacao_fiscal_model else None,
        }