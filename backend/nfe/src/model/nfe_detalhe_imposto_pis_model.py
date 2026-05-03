from src import db


class NfeDetalheImpostoPisModel(db.Model):
    __tablename__ = 'nfe_detalhe_imposto_pis'

    id = db.Column(db.Integer, primary_key=True)
    cst_pis = db.Column(db.String(2))
    valor_base_calculo_pis = db.Column(db.Float)
    aliquota_pis_percentual = db.Column(db.Float)
    valor_pis = db.Column(db.Float)
    quantidade_vendida = db.Column(db.Float)
    aliquota_pis_reais = db.Column(db.Float)
    id_nfe_detalhe = db.Column(db.Integer, db.ForeignKey('nfe_detalhe.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_detalhe = data.get('idNfeDetalhe')
        self.cst_pis = data.get('cstPis')
        self.valor_base_calculo_pis = data.get('valorBaseCalculoPis')
        self.aliquota_pis_percentual = data.get('aliquotaPisPercentual')
        self.valor_pis = data.get('valorPis')
        self.quantidade_vendida = data.get('quantidadeVendida')
        self.aliquota_pis_reais = data.get('aliquotaPisReais')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeDetalhe': self.id_nfe_detalhe,
            'cstPis': self.cst_pis,
            'valorBaseCalculoPis': self.valor_base_calculo_pis,
            'aliquotaPisPercentual': self.aliquota_pis_percentual,
            'valorPis': self.valor_pis,
            'quantidadeVendida': self.quantidade_vendida,
            'aliquotaPisReais': self.aliquota_pis_reais,
        }