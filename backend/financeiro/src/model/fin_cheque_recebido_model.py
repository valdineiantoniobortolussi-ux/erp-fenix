from src import db
from src.model.view_pessoa_cliente_model import ViewPessoaClienteModel


class FinChequeRecebidoModel(db.Model):
    __tablename__ = 'fin_cheque_recebido'

    id = db.Column(db.Integer, primary_key=True)
    cpf = db.Column(db.String(11))
    cnpj = db.Column(db.String(14))
    nome = db.Column(db.String(100))
    codigo_banco = db.Column(db.String(10))
    codigo_agencia = db.Column(db.String(10))
    conta = db.Column(db.String(20))
    numero = db.Column(db.Integer)
    data_emissao = db.Column(db.DateTime)
    bom_para = db.Column(db.DateTime)
    data_compensacao = db.Column(db.DateTime)
    valor = db.Column(db.Float)
    custodia_data = db.Column(db.DateTime)
    custodia_tarifa = db.Column(db.Float)
    custodia_comissao = db.Column(db.Float)
    desconto_data = db.Column(db.DateTime)
    desconto_tarifa = db.Column(db.Float)
    desconto_comissao = db.Column(db.Float)
    valor_recebido = db.Column(db.Float)
    id_cliente = db.Column(db.Integer, db.ForeignKey('view_pessoa_cliente.id'))

    view_pessoa_cliente_model = db.relationship('ViewPessoaClienteModel', foreign_keys=[id_cliente])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_cliente = data.get('idCliente')
        self.cpf = data.get('cpf')
        self.cnpj = data.get('cnpj')
        self.nome = data.get('nome')
        self.codigo_banco = data.get('codigoBanco')
        self.codigo_agencia = data.get('codigoAgencia')
        self.conta = data.get('conta')
        self.numero = data.get('numero')
        self.data_emissao = data.get('dataEmissao')
        self.bom_para = data.get('bomPara')
        self.data_compensacao = data.get('dataCompensacao')
        self.valor = data.get('valor')
        self.custodia_data = data.get('custodiaData')
        self.custodia_tarifa = data.get('custodiaTarifa')
        self.custodia_comissao = data.get('custodiaComissao')
        self.desconto_data = data.get('descontoData')
        self.desconto_tarifa = data.get('descontoTarifa')
        self.desconto_comissao = data.get('descontoComissao')
        self.valor_recebido = data.get('valorRecebido')

    def serialize(self):
        return {
            'id': self.id,
            'idCliente': self.id_cliente,
            'cpf': self.cpf,
            'cnpj': self.cnpj,
            'nome': self.nome,
            'codigoBanco': self.codigo_banco,
            'codigoAgencia': self.codigo_agencia,
            'conta': self.conta,
            'numero': self.numero,
            'dataEmissao': self.data_emissao.isoformat(),
            'bomPara': self.bom_para.isoformat(),
            'dataCompensacao': self.data_compensacao.isoformat(),
            'valor': self.valor,
            'custodiaData': self.custodia_data.isoformat(),
            'custodiaTarifa': self.custodia_tarifa,
            'custodiaComissao': self.custodia_comissao,
            'descontoData': self.desconto_data.isoformat(),
            'descontoTarifa': self.desconto_tarifa,
            'descontoComissao': self.desconto_comissao,
            'valorRecebido': self.valor_recebido,
            'viewPessoaClienteModel': self.view_pessoa_cliente_model.serialize() if self.view_pessoa_cliente_model else None,
        }