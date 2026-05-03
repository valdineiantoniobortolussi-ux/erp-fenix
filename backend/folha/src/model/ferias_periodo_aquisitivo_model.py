from src import db
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel


class FeriasPeriodoAquisitivoModel(db.Model):
    __tablename__ = 'ferias_periodo_aquisitivo'

    id = db.Column(db.Integer, primary_key=True)
    data_inicio = db.Column(db.DateTime)
    data_fim = db.Column(db.DateTime)
    situacao = db.Column(db.String(1))
    limite_para_gozo = db.Column(db.DateTime)
    descontar_faltas = db.Column(db.String(1))
    desconsiderar_afastamento = db.Column(db.String(1))
    afastamento_previdencia = db.Column(db.Integer)
    afastamento_sem_remun = db.Column(db.Integer)
    afastamento_com_remun = db.Column(db.Integer)
    dias_direito = db.Column(db.Integer)
    dias_gozados = db.Column(db.Integer)
    dias_faltas = db.Column(db.Integer)
    dias_restantes = db.Column(db.Integer)
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_colaborador = data.get('idColaborador')
        self.data_inicio = data.get('dataInicio')
        self.data_fim = data.get('dataFim')
        self.situacao = data.get('situacao')
        self.limite_para_gozo = data.get('limiteParaGozo')
        self.descontar_faltas = data.get('descontarFaltas')
        self.desconsiderar_afastamento = data.get('desconsiderarAfastamento')
        self.afastamento_previdencia = data.get('afastamentoPrevidencia')
        self.afastamento_sem_remun = data.get('afastamentoSemRemun')
        self.afastamento_com_remun = data.get('afastamentoComRemun')
        self.dias_direito = data.get('diasDireito')
        self.dias_gozados = data.get('diasGozados')
        self.dias_faltas = data.get('diasFaltas')
        self.dias_restantes = data.get('diasRestantes')

    def serialize(self):
        return {
            'id': self.id,
            'idColaborador': self.id_colaborador,
            'dataInicio': self.data_inicio.isoformat(),
            'dataFim': self.data_fim.isoformat(),
            'situacao': self.situacao,
            'limiteParaGozo': self.limite_para_gozo.isoformat(),
            'descontarFaltas': self.descontar_faltas,
            'desconsiderarAfastamento': self.desconsiderar_afastamento,
            'afastamentoPrevidencia': self.afastamento_previdencia,
            'afastamentoSemRemun': self.afastamento_sem_remun,
            'afastamentoComRemun': self.afastamento_com_remun,
            'diasDireito': self.dias_direito,
            'diasGozados': self.dias_gozados,
            'diasFaltas': self.dias_faltas,
            'diasRestantes': self.dias_restantes,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
        }