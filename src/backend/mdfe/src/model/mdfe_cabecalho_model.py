from src import db
from src.model.mdfe_lacre_model import MdfeLacreModel
from src.model.mdfe_municipio_descarrega_model import MdfeMunicipioDescarregaModel
from src.model.mdfe_emitente_model import MdfeEmitenteModel
from src.model.mdfe_percurso_model import MdfePercursoModel
from src.model.mdfe_municipio_carregamento_model import MdfeMunicipioCarregamentoModel
from src.model.mdfe_rodoviario_model import MdfeRodoviarioModel
from src.model.mdfe_informacao_seguro_model import MdfeInformacaoSeguroModel


class MdfeCabecalhoModel(db.Model):
    __tablename__ = 'mdfe_cabecalho'

    id = db.Column(db.Integer, primary_key=True)
    uf = db.Column(db.String(2))
    tipo_ambiente = db.Column(db.String(1))
    tipo_emitente = db.Column(db.String(1))
    tipo_transportadora = db.Column(db.String(3))
    modelo = db.Column(db.String(2))
    serie = db.Column(db.String(3))
    numero_mdfe = db.Column(db.String(9))
    codigo_numerico = db.Column(db.String(8))
    chave_acesso = db.Column(db.String(44))
    digito_verificador = db.Column(db.Integer)
    modal = db.Column(db.String(1))
    data_hora_emissao = db.Column(db.DateTime)
    tipo_emissao = db.Column(db.String(1))
    processo_emissao = db.Column(db.String(1))
    versao_processo_emissao = db.Column(db.String(20))
    uf_inicio = db.Column(db.String(2))
    uf_fim = db.Column(db.String(2))
    data_hora_previsao_viagem = db.Column(db.DateTime)
    quantidade_total_cte = db.Column(db.Integer)
    quantidade_total_nfe = db.Column(db.Integer)
    quantidade_total_mdfe = db.Column(db.Integer)
    codigo_unidade_medida = db.Column(db.String(2))
    peso_bruto_carga = db.Column(db.Float)
    valor_carga = db.Column(db.Float)
    numero_protocolo = db.Column(db.String(15))

    mdfe_lacre_model_list = db.relationship('MdfeLacreModel', lazy='dynamic')
    mdfe_municipio_descarrega_model_list = db.relationship('MdfeMunicipioDescarregaModel', lazy='dynamic')
    mdfe_emitente_model_list = db.relationship('MdfeEmitenteModel', lazy='dynamic')
    mdfe_percurso_model_list = db.relationship('MdfePercursoModel', lazy='dynamic')
    mdfe_municipio_carregamento_model_list = db.relationship('MdfeMunicipioCarregamentoModel', lazy='dynamic')
    mdfe_rodoviario_model_list = db.relationship('MdfeRodoviarioModel', lazy='dynamic')
    mdfe_informacao_seguro_model_list = db.relationship('MdfeInformacaoSeguroModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.uf = data.get('uf')
        self.tipo_ambiente = data.get('tipoAmbiente')
        self.tipo_emitente = data.get('tipoEmitente')
        self.tipo_transportadora = data.get('tipoTransportadora')
        self.modelo = data.get('modelo')
        self.serie = data.get('serie')
        self.numero_mdfe = data.get('numeroMdfe')
        self.codigo_numerico = data.get('codigoNumerico')
        self.chave_acesso = data.get('chaveAcesso')
        self.digito_verificador = data.get('digitoVerificador')
        self.modal = data.get('modal')
        self.data_hora_emissao = data.get('dataHoraEmissao')
        self.tipo_emissao = data.get('tipoEmissao')
        self.processo_emissao = data.get('processoEmissao')
        self.versao_processo_emissao = data.get('versaoProcessoEmissao')
        self.uf_inicio = data.get('ufInicio')
        self.uf_fim = data.get('ufFim')
        self.data_hora_previsao_viagem = data.get('dataHoraPrevisaoViagem')
        self.quantidade_total_cte = data.get('quantidadeTotalCte')
        self.quantidade_total_nfe = data.get('quantidadeTotalNfe')
        self.quantidade_total_mdfe = data.get('quantidadeTotalMdfe')
        self.codigo_unidade_medida = data.get('codigoUnidadeMedida')
        self.peso_bruto_carga = data.get('pesoBrutoCarga')
        self.valor_carga = data.get('valorCarga')
        self.numero_protocolo = data.get('numeroProtocolo')

    def serialize(self):
        return {
            'id': self.id,
            'uf': self.uf,
            'tipoAmbiente': self.tipo_ambiente,
            'tipoEmitente': self.tipo_emitente,
            'tipoTransportadora': self.tipo_transportadora,
            'modelo': self.modelo,
            'serie': self.serie,
            'numeroMdfe': self.numero_mdfe,
            'codigoNumerico': self.codigo_numerico,
            'chaveAcesso': self.chave_acesso,
            'digitoVerificador': self.digito_verificador,
            'modal': self.modal,
            'dataHoraEmissao': self.data_hora_emissao.isoformat(),
            'tipoEmissao': self.tipo_emissao,
            'processoEmissao': self.processo_emissao,
            'versaoProcessoEmissao': self.versao_processo_emissao,
            'ufInicio': self.uf_inicio,
            'ufFim': self.uf_fim,
            'dataHoraPrevisaoViagem': self.data_hora_previsao_viagem.isoformat(),
            'quantidadeTotalCte': self.quantidade_total_cte,
            'quantidadeTotalNfe': self.quantidade_total_nfe,
            'quantidadeTotalMdfe': self.quantidade_total_mdfe,
            'codigoUnidadeMedida': self.codigo_unidade_medida,
            'pesoBrutoCarga': self.peso_bruto_carga,
            'valorCarga': self.valor_carga,
            'numeroProtocolo': self.numero_protocolo,
            'mdfeLacreModelList': [mdfe_lacre_model.serialize() for mdfe_lacre_model in self.mdfe_lacre_model_list],
            'mdfeMunicipioDescarregaModelList': [mdfe_municipio_descarrega_model.serialize() for mdfe_municipio_descarrega_model in self.mdfe_municipio_descarrega_model_list],
            'mdfeEmitenteModelList': [mdfe_emitente_model.serialize() for mdfe_emitente_model in self.mdfe_emitente_model_list],
            'mdfePercursoModelList': [mdfe_percurso_model.serialize() for mdfe_percurso_model in self.mdfe_percurso_model_list],
            'mdfeMunicipioCarregamentoModelList': [mdfe_municipio_carregamento_model.serialize() for mdfe_municipio_carregamento_model in self.mdfe_municipio_carregamento_model_list],
            'mdfeRodoviarioModelList': [mdfe_rodoviario_model.serialize() for mdfe_rodoviario_model in self.mdfe_rodoviario_model_list],
            'mdfeInformacaoSeguroModelList': [mdfe_informacao_seguro_model.serialize() for mdfe_informacao_seguro_model in self.mdfe_informacao_seguro_model_list],
        }