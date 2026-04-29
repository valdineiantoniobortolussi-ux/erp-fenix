from src import db
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel
from src.model.view_pessoa_cliente_model import ViewPessoaClienteModel


class OsAberturaModel(db.Model):
    __tablename__ = 'os_abertura'

    id = db.Column(db.Integer, primary_key=True)
    numero = db.Column(db.String(20))
    data_inicio = db.Column(db.DateTime)
    hora_inicio = db.Column(db.String(8))
    data_previsao = db.Column(db.DateTime)
    hora_previsao = db.Column(db.String(8))
    data_fim = db.Column(db.DateTime)
    hora_fim = db.Column(db.String(8))
    nome_contato = db.Column(db.String(50))
    fone_contato = db.Column(db.String(15))
    observacao_cliente = db.Column(db.Text)
    observacao_abertura = db.Column(db.Text)
    id_os_status = db.Column(db.Integer, db.ForeignKey('os_status.id'))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))
    id_cliente = db.Column(db.Integer, db.ForeignKey('view_pessoa_cliente.id'))

    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])
    view_pessoa_cliente_model = db.relationship('ViewPessoaClienteModel', foreign_keys=[id_cliente])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_os_status = data.get('idOsStatus')
        self.id_colaborador = data.get('idColaborador')
        self.id_cliente = data.get('idCliente')
        self.numero = data.get('numero')
        self.data_inicio = data.get('dataInicio')
        self.hora_inicio = data.get('horaInicio')
        self.data_previsao = data.get('dataPrevisao')
        self.hora_previsao = data.get('horaPrevisao')
        self.data_fim = data.get('dataFim')
        self.hora_fim = data.get('horaFim')
        self.nome_contato = data.get('nomeContato')
        self.fone_contato = data.get('foneContato')
        self.observacao_cliente = data.get('observacaoCliente')
        self.observacao_abertura = data.get('observacaoAbertura')

    def serialize(self):
        return {
            'id': self.id,
            'idOsStatus': self.id_os_status,
            'idColaborador': self.id_colaborador,
            'idCliente': self.id_cliente,
            'numero': self.numero,
            'dataInicio': self.data_inicio.isoformat(),
            'horaInicio': self.hora_inicio,
            'dataPrevisao': self.data_previsao.isoformat(),
            'horaPrevisao': self.hora_previsao,
            'dataFim': self.data_fim.isoformat(),
            'horaFim': self.hora_fim,
            'nomeContato': self.nome_contato,
            'foneContato': self.fone_contato,
            'observacaoCliente': self.observacao_cliente,
            'observacaoAbertura': self.observacao_abertura,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
            'viewPessoaClienteModel': self.view_pessoa_cliente_model.serialize() if self.view_pessoa_cliente_model else None,
        }