from src import db


class NfeDetalheImpostoPisStModel(db.Model):
    __tablename__ = 'nfe_detalhe_imposto_pis_st'

    id = db.Column(db.Integer, primary_key=True)
    valor_base_calculo_pis_st = db.Column(db.Float)
    aliquota_pis_st_percentual = db.Column(db.Float)
    quantidade_vendida_pis_st = db.Column(db.Float)
    aliquota_pis_st_reais = db.Column(db.Float)
    valor_pis_st = db.Column(db.Float)
    id_nfe_detalhe = db.Column(db.Integer, db.ForeignKey('nfe_detalhe.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_detalhe = data.get('idNfeDetalhe')
        self.valor_base_calculo_pis_st = data.get('valorBaseCalculoPisSt')
        self.aliquota_pis_st_percentual = data.get('aliquotaPisStPercentual')
        self.quantidade_vendida_pis_st = data.get('quantidadeVendidaPisSt')
        self.aliquota_pis_st_reais = data.get('aliquotaPisStReais')
        self.valor_pis_st = data.get('valorPisSt')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeDetalhe': self.id_nfe_detalhe,
            'valorBaseCalculoPisSt': self.valor_base_calculo_pis_st,
            'aliquotaPisStPercentual': self.aliquota_pis_st_percentual,
            'quantidadeVendidaPisSt': self.quantidade_vendida_pis_st,
            'aliquotaPisStReais': self.aliquota_pis_st_reais,
            'valorPisSt': self.valor_pis_st,
        }