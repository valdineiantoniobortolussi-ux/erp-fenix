from src import db


class GuiasAcumuladasModel(db.Model):
    __tablename__ = 'guias_acumuladas'

    id = db.Column(db.Integer, primary_key=True)
    gps_tipo = db.Column(db.String(1))
    gps_competencia = db.Column(db.String(7))
    gps_valor_inss = db.Column(db.Float)
    gps_valor_outras_ent = db.Column(db.Float)
    gps_data_pagamento = db.Column(db.DateTime)
    irrf_competencia = db.Column(db.String(7))
    irrf_codigo_recolhimento = db.Column(db.Integer)
    irrf_valor_acumulado = db.Column(db.Float)
    irrf_data_pagamento = db.Column(db.DateTime)
    pis_competencia = db.Column(db.String(7))
    pis_valor_acumulado = db.Column(db.Float)
    pis_data_pagamento = db.Column(db.DateTime)


    def mapping(self, data):
        self.id = data.get('id')
        self.gps_tipo = data.get('gpsTipo')
        self.gps_competencia = data.get('gpsCompetencia')
        self.gps_valor_inss = data.get('gpsValorInss')
        self.gps_valor_outras_ent = data.get('gpsValorOutrasEnt')
        self.gps_data_pagamento = data.get('gpsDataPagamento')
        self.irrf_competencia = data.get('irrfCompetencia')
        self.irrf_codigo_recolhimento = data.get('irrfCodigoRecolhimento')
        self.irrf_valor_acumulado = data.get('irrfValorAcumulado')
        self.irrf_data_pagamento = data.get('irrfDataPagamento')
        self.pis_competencia = data.get('pisCompetencia')
        self.pis_valor_acumulado = data.get('pisValorAcumulado')
        self.pis_data_pagamento = data.get('pisDataPagamento')

    def serialize(self):
        return {
            'id': self.id,
            'gpsTipo': self.gps_tipo,
            'gpsCompetencia': self.gps_competencia,
            'gpsValorInss': self.gps_valor_inss,
            'gpsValorOutrasEnt': self.gps_valor_outras_ent,
            'gpsDataPagamento': self.gps_data_pagamento.isoformat(),
            'irrfCompetencia': self.irrf_competencia,
            'irrfCodigoRecolhimento': self.irrf_codigo_recolhimento,
            'irrfValorAcumulado': self.irrf_valor_acumulado,
            'irrfDataPagamento': self.irrf_data_pagamento.isoformat(),
            'pisCompetencia': self.pis_competencia,
            'pisValorAcumulado': self.pis_valor_acumulado,
            'pisDataPagamento': self.pis_data_pagamento.isoformat(),
        }