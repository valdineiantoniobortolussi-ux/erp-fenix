from src import db


class FolhaParametroModel(db.Model):
    __tablename__ = 'folha_parametro'

    id = db.Column(db.Integer, primary_key=True)
    competencia = db.Column(db.String(7))
    contribui_pis = db.Column(db.String(1))
    aliquota_pis = db.Column(db.Float)
    discriminar_dsr = db.Column(db.String(1))
    dia_pagamento = db.Column(db.String(2))
    calculo_proporcionalidade = db.Column(db.String(1))
    descontar_faltas_13 = db.Column(db.String(1))
    pagar_adicionais_13 = db.Column(db.String(1))
    pagar_estagiarios_13 = db.Column(db.String(1))
    mes_adiantamento_13 = db.Column(db.String(2))
    percentual_adiantam_13 = db.Column(db.Float)
    ferias_descontar_faltas = db.Column(db.String(1))
    ferias_pagar_adicionais = db.Column(db.String(1))
    ferias_adiantar_13 = db.Column(db.String(1))
    ferias_pagar_estagiarios = db.Column(db.String(1))
    ferias_calc_justa_causa = db.Column(db.String(1))
    ferias_movimento_mensal = db.Column(db.String(1))


    def mapping(self, data):
        self.id = data.get('id')
        self.competencia = data.get('competencia')
        self.contribui_pis = data.get('contribuiPis')
        self.aliquota_pis = data.get('aliquotaPis')
        self.discriminar_dsr = data.get('discriminarDsr')
        self.dia_pagamento = data.get('diaPagamento')
        self.calculo_proporcionalidade = data.get('calculoProporcionalidade')
        self.descontar_faltas_13 = data.get('descontarFaltas13')
        self.pagar_adicionais_13 = data.get('pagarAdicionais13')
        self.pagar_estagiarios_13 = data.get('pagarEstagiarios13')
        self.mes_adiantamento_13 = data.get('mesAdiantamento13')
        self.percentual_adiantam_13 = data.get('percentualAdiantam13')
        self.ferias_descontar_faltas = data.get('feriasDescontarFaltas')
        self.ferias_pagar_adicionais = data.get('feriasPagarAdicionais')
        self.ferias_adiantar_13 = data.get('feriasAdiantar13')
        self.ferias_pagar_estagiarios = data.get('feriasPagarEstagiarios')
        self.ferias_calc_justa_causa = data.get('feriasCalcJustaCausa')
        self.ferias_movimento_mensal = data.get('feriasMovimentoMensal')

    def serialize(self):
        return {
            'id': self.id,
            'competencia': self.competencia,
            'contribuiPis': self.contribui_pis,
            'aliquotaPis': self.aliquota_pis,
            'discriminarDsr': self.discriminar_dsr,
            'diaPagamento': self.dia_pagamento,
            'calculoProporcionalidade': self.calculo_proporcionalidade,
            'descontarFaltas13': self.descontar_faltas_13,
            'pagarAdicionais13': self.pagar_adicionais_13,
            'pagarEstagiarios13': self.pagar_estagiarios_13,
            'mesAdiantamento13': self.mes_adiantamento_13,
            'percentualAdiantam13': self.percentual_adiantam_13,
            'feriasDescontarFaltas': self.ferias_descontar_faltas,
            'feriasPagarAdicionais': self.ferias_pagar_adicionais,
            'feriasAdiantar13': self.ferias_adiantar_13,
            'feriasPagarEstagiarios': self.ferias_pagar_estagiarios,
            'feriasCalcJustaCausa': self.ferias_calc_justa_causa,
            'feriasMovimentoMensal': self.ferias_movimento_mensal,
        }