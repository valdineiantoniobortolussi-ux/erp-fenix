from src import db


class PontoParametroModel(db.Model):
    __tablename__ = 'ponto_parametro'

    id = db.Column(db.Integer, primary_key=True)
    mes_ano = db.Column(db.String(7))
    dia_inicial_apuracao = db.Column(db.Integer)
    hora_noturna_inicio = db.Column(db.String(8))
    hora_noturna_fim = db.Column(db.String(8))
    periodo_minimo_interjornada = db.Column(db.String(8))
    percentual_he_diurna = db.Column(db.Float)
    percentual_he_noturna = db.Column(db.Float)
    duracao_hora_noturna = db.Column(db.String(8))
    tratamento_hora_mais = db.Column(db.String(1))
    tratamento_hora_menos = db.Column(db.String(1))


    def mapping(self, data):
        self.id = data.get('id')
        self.mes_ano = data.get('mesAno')
        self.dia_inicial_apuracao = data.get('diaInicialApuracao')
        self.hora_noturna_inicio = data.get('horaNoturnaInicio')
        self.hora_noturna_fim = data.get('horaNoturnaFim')
        self.periodo_minimo_interjornada = data.get('periodoMinimoInterjornada')
        self.percentual_he_diurna = data.get('percentualHeDiurna')
        self.percentual_he_noturna = data.get('percentualHeNoturna')
        self.duracao_hora_noturna = data.get('duracaoHoraNoturna')
        self.tratamento_hora_mais = data.get('tratamentoHoraMais')
        self.tratamento_hora_menos = data.get('tratamentoHoraMenos')

    def serialize(self):
        return {
            'id': self.id,
            'mesAno': self.mes_ano,
            'diaInicialApuracao': self.dia_inicial_apuracao,
            'horaNoturnaInicio': self.hora_noturna_inicio,
            'horaNoturnaFim': self.hora_noturna_fim,
            'periodoMinimoInterjornada': self.periodo_minimo_interjornada,
            'percentualHeDiurna': self.percentual_he_diurna,
            'percentualHeNoturna': self.percentual_he_noturna,
            'duracaoHoraNoturna': self.duracao_hora_noturna,
            'tratamentoHoraMais': self.tratamento_hora_mais,
            'tratamentoHoraMenos': self.tratamento_hora_menos,
        }