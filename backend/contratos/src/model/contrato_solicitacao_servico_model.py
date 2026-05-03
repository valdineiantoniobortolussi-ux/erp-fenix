from src import db
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel
from src.model.view_pessoa_cliente_model import ViewPessoaClienteModel
from src.model.view_pessoa_fornecedor_model import ViewPessoaFornecedorModel
from src.model.setor_model import SetorModel
from src.model.contrato_tipo_servico_model import ContratoTipoServicoModel


class ContratoSolicitacaoServicoModel(db.Model):
    __tablename__ = 'contrato_solicitacao_servico'

    id = db.Column(db.Integer, primary_key=True)
    data_solicitacao = db.Column(db.DateTime)
    data_desejada_inicio = db.Column(db.DateTime)
    urgente = db.Column(db.String(1))
    status_solicitacao = db.Column(db.String(1))
    descricao = db.Column(db.String(100))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))
    id_cliente = db.Column(db.Integer, db.ForeignKey('view_pessoa_cliente.id'))
    id_fornecedor = db.Column(db.Integer, db.ForeignKey('view_pessoa_fornecedor.id'))
    id_setor = db.Column(db.Integer, db.ForeignKey('setor.id'))
    id_contrato_tipo_servico = db.Column(db.Integer, db.ForeignKey('contrato_tipo_servico.id'))

    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])
    view_pessoa_cliente_model = db.relationship('ViewPessoaClienteModel', foreign_keys=[id_cliente])
    view_pessoa_fornecedor_model = db.relationship('ViewPessoaFornecedorModel', foreign_keys=[id_fornecedor])
    setor_model = db.relationship('SetorModel', foreign_keys=[id_setor])
    contrato_tipo_servico_model = db.relationship('ContratoTipoServicoModel', foreign_keys=[id_contrato_tipo_servico])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_contrato_tipo_servico = data.get('idContratoTipoServico')
        self.id_setor = data.get('idSetor')
        self.id_colaborador = data.get('idColaborador')
        self.id_cliente = data.get('idCliente')
        self.id_fornecedor = data.get('idFornecedor')
        self.data_solicitacao = data.get('dataSolicitacao')
        self.data_desejada_inicio = data.get('dataDesejadaInicio')
        self.urgente = data.get('urgente')
        self.status_solicitacao = data.get('statusSolicitacao')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'idContratoTipoServico': self.id_contrato_tipo_servico,
            'idSetor': self.id_setor,
            'idColaborador': self.id_colaborador,
            'idCliente': self.id_cliente,
            'idFornecedor': self.id_fornecedor,
            'dataSolicitacao': self.data_solicitacao.isoformat(),
            'dataDesejadaInicio': self.data_desejada_inicio.isoformat(),
            'urgente': self.urgente,
            'statusSolicitacao': self.status_solicitacao,
            'descricao': self.descricao,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
            'viewPessoaClienteModel': self.view_pessoa_cliente_model.serialize() if self.view_pessoa_cliente_model else None,
            'viewPessoaFornecedorModel': self.view_pessoa_fornecedor_model.serialize() if self.view_pessoa_fornecedor_model else None,
            'setorModel': self.setor_model.serialize() if self.setor_model else None,
            'contratoTipoServicoModel': self.contrato_tipo_servico_model.serialize() if self.contrato_tipo_servico_model else None,
        }