from src import db


class PontoHorarioModel(db.Model):
    __tablename__ = 'ponto_horario'

    id = db.Column(db.Integer, primary_key=True)
    tipo = db.Column(db.String(1))
    codigo = db.Column(db.String(4))
    nome = db.Column(db.String(50))
    tipo_trabalho = db.Column(db.String(1))
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
    hora_inicio_jornada = db.Column(db.String(8))
    hora_fim_jornada = db.Column(db.String(8))


    def mapping(self, data):
        self.id = data.get('id')
        self.tipo = data.get('tipo')
        self.codigo = data.get('codigo')
        self.nome = data.get('nome')
        self.tipo_trabalho = data.get('tipoTrabalho')
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
        self.hora_inicio_jornada = data.get('horaInicioJornada')
        self.hora_fim_jornada = data.get('horaFimJornada')

    def serialize(self):
        return {
            'id': self.id,
            'tipo': self.tipo,
            'codigo': self.codigo,
            'nome': self.nome,
            'tipoTrabalho': self.tipo_trabalho,
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
            'horaInicioJornada': self.hora_inicio_jornada,
            'horaFimJornada': self.hora_fim_jornada,
        }