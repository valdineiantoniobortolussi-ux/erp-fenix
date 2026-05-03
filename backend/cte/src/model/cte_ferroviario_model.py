from src import db


class CteFerroviarioModel(db.Model):
    __tablename__ = 'cte_ferroviario'

    id = db.Column(db.Integer, primary_key=True)
    tipo_trafego = db.Column(db.String(1))
    responsavel_faturamento = db.Column(db.String(1))
    ferrovia_emitente_cte = db.Column(db.String(1))
    fluxo = db.Column(db.String(10))
    id_trem = db.Column(db.String(7))
    valor_frete = db.Column(db.Float)
    id_cte_cabecalho = db.Column(db.Integer, db.ForeignKey('cte_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_cabecalho = data.get('idCteCabecalho')
        self.tipo_trafego = data.get('tipoTrafego')
        self.responsavel_faturamento = data.get('responsavelFaturamento')
        self.ferrovia_emitente_cte = data.get('ferroviaEmitenteCte')
        self.fluxo = data.get('fluxo')
        self.id_trem = data.get('idTrem')
        self.valor_frete = data.get('valorFrete')

    def serialize(self):
        return {
            'id': self.id,
            'idCteCabecalho': self.id_cte_cabecalho,
            'tipoTrafego': self.tipo_trafego,
            'responsavelFaturamento': self.responsavel_faturamento,
            'ferroviaEmitenteCte': self.ferrovia_emitente_cte,
            'fluxo': self.fluxo,
            'idTrem': self.id_trem,
            'valorFrete': self.valor_frete,
        }