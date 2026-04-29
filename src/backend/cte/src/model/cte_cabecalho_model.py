from src import db
from src.model.cte_emitente_model import CteEmitenteModel
from src.model.cte_local_coleta_model import CteLocalColetaModel
from src.model.cte_tomador_model import CteTomadorModel
from src.model.cte_passagem_model import CtePassagemModel
from src.model.cte_remetente_model import CteRemetenteModel
from src.model.cte_expedidor_model import CteExpedidorModel
from src.model.cte_recebedor_model import CteRecebedorModel
from src.model.cte_destinatario_model import CteDestinatarioModel
from src.model.cte_local_entrega_model import CteLocalEntregaModel
from src.model.cte_componente_model import CteComponenteModel
from src.model.cte_carga_model import CteCargaModel
from src.model.cte_informacao_nf_outros_model import CteInformacaoNfOutrosModel
from src.model.cte_seguro_model import CteSeguroModel
from src.model.cte_perigoso_model import CtePerigosoModel
from src.model.cte_veiculo_novo_model import CteVeiculoNovoModel
from src.model.cte_fatura_model import CteFaturaModel
from src.model.cte_duplicata_model import CteDuplicataModel
from src.model.cte_rodoviario_model import CteRodoviarioModel
from src.model.cte_aereo_model import CteAereoModel
from src.model.cte_aquaviario_model import CteAquaviarioModel
from src.model.cte_ferroviario_model import CteFerroviarioModel
from src.model.cte_dutoviario_model import CteDutoviarioModel
from src.model.cte_multimodal_model import CteMultimodalModel


class CteCabecalhoModel(db.Model):
    __tablename__ = 'cte_cabecalho'

    id = db.Column(db.Integer, primary_key=True)
    natureza_operacao = db.Column(db.String(60))
    chave_acesso = db.Column(db.String(44))
    digito_chave_acesso = db.Column(db.String(1))
    codigo_numerico = db.Column(db.String(8))
    serie = db.Column(db.String(3))
    numero = db.Column(db.String(9))
    data_hora_emissao = db.Column(db.DateTime)
    uf_emitente = db.Column(db.String(2))
    cfop = db.Column(db.Integer)
    forma_pagamento = db.Column(db.String(1))
    modelo = db.Column(db.String(2))
    formato_impressao_dacte = db.Column(db.String(1))
    tipo_emissao = db.Column(db.String(1))
    ambiente = db.Column(db.String(1))
    tipo_cte = db.Column(db.String(1))
    processo_emissao = db.Column(db.String(1))
    versao_processo_emissao = db.Column(db.String(20))
    chave_referenciado = db.Column(db.String(44))
    codigo_municipio_envio = db.Column(db.Integer)
    nome_municipio_envio = db.Column(db.String(60))
    uf_envio = db.Column(db.String(2))
    modal = db.Column(db.String(1))
    tipo_servico = db.Column(db.String(1))
    codigo_municipio_ini_prestacao = db.Column(db.Integer)
    nome_municipio_ini_prestacao = db.Column(db.String(60))
    uf_ini_prestacao = db.Column(db.String(2))
    codigo_municipio_fim_prestacao = db.Column(db.Integer)
    nome_municipio_fim_prestacao = db.Column(db.String(60))
    uf_fim_prestacao = db.Column(db.String(2))
    retira = db.Column(db.String(1))
    retira_detalhe = db.Column(db.String(160))
    tomador = db.Column(db.String(1))
    data_entrada_contingencia = db.Column(db.DateTime)
    justificativa_contingencia = db.Column(db.String(255))
    carac_adicional_transporte = db.Column(db.String(15))
    carac_adicional_servico = db.Column(db.String(30))
    funcionario_emissor = db.Column(db.String(20))
    fluxo_origem = db.Column(db.String(15))
    entrega_tipo_periodo = db.Column(db.String(1))
    entrega_data_programada = db.Column(db.DateTime)
    entrega_data_inicial = db.Column(db.DateTime)
    entrega_data_final = db.Column(db.DateTime)
    entrega_tipo_hora = db.Column(db.String(1))
    entrega_hora_programada = db.Column(db.String(8))
    entrega_hora_inicial = db.Column(db.String(8))
    entrega_hora_final = db.Column(db.String(8))
    municipio_origem_calculo = db.Column(db.String(40))
    municipio_destino_calculo = db.Column(db.String(40))
    observacoes_gerais = db.Column(db.Text)
    valor_total_servico = db.Column(db.Float)
    valor_receber = db.Column(db.Float)
    cst = db.Column(db.String(2))
    base_calculo_icms = db.Column(db.Float)
    aliquota_icms = db.Column(db.Float)
    valor_icms = db.Column(db.Float)
    percentual_reducao_bc_icms = db.Column(db.Float)
    valor_bc_icms_st_retido = db.Column(db.Float)
    valor_icms_st_retido = db.Column(db.Float)
    aliquota_icms_st_retido = db.Column(db.Float)
    valor_credito_presumido_icms = db.Column(db.Float)
    percentual_bc_icms_outra_uf = db.Column(db.Float)
    valor_bc_icms_outra_uf = db.Column(db.Float)
    aliquota_icms_outra_uf = db.Column(db.Float)
    valor_icms_outra_uf = db.Column(db.Float)
    simples_nacional_indicador = db.Column(db.String(1))
    simples_nacional_total = db.Column(db.Float)
    informacoes_add_fisco = db.Column(db.Text)
    valor_total_carga = db.Column(db.Float)
    produto_predominante = db.Column(db.String(60))
    carga_outras_caracteristicas = db.Column(db.String(30))
    modal_versao_layout = db.Column(db.Integer)
    chave_cte_substituido = db.Column(db.String(44))

    cte_emitente_model_list = db.relationship('CteEmitenteModel', lazy='dynamic')
    cte_local_coleta_model_list = db.relationship('CteLocalColetaModel', lazy='dynamic')
    cte_tomador_model_list = db.relationship('CteTomadorModel', lazy='dynamic')
    cte_passagem_model_list = db.relationship('CtePassagemModel', lazy='dynamic')
    cte_remetente_model_list = db.relationship('CteRemetenteModel', lazy='dynamic')
    cte_expedidor_model_list = db.relationship('CteExpedidorModel', lazy='dynamic')
    cte_recebedor_model_list = db.relationship('CteRecebedorModel', lazy='dynamic')
    cte_destinatario_model_list = db.relationship('CteDestinatarioModel', lazy='dynamic')
    cte_local_entrega_model_list = db.relationship('CteLocalEntregaModel', lazy='dynamic')
    cte_componente_model_list = db.relationship('CteComponenteModel', lazy='dynamic')
    cte_carga_model_list = db.relationship('CteCargaModel', lazy='dynamic')
    cte_informacao_nf_outros_model_list = db.relationship('CteInformacaoNfOutrosModel', lazy='dynamic')
    cte_seguro_model_list = db.relationship('CteSeguroModel', lazy='dynamic')
    cte_perigoso_model_list = db.relationship('CtePerigosoModel', lazy='dynamic')
    cte_veiculo_novo_model_list = db.relationship('CteVeiculoNovoModel', lazy='dynamic')
    cte_fatura_model_list = db.relationship('CteFaturaModel', lazy='dynamic')
    cte_duplicata_model_list = db.relationship('CteDuplicataModel', lazy='dynamic')
    cte_rodoviario_model_list = db.relationship('CteRodoviarioModel', lazy='dynamic')
    cte_aereo_model_list = db.relationship('CteAereoModel', lazy='dynamic')
    cte_aquaviario_model_list = db.relationship('CteAquaviarioModel', lazy='dynamic')
    cte_ferroviario_model_list = db.relationship('CteFerroviarioModel', lazy='dynamic')
    cte_dutoviario_model_list = db.relationship('CteDutoviarioModel', lazy='dynamic')
    cte_multimodal_model_list = db.relationship('CteMultimodalModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.natureza_operacao = data.get('naturezaOperacao')
        self.chave_acesso = data.get('chaveAcesso')
        self.digito_chave_acesso = data.get('digitoChaveAcesso')
        self.codigo_numerico = data.get('codigoNumerico')
        self.serie = data.get('serie')
        self.numero = data.get('numero')
        self.data_hora_emissao = data.get('dataHoraEmissao')
        self.uf_emitente = data.get('ufEmitente')
        self.cfop = data.get('cfop')
        self.forma_pagamento = data.get('formaPagamento')
        self.modelo = data.get('modelo')
        self.formato_impressao_dacte = data.get('formatoImpressaoDacte')
        self.tipo_emissao = data.get('tipoEmissao')
        self.ambiente = data.get('ambiente')
        self.tipo_cte = data.get('tipoCte')
        self.processo_emissao = data.get('processoEmissao')
        self.versao_processo_emissao = data.get('versaoProcessoEmissao')
        self.chave_referenciado = data.get('chaveReferenciado')
        self.codigo_municipio_envio = data.get('codigoMunicipioEnvio')
        self.nome_municipio_envio = data.get('nomeMunicipioEnvio')
        self.uf_envio = data.get('ufEnvio')
        self.modal = data.get('modal')
        self.tipo_servico = data.get('tipoServico')
        self.codigo_municipio_ini_prestacao = data.get('codigoMunicipioIniPrestacao')
        self.nome_municipio_ini_prestacao = data.get('nomeMunicipioIniPrestacao')
        self.uf_ini_prestacao = data.get('ufIniPrestacao')
        self.codigo_municipio_fim_prestacao = data.get('codigoMunicipioFimPrestacao')
        self.nome_municipio_fim_prestacao = data.get('nomeMunicipioFimPrestacao')
        self.uf_fim_prestacao = data.get('ufFimPrestacao')
        self.retira = data.get('retira')
        self.retira_detalhe = data.get('retiraDetalhe')
        self.tomador = data.get('tomador')
        self.data_entrada_contingencia = data.get('dataEntradaContingencia')
        self.justificativa_contingencia = data.get('justificativaContingencia')
        self.carac_adicional_transporte = data.get('caracAdicionalTransporte')
        self.carac_adicional_servico = data.get('caracAdicionalServico')
        self.funcionario_emissor = data.get('funcionarioEmissor')
        self.fluxo_origem = data.get('fluxoOrigem')
        self.entrega_tipo_periodo = data.get('entregaTipoPeriodo')
        self.entrega_data_programada = data.get('entregaDataProgramada')
        self.entrega_data_inicial = data.get('entregaDataInicial')
        self.entrega_data_final = data.get('entregaDataFinal')
        self.entrega_tipo_hora = data.get('entregaTipoHora')
        self.entrega_hora_programada = data.get('entregaHoraProgramada')
        self.entrega_hora_inicial = data.get('entregaHoraInicial')
        self.entrega_hora_final = data.get('entregaHoraFinal')
        self.municipio_origem_calculo = data.get('municipioOrigemCalculo')
        self.municipio_destino_calculo = data.get('municipioDestinoCalculo')
        self.observacoes_gerais = data.get('observacoesGerais')
        self.valor_total_servico = data.get('valorTotalServico')
        self.valor_receber = data.get('valorReceber')
        self.cst = data.get('cst')
        self.base_calculo_icms = data.get('baseCalculoIcms')
        self.aliquota_icms = data.get('aliquotaIcms')
        self.valor_icms = data.get('valorIcms')
        self.percentual_reducao_bc_icms = data.get('percentualReducaoBcIcms')
        self.valor_bc_icms_st_retido = data.get('valorBcIcmsStRetido')
        self.valor_icms_st_retido = data.get('valorIcmsStRetido')
        self.aliquota_icms_st_retido = data.get('aliquotaIcmsStRetido')
        self.valor_credito_presumido_icms = data.get('valorCreditoPresumidoIcms')
        self.percentual_bc_icms_outra_uf = data.get('percentualBcIcmsOutraUf')
        self.valor_bc_icms_outra_uf = data.get('valorBcIcmsOutraUf')
        self.aliquota_icms_outra_uf = data.get('aliquotaIcmsOutraUf')
        self.valor_icms_outra_uf = data.get('valorIcmsOutraUf')
        self.simples_nacional_indicador = data.get('simplesNacionalIndicador')
        self.simples_nacional_total = data.get('simplesNacionalTotal')
        self.informacoes_add_fisco = data.get('informacoesAddFisco')
        self.valor_total_carga = data.get('valorTotalCarga')
        self.produto_predominante = data.get('produtoPredominante')
        self.carga_outras_caracteristicas = data.get('cargaOutrasCaracteristicas')
        self.modal_versao_layout = data.get('modalVersaoLayout')
        self.chave_cte_substituido = data.get('chaveCteSubstituido')

    def serialize(self):
        return {
            'id': self.id,
            'naturezaOperacao': self.natureza_operacao,
            'chaveAcesso': self.chave_acesso,
            'digitoChaveAcesso': self.digito_chave_acesso,
            'codigoNumerico': self.codigo_numerico,
            'serie': self.serie,
            'numero': self.numero,
            'dataHoraEmissao': self.data_hora_emissao.isoformat(),
            'ufEmitente': self.uf_emitente,
            'cfop': self.cfop,
            'formaPagamento': self.forma_pagamento,
            'modelo': self.modelo,
            'formatoImpressaoDacte': self.formato_impressao_dacte,
            'tipoEmissao': self.tipo_emissao,
            'ambiente': self.ambiente,
            'tipoCte': self.tipo_cte,
            'processoEmissao': self.processo_emissao,
            'versaoProcessoEmissao': self.versao_processo_emissao,
            'chaveReferenciado': self.chave_referenciado,
            'codigoMunicipioEnvio': self.codigo_municipio_envio,
            'nomeMunicipioEnvio': self.nome_municipio_envio,
            'ufEnvio': self.uf_envio,
            'modal': self.modal,
            'tipoServico': self.tipo_servico,
            'codigoMunicipioIniPrestacao': self.codigo_municipio_ini_prestacao,
            'nomeMunicipioIniPrestacao': self.nome_municipio_ini_prestacao,
            'ufIniPrestacao': self.uf_ini_prestacao,
            'codigoMunicipioFimPrestacao': self.codigo_municipio_fim_prestacao,
            'nomeMunicipioFimPrestacao': self.nome_municipio_fim_prestacao,
            'ufFimPrestacao': self.uf_fim_prestacao,
            'retira': self.retira,
            'retiraDetalhe': self.retira_detalhe,
            'tomador': self.tomador,
            'dataEntradaContingencia': self.data_entrada_contingencia.isoformat(),
            'justificativaContingencia': self.justificativa_contingencia,
            'caracAdicionalTransporte': self.carac_adicional_transporte,
            'caracAdicionalServico': self.carac_adicional_servico,
            'funcionarioEmissor': self.funcionario_emissor,
            'fluxoOrigem': self.fluxo_origem,
            'entregaTipoPeriodo': self.entrega_tipo_periodo,
            'entregaDataProgramada': self.entrega_data_programada.isoformat(),
            'entregaDataInicial': self.entrega_data_inicial.isoformat(),
            'entregaDataFinal': self.entrega_data_final.isoformat(),
            'entregaTipoHora': self.entrega_tipo_hora,
            'entregaHoraProgramada': self.entrega_hora_programada,
            'entregaHoraInicial': self.entrega_hora_inicial,
            'entregaHoraFinal': self.entrega_hora_final,
            'municipioOrigemCalculo': self.municipio_origem_calculo,
            'municipioDestinoCalculo': self.municipio_destino_calculo,
            'observacoesGerais': self.observacoes_gerais,
            'valorTotalServico': self.valor_total_servico,
            'valorReceber': self.valor_receber,
            'cst': self.cst,
            'baseCalculoIcms': self.base_calculo_icms,
            'aliquotaIcms': self.aliquota_icms,
            'valorIcms': self.valor_icms,
            'percentualReducaoBcIcms': self.percentual_reducao_bc_icms,
            'valorBcIcmsStRetido': self.valor_bc_icms_st_retido,
            'valorIcmsStRetido': self.valor_icms_st_retido,
            'aliquotaIcmsStRetido': self.aliquota_icms_st_retido,
            'valorCreditoPresumidoIcms': self.valor_credito_presumido_icms,
            'percentualBcIcmsOutraUf': self.percentual_bc_icms_outra_uf,
            'valorBcIcmsOutraUf': self.valor_bc_icms_outra_uf,
            'aliquotaIcmsOutraUf': self.aliquota_icms_outra_uf,
            'valorIcmsOutraUf': self.valor_icms_outra_uf,
            'simplesNacionalIndicador': self.simples_nacional_indicador,
            'simplesNacionalTotal': self.simples_nacional_total,
            'informacoesAddFisco': self.informacoes_add_fisco,
            'valorTotalCarga': self.valor_total_carga,
            'produtoPredominante': self.produto_predominante,
            'cargaOutrasCaracteristicas': self.carga_outras_caracteristicas,
            'modalVersaoLayout': self.modal_versao_layout,
            'chaveCteSubstituido': self.chave_cte_substituido,
            'cteEmitenteModelList': [cte_emitente_model.serialize() for cte_emitente_model in self.cte_emitente_model_list],
            'cteLocalColetaModelList': [cte_local_coleta_model.serialize() for cte_local_coleta_model in self.cte_local_coleta_model_list],
            'cteTomadorModelList': [cte_tomador_model.serialize() for cte_tomador_model in self.cte_tomador_model_list],
            'ctePassagemModelList': [cte_passagem_model.serialize() for cte_passagem_model in self.cte_passagem_model_list],
            'cteRemetenteModelList': [cte_remetente_model.serialize() for cte_remetente_model in self.cte_remetente_model_list],
            'cteExpedidorModelList': [cte_expedidor_model.serialize() for cte_expedidor_model in self.cte_expedidor_model_list],
            'cteRecebedorModelList': [cte_recebedor_model.serialize() for cte_recebedor_model in self.cte_recebedor_model_list],
            'cteDestinatarioModelList': [cte_destinatario_model.serialize() for cte_destinatario_model in self.cte_destinatario_model_list],
            'cteLocalEntregaModelList': [cte_local_entrega_model.serialize() for cte_local_entrega_model in self.cte_local_entrega_model_list],
            'cteComponenteModelList': [cte_componente_model.serialize() for cte_componente_model in self.cte_componente_model_list],
            'cteCargaModelList': [cte_carga_model.serialize() for cte_carga_model in self.cte_carga_model_list],
            'cteInformacaoNfOutrosModelList': [cte_informacao_nf_outros_model.serialize() for cte_informacao_nf_outros_model in self.cte_informacao_nf_outros_model_list],
            'cteSeguroModelList': [cte_seguro_model.serialize() for cte_seguro_model in self.cte_seguro_model_list],
            'ctePerigosoModelList': [cte_perigoso_model.serialize() for cte_perigoso_model in self.cte_perigoso_model_list],
            'cteVeiculoNovoModelList': [cte_veiculo_novo_model.serialize() for cte_veiculo_novo_model in self.cte_veiculo_novo_model_list],
            'cteFaturaModelList': [cte_fatura_model.serialize() for cte_fatura_model in self.cte_fatura_model_list],
            'cteDuplicataModelList': [cte_duplicata_model.serialize() for cte_duplicata_model in self.cte_duplicata_model_list],
            'cteRodoviarioModelList': [cte_rodoviario_model.serialize() for cte_rodoviario_model in self.cte_rodoviario_model_list],
            'cteAereoModelList': [cte_aereo_model.serialize() for cte_aereo_model in self.cte_aereo_model_list],
            'cteAquaviarioModelList': [cte_aquaviario_model.serialize() for cte_aquaviario_model in self.cte_aquaviario_model_list],
            'cteFerroviarioModelList': [cte_ferroviario_model.serialize() for cte_ferroviario_model in self.cte_ferroviario_model_list],
            'cteDutoviarioModelList': [cte_dutoviario_model.serialize() for cte_dutoviario_model in self.cte_dutoviario_model_list],
            'cteMultimodalModelList': [cte_multimodal_model.serialize() for cte_multimodal_model in self.cte_multimodal_model_list],
        }