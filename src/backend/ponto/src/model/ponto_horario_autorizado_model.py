from src import db
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel


class PontoHorarioAutorizadoModel(db.Model):
    __tablename__ = 'ponto_horario_autorizado'

    id = db.Column(db.Integer, primary_key=True)
    data_horario = db.Column(db.DateTime)
    tipo = db.Column(db.String(1))
    carga_horaria = db.Column(db.String(8))
    entrada01 = db.Column(db.String(8))
    saida01 = db.Column(db.String(8))
    entrada02 = db.Column(db.String(8))
    saida02 = db.Column(db.String(8))
    entrada03 = db.Column(db.String(8))
    saida03 = db.Column(db.String(8))
    entrada04 = db.Column(db.String(8))
    saida04 = db.Column(db.String(8))
    entrada05 = db.Column(db.String(8))
    saida05 = db.Column(db.String(8))
    hora_fechamento_dia = db.Column(db.String(8))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_colaborador = data.get('idColaborador')
        self.data_horario = data.get('dataHorario')
        self.tipo = data.get('tipo')
        self.carga_horaria = data.get('cargaHoraria')
        self.entrada01 = data.get('entrada01')
        self.saida01 = data.get('saida01')
        self.entrada02 = data.get('entrada02')
        self.saida02 = data.get('saida02')
        self.entrada03 = data.get('entrada03')
        self.saida03 = data.get('saida03')
        self.entrada04 = data.get('entrada04')
        self.saida04 = data.get('saida04')
        self.entrada05 = data.get('entrada05')
        self.saida05 = data.get('saida05')
        self.hora_fechamento_dia = data.get('horaFechamentoDia')

    def serialize(self):
        return {
            'id': self.id,
            'idColaborador': self.id_colaborador,
            'dataHorario': self.data_horario.isoformat(),
            'tipo': self.tipo,
            'cargaHoraria': self.carga_horaria,
            'entrada01': self.entrada01,
            'saida01': self.saida01,
            'entrada02': self.entrada02,
            'saida02': self.saida02,
            'entrada03': self.entrada03,
            'saida03': self.saida03,
            'entrada04': self.entrada04,
            'saida04': self.saida04,
            'entrada05': self.entrada05,
            'saida05': self.saida05,
            'horaFechamentoDia': self.hora_fechamento_dia,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
        }