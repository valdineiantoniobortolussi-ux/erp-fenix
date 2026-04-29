from src import db


class FiscalApuracaoIcmsModel(db.Model):
    __tablename__ = 'fiscal_apuracao_icms'

    id = db.Column(db.Integer, primary_key=True)
    competencia = db.Column(db.String(7))
    valor_total_debito = db.Column(db.Float)
    valor_ajuste_debito = db.Column(db.Float)
    valor_total_ajuste_debito = db.Column(db.Float)
    valor_estorno_credito = db.Column(db.Float)
    valor_total_credito = db.Column(db.Float)
    valor_ajuste_credito = db.Column(db.Float)
    valor_total_ajuste_credito = db.Column(db.Float)
    valor_estorno_debito = db.Column(db.Float)
    valor_saldo_credor_anterior = db.Column(db.Float)
    valor_saldo_apurado = db.Column(db.Float)
    valor_total_deducao = db.Column(db.Float)
    valor_icms_recolher = db.Column(db.Float)
    valor_saldo_credor_transp = db.Column(db.Float)
    valor_debito_especial = db.Column(db.Float)


    def mapping(self, data):
        self.id = data.get('id')
        self.competencia = data.get('competencia')
        self.valor_total_debito = data.get('valorTotalDebito')
        self.valor_ajuste_debito = data.get('valorAjusteDebito')
        self.valor_total_ajuste_debito = data.get('valorTotalAjusteDebito')
        self.valor_estorno_credito = data.get('valorEstornoCredito')
        self.valor_total_credito = data.get('valorTotalCredito')
        self.valor_ajuste_credito = data.get('valorAjusteCredito')
        self.valor_total_ajuste_credito = data.get('valorTotalAjusteCredito')
        self.valor_estorno_debito = data.get('valorEstornoDebito')
        self.valor_saldo_credor_anterior = data.get('valorSaldoCredorAnterior')
        self.valor_saldo_apurado = data.get('valorSaldoApurado')
        self.valor_total_deducao = data.get('valorTotalDeducao')
        self.valor_icms_recolher = data.get('valorIcmsRecolher')
        self.valor_saldo_credor_transp = data.get('valorSaldoCredorTransp')
        self.valor_debito_especial = data.get('valorDebitoEspecial')

    def serialize(self):
        return {
            'id': self.id,
            'competencia': self.competencia,
            'valorTotalDebito': self.valor_total_debito,
            'valorAjusteDebito': self.valor_ajuste_debito,
            'valorTotalAjusteDebito': self.valor_total_ajuste_debito,
            'valorEstornoCredito': self.valor_estorno_credito,
            'valorTotalCredito': self.valor_total_credito,
            'valorAjusteCredito': self.valor_ajuste_credito,
            'valorTotalAjusteCredito': self.valor_total_ajuste_credito,
            'valorEstornoDebito': self.valor_estorno_debito,
            'valorSaldoCredorAnterior': self.valor_saldo_credor_anterior,
            'valorSaldoApurado': self.valor_saldo_apurado,
            'valorTotalDeducao': self.valor_total_deducao,
            'valorIcmsRecolher': self.valor_icms_recolher,
            'valorSaldoCredorTransp': self.valor_saldo_credor_transp,
            'valorDebitoEspecial': self.valor_debito_especial,
        }