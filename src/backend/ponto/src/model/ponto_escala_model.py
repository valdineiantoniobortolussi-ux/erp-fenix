from src import db
from src.model.ponto_turma_model import PontoTurmaModel


class PontoEscalaModel(db.Model):
    __tablename__ = 'ponto_escala'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(50))
    desconto_hora_dia = db.Column(db.String(8))
    desconto_dsr = db.Column(db.String(8))
    codigo_horario_domingo = db.Column(db.String(4))
    codigo_horario_segunda = db.Column(db.String(4))
    codigo_horario_terca = db.Column(db.String(4))
    codigo_horario_quarta = db.Column(db.String(4))
    codigo_horario_quinta = db.Column(db.String(4))
    codigo_horario_sexta = db.Column(db.String(4))
    codigo_horario_sabado = db.Column(db.String(4))

    ponto_turma_model_list = db.relationship('PontoTurmaModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.desconto_hora_dia = data.get('descontoHoraDia')
        self.desconto_dsr = data.get('descontoDsr')
        self.codigo_horario_domingo = data.get('codigoHorarioDomingo')
        self.codigo_horario_segunda = data.get('codigoHorarioSegunda')
        self.codigo_horario_terca = data.get('codigoHorarioTerca')
        self.codigo_horario_quarta = data.get('codigoHorarioQuarta')
        self.codigo_horario_quinta = data.get('codigoHorarioQuinta')
        self.codigo_horario_sexta = data.get('codigoHorarioSexta')
        self.codigo_horario_sabado = data.get('codigoHorarioSabado')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'descontoHoraDia': self.desconto_hora_dia,
            'descontoDsr': self.desconto_dsr,
            'codigoHorarioDomingo': self.codigo_horario_domingo,
            'codigoHorarioSegunda': self.codigo_horario_segunda,
            'codigoHorarioTerca': self.codigo_horario_terca,
            'codigoHorarioQuarta': self.codigo_horario_quarta,
            'codigoHorarioQuinta': self.codigo_horario_quinta,
            'codigoHorarioSexta': self.codigo_horario_sexta,
            'codigoHorarioSabado': self.codigo_horario_sabado,
            'pontoTurmaModelList': [ponto_turma_model.serialize() for ponto_turma_model in self.ponto_turma_model_list],
        }