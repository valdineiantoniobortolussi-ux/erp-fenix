from src import db


class FolhaFeriasColetivasModel(db.Model):
    __tablename__ = 'folha_ferias_coletivas'

    id = db.Column(db.Integer, primary_key=True)
    data_inicio = db.Column(db.DateTime)
    data_fim = db.Column(db.DateTime)
    dias_gozo = db.Column(db.Integer)
    abono_pecuniario_inicio = db.Column(db.DateTime)
    abono_pecuniario_fim = db.Column(db.DateTime)
    dias_abono = db.Column(db.Integer)
    data_pagamento = db.Column(db.DateTime)


    def mapping(self, data):
        self.id = data.get('id')
        self.data_inicio = data.get('dataInicio')
        self.data_fim = data.get('dataFim')
        self.dias_gozo = data.get('diasGozo')
        self.abono_pecuniario_inicio = data.get('abonoPecuniarioInicio')
        self.abono_pecuniario_fim = data.get('abonoPecuniarioFim')
        self.dias_abono = data.get('diasAbono')
        self.data_pagamento = data.get('dataPagamento')

    def serialize(self):
        return {
            'id': self.id,
            'dataInicio': self.data_inicio.isoformat(),
            'dataFim': self.data_fim.isoformat(),
            'diasGozo': self.dias_gozo,
            'abonoPecuniarioInicio': self.abono_pecuniario_inicio.isoformat(),
            'abonoPecuniarioFim': self.abono_pecuniario_fim.isoformat(),
            'diasAbono': self.dias_abono,
            'dataPagamento': self.data_pagamento.isoformat(),
        }