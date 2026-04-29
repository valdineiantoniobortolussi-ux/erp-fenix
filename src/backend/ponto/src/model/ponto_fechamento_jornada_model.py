from src import db
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel
from src.model.ponto_classificacao_jornada_model import PontoClassificacaoJornadaModel


class PontoFechamentoJornadaModel(db.Model):
    __tablename__ = 'ponto_fechamento_jornada'

    id = db.Column(db.Integer, primary_key=True)
    data_fechamento = db.Column(db.DateTime)
    dia_semana = db.Column(db.String(7))
    codigo_horario = db.Column(db.String(4))
    carga_horaria_esperada = db.Column(db.String(8))
    carga_horaria_diurna = db.Column(db.String(8))
    carga_horaria_noturna = db.Column(db.String(8))
    carga_horaria_total = db.Column(db.String(8))
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
    hora_inicio_jornada = db.Column(db.String(8))
    hora_fim_jornada = db.Column(db.String(8))
    hora_extra01 = db.Column(db.String(8))
    percentual_hora_extra01 = db.Column(db.Float)
    modalidade_hora_extra01 = db.Column(db.String(1))
    hora_extra02 = db.Column(db.String(8))
    percentual_hora_extra02 = db.Column(db.Float)
    modalidade_hora_extra02 = db.Column(db.String(1))
    hora_extra03 = db.Column(db.String(8))
    percentual_hora_extra03 = db.Column(db.Float)
    modalidade_hora_extra03 = db.Column(db.String(1))
    hora_extra04 = db.Column(db.String(8))
    percentual_hora_extra04 = db.Column(db.Float)
    modalidade_hora_extra04 = db.Column(db.String(1))
    falta_atraso = db.Column(db.String(8))
    compensar = db.Column(db.String(1))
    banco_horas = db.Column(db.String(8))
    observacao = db.Column(db.String(250))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))
    id_ponto_classificacao_jornada = db.Column(db.Integer, db.ForeignKey('ponto_classificacao_jornada.id'))

    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])
    ponto_classificacao_jornada_model = db.relationship('PontoClassificacaoJornadaModel', foreign_keys=[id_ponto_classificacao_jornada])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_ponto_classificacao_jornada = data.get('idPontoClassificacaoJornada')
        self.id_colaborador = data.get('idColaborador')
        self.data_fechamento = data.get('dataFechamento')
        self.dia_semana = data.get('diaSemana')
        self.codigo_horario = data.get('codigoHorario')
        self.carga_horaria_esperada = data.get('cargaHorariaEsperada')
        self.carga_horaria_diurna = data.get('cargaHorariaDiurna')
        self.carga_horaria_noturna = data.get('cargaHorariaNoturna')
        self.carga_horaria_total = data.get('cargaHorariaTotal')
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
        self.hora_inicio_jornada = data.get('horaInicioJornada')
        self.hora_fim_jornada = data.get('horaFimJornada')
        self.hora_extra01 = data.get('horaExtra01')
        self.percentual_hora_extra01 = data.get('percentualHoraExtra01')
        self.modalidade_hora_extra01 = data.get('modalidadeHoraExtra01')
        self.hora_extra02 = data.get('horaExtra02')
        self.percentual_hora_extra02 = data.get('percentualHoraExtra02')
        self.modalidade_hora_extra02 = data.get('modalidadeHoraExtra02')
        self.hora_extra03 = data.get('horaExtra03')
        self.percentual_hora_extra03 = data.get('percentualHoraExtra03')
        self.modalidade_hora_extra03 = data.get('modalidadeHoraExtra03')
        self.hora_extra04 = data.get('horaExtra04')
        self.percentual_hora_extra04 = data.get('percentualHoraExtra04')
        self.modalidade_hora_extra04 = data.get('modalidadeHoraExtra04')
        self.falta_atraso = data.get('faltaAtraso')
        self.compensar = data.get('compensar')
        self.banco_horas = data.get('bancoHoras')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idPontoClassificacaoJornada': self.id_ponto_classificacao_jornada,
            'idColaborador': self.id_colaborador,
            'dataFechamento': self.data_fechamento.isoformat(),
            'diaSemana': self.dia_semana,
            'codigoHorario': self.codigo_horario,
            'cargaHorariaEsperada': self.carga_horaria_esperada,
            'cargaHorariaDiurna': self.carga_horaria_diurna,
            'cargaHorariaNoturna': self.carga_horaria_noturna,
            'cargaHorariaTotal': self.carga_horaria_total,
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
            'horaInicioJornada': self.hora_inicio_jornada,
            'horaFimJornada': self.hora_fim_jornada,
            'horaExtra01': self.hora_extra01,
            'percentualHoraExtra01': self.percentual_hora_extra01,
            'modalidadeHoraExtra01': self.modalidade_hora_extra01,
            'horaExtra02': self.hora_extra02,
            'percentualHoraExtra02': self.percentual_hora_extra02,
            'modalidadeHoraExtra02': self.modalidade_hora_extra02,
            'horaExtra03': self.hora_extra03,
            'percentualHoraExtra03': self.percentual_hora_extra03,
            'modalidadeHoraExtra03': self.modalidade_hora_extra03,
            'horaExtra04': self.hora_extra04,
            'percentualHoraExtra04': self.percentual_hora_extra04,
            'modalidadeHoraExtra04': self.modalidade_hora_extra04,
            'faltaAtraso': self.falta_atraso,
            'compensar': self.compensar,
            'bancoHoras': self.banco_horas,
            'observacao': self.observacao,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
            'pontoClassificacaoJornadaModel': self.ponto_classificacao_jornada_model.serialize() if self.ponto_classificacao_jornada_model else None,
        }