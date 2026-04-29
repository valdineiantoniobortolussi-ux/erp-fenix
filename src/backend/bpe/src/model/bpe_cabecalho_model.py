from src import db
from src.model.bpe_emitente_model import BpeEmitenteModel
from src.model.bpe_passageiro_model import BpePassageiroModel
from src.model.bpe_comprador_model import BpeCompradorModel
from src.model.bpe_viagem_model import BpeViagemModel
from src.model.bpe_agencia_model import BpeAgenciaModel
from src.model.bpe_passagem_model import BpePassagemModel


class BpeCabecalhoModel(db.Model):
    __tablename__ = 'bpe_cabecalho'

    id = db.Column(db.Integer, primary_key=True)
    uf_emitente = db.Column(db.String(2))
    ambiente = db.Column(db.String(1))
    modelo = db.Column(db.String(2))
    serie = db.Column(db.String(3))
    numero = db.Column(db.String(9))
    codigo_numerico = db.Column(db.String(8))
    chave_acesso = db.Column(db.String(44))
    digito_chave_acesso = db.Column(db.String(1))
    modal = db.Column(db.String(2))
    data_hora_emissao = db.Column(db.DateTime)
    tipo_emissao = db.Column(db.String(1))
    versao_processo_emissao = db.Column(db.String(20))
    tipo_bpe = db.Column(db.String(1))
    consumidor_presenca = db.Column(db.String(1))
    uf_inicio_viagem = db.Column(db.String(2))
    codigo_municipio_inicio_viagem = db.Column(db.Integer)
    uf_fim_viagem = db.Column(db.String(2))
    codigo_municipio_fim_viagem = db.Column(db.Integer)
    valor_bilhete = db.Column(db.Float)
    valor_desconto = db.Column(db.Float)
    valor_pago = db.Column(db.Float)
    valor_troco = db.Column(db.Float)
    tipo_desconto = db.Column(db.String(1))
    desconto_descricao = db.Column(db.String(100))
    desconto_concedido_outros = db.Column(db.String(20))
    forma_pagamento = db.Column(db.String(1))
    forma_pagamento_outros = db.Column(db.String(100))
    forma_pagamento_documento = db.Column(db.String(20))
    cst = db.Column(db.String(2))
    base_calculo_icms = db.Column(db.Float)
    aliquota_icms = db.Column(db.Float)
    valor_icms = db.Column(db.Float)
    percentual_reducao_bc_icms = db.Column(db.Float)
    informacoes_add_fisco = db.Column(db.Text)

    bpe_emitente_model_list = db.relationship('BpeEmitenteModel', lazy='dynamic')
    bpe_passageiro_model_list = db.relationship('BpePassageiroModel', lazy='dynamic')
    bpe_comprador_model_list = db.relationship('BpeCompradorModel', lazy='dynamic')
    bpe_viagem_model_list = db.relationship('BpeViagemModel', lazy='dynamic')
    bpe_agencia_model_list = db.relationship('BpeAgenciaModel', lazy='dynamic')
    bpe_passagem_model_list = db.relationship('BpePassagemModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.uf_emitente = data.get('ufEmitente')
        self.ambiente = data.get('ambiente')
        self.modelo = data.get('modelo')
        self.serie = data.get('serie')
        self.numero = data.get('numero')
        self.codigo_numerico = data.get('codigoNumerico')
        self.chave_acesso = data.get('chaveAcesso')
        self.digito_chave_acesso = data.get('digitoChaveAcesso')
        self.modal = data.get('modal')
        self.data_hora_emissao = data.get('dataHoraEmissao')
        self.tipo_emissao = data.get('tipoEmissao')
        self.versao_processo_emissao = data.get('versaoProcessoEmissao')
        self.tipo_bpe = data.get('tipoBpe')
        self.consumidor_presenca = data.get('consumidorPresenca')
        self.uf_inicio_viagem = data.get('ufInicioViagem')
        self.codigo_municipio_inicio_viagem = data.get('codigoMunicipioInicioViagem')
        self.uf_fim_viagem = data.get('ufFimViagem')
        self.codigo_municipio_fim_viagem = data.get('codigoMunicipioFimViagem')
        self.valor_bilhete = data.get('valorBilhete')
        self.valor_desconto = data.get('valorDesconto')
        self.valor_pago = data.get('valorPago')
        self.valor_troco = data.get('valorTroco')
        self.tipo_desconto = data.get('tipoDesconto')
        self.desconto_descricao = data.get('descontoDescricao')
        self.desconto_concedido_outros = data.get('descontoConcedidoOutros')
        self.forma_pagamento = data.get('formaPagamento')
        self.forma_pagamento_outros = data.get('formaPagamentoOutros')
        self.forma_pagamento_documento = data.get('formaPagamentoDocumento')
        self.cst = data.get('cst')
        self.base_calculo_icms = data.get('baseCalculoIcms')
        self.aliquota_icms = data.get('aliquotaIcms')
        self.valor_icms = data.get('valorIcms')
        self.percentual_reducao_bc_icms = data.get('percentualReducaoBcIcms')
        self.informacoes_add_fisco = data.get('informacoesAddFisco')

    def serialize(self):
        return {
            'id': self.id,
            'ufEmitente': self.uf_emitente,
            'ambiente': self.ambiente,
            'modelo': self.modelo,
            'serie': self.serie,
            'numero': self.numero,
            'codigoNumerico': self.codigo_numerico,
            'chaveAcesso': self.chave_acesso,
            'digitoChaveAcesso': self.digito_chave_acesso,
            'modal': self.modal,
            'dataHoraEmissao': self.data_hora_emissao.isoformat(),
            'tipoEmissao': self.tipo_emissao,
            'versaoProcessoEmissao': self.versao_processo_emissao,
            'tipoBpe': self.tipo_bpe,
            'consumidorPresenca': self.consumidor_presenca,
            'ufInicioViagem': self.uf_inicio_viagem,
            'codigoMunicipioInicioViagem': self.codigo_municipio_inicio_viagem,
            'ufFimViagem': self.uf_fim_viagem,
            'codigoMunicipioFimViagem': self.codigo_municipio_fim_viagem,
            'valorBilhete': self.valor_bilhete,
            'valorDesconto': self.valor_desconto,
            'valorPago': self.valor_pago,
            'valorTroco': self.valor_troco,
            'tipoDesconto': self.tipo_desconto,
            'descontoDescricao': self.desconto_descricao,
            'descontoConcedidoOutros': self.desconto_concedido_outros,
            'formaPagamento': self.forma_pagamento,
            'formaPagamentoOutros': self.forma_pagamento_outros,
            'formaPagamentoDocumento': self.forma_pagamento_documento,
            'cst': self.cst,
            'baseCalculoIcms': self.base_calculo_icms,
            'aliquotaIcms': self.aliquota_icms,
            'valorIcms': self.valor_icms,
            'percentualReducaoBcIcms': self.percentual_reducao_bc_icms,
            'informacoesAddFisco': self.informacoes_add_fisco,
            'bpeEmitenteModelList': [bpe_emitente_model.serialize() for bpe_emitente_model in self.bpe_emitente_model_list],
            'bpePassageiroModelList': [bpe_passageiro_model.serialize() for bpe_passageiro_model in self.bpe_passageiro_model_list],
            'bpeCompradorModelList': [bpe_comprador_model.serialize() for bpe_comprador_model in self.bpe_comprador_model_list],
            'bpeViagemModelList': [bpe_viagem_model.serialize() for bpe_viagem_model in self.bpe_viagem_model_list],
            'bpeAgenciaModelList': [bpe_agencia_model.serialize() for bpe_agencia_model in self.bpe_agencia_model_list],
            'bpePassagemModelList': [bpe_passagem_model.serialize() for bpe_passagem_model in self.bpe_passagem_model_list],
        }