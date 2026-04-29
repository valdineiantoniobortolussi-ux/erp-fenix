from src import db
from src.model.contrato_historico_reajuste_model import ContratoHistoricoReajusteModel
from src.model.contrato_prev_faturamento_model import ContratoPrevFaturamentoModel
from src.model.contrato_hist_faturamento_model import ContratoHistFaturamentoModel
from src.model.tipo_contrato_model import TipoContratoModel
from src.model.contrato_solicitacao_servico_model import ContratoSolicitacaoServicoModel


class ContratoModel(db.Model):
    __tablename__ = 'contrato'

    id = db.Column(db.Integer, primary_key=True)
    numero = db.Column(db.String(50))
    nome = db.Column(db.String(100))
    descricao = db.Column(db.Text)
    data_cadastro = db.Column(db.DateTime)
    data_inicio_vigencia = db.Column(db.DateTime)
    data_fim_vigencia = db.Column(db.DateTime)
    dia_faturamento = db.Column(db.String(2))
    valor = db.Column(db.Float)
    quantidade_parcelas = db.Column(db.Integer)
    intervalo_entre_parcelas = db.Column(db.Integer)
    classificacao_contabil_conta = db.Column(db.String(30))
    observacao = db.Column(db.Text)
    id_tipo_contrato = db.Column(db.Integer, db.ForeignKey('tipo_contrato.id'))
    id_solicitacao_servico = db.Column(db.Integer, db.ForeignKey('contrato_solicitacao_servico.id'))

    contrato_historico_reajuste_model_list = db.relationship('ContratoHistoricoReajusteModel', lazy='dynamic')
    contrato_prev_faturamento_model_list = db.relationship('ContratoPrevFaturamentoModel', lazy='dynamic')
    contrato_hist_faturamento_model_list = db.relationship('ContratoHistFaturamentoModel', lazy='dynamic')
    tipo_contrato_model = db.relationship('TipoContratoModel', foreign_keys=[id_tipo_contrato])
    contrato_solicitacao_servico_model = db.relationship('ContratoSolicitacaoServicoModel', foreign_keys=[id_solicitacao_servico])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_solicitacao_servico = data.get('idSolicitacaoServico')
        self.id_tipo_contrato = data.get('idTipoContrato')
        self.numero = data.get('numero')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')
        self.data_cadastro = data.get('dataCadastro')
        self.data_inicio_vigencia = data.get('dataInicioVigencia')
        self.data_fim_vigencia = data.get('dataFimVigencia')
        self.dia_faturamento = data.get('diaFaturamento')
        self.valor = data.get('valor')
        self.quantidade_parcelas = data.get('quantidadeParcelas')
        self.intervalo_entre_parcelas = data.get('intervaloEntreParcelas')
        self.classificacao_contabil_conta = data.get('classificacaoContabilConta')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idSolicitacaoServico': self.id_solicitacao_servico,
            'idTipoContrato': self.id_tipo_contrato,
            'numero': self.numero,
            'nome': self.nome,
            'descricao': self.descricao,
            'dataCadastro': self.data_cadastro.isoformat(),
            'dataInicioVigencia': self.data_inicio_vigencia.isoformat(),
            'dataFimVigencia': self.data_fim_vigencia.isoformat(),
            'diaFaturamento': self.dia_faturamento,
            'valor': self.valor,
            'quantidadeParcelas': self.quantidade_parcelas,
            'intervaloEntreParcelas': self.intervalo_entre_parcelas,
            'classificacaoContabilConta': self.classificacao_contabil_conta,
            'observacao': self.observacao,
            'contratoHistoricoReajusteModelList': [contrato_historico_reajuste_model.serialize() for contrato_historico_reajuste_model in self.contrato_historico_reajuste_model_list],
            'contratoPrevFaturamentoModelList': [contrato_prev_faturamento_model.serialize() for contrato_prev_faturamento_model in self.contrato_prev_faturamento_model_list],
            'contratoHistFaturamentoModelList': [contrato_hist_faturamento_model.serialize() for contrato_hist_faturamento_model in self.contrato_hist_faturamento_model_list],
            'tipoContratoModel': self.tipo_contrato_model.serialize() if self.tipo_contrato_model else None,
            'contratoSolicitacaoServicoModel': self.contrato_solicitacao_servico_model.serialize() if self.contrato_solicitacao_servico_model else None,
        }