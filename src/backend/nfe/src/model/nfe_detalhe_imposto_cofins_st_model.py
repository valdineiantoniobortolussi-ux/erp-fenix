from src import db


class NfeDetalheImpostoCofinsStModel(db.Model):
    __tablename__ = 'nfe_detalhe_imposto_cofins_st'

    id = db.Column(db.Integer, primary_key=True)
    base_calculo_cofins_st = db.Column(db.Float)
    aliquota_cofins_st_percentual = db.Column(db.Float)
    quantidade_vendida_cofins_st = db.Column(db.Float)
    aliquota_cofins_st_reais = db.Column(db.Float)
    valor_cofins_st = db.Column(db.Float)
    id_nfe_detalhe = db.Column(db.Integer, db.ForeignKey('nfe_detalhe.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_detalhe = data.get('idNfeDetalhe')
        self.base_calculo_cofins_st = data.get('baseCalculoCofinsSt')
        self.aliquota_cofins_st_percentual = data.get('aliquotaCofinsStPercentual')
        self.quantidade_vendida_cofins_st = data.get('quantidadeVendidaCofinsSt')
        self.aliquota_cofins_st_reais = data.get('aliquotaCofinsStReais')
        self.valor_cofins_st = data.get('valorCofinsSt')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeDetalhe': self.id_nfe_detalhe,
            'baseCalculoCofinsSt': self.base_calculo_cofins_st,
            'aliquotaCofinsStPercentual': self.aliquota_cofins_st_percentual,
            'quantidadeVendidaCofinsSt': self.quantidade_vendida_cofins_st,
            'aliquotaCofinsStReais': self.aliquota_cofins_st_reais,
            'valorCofinsSt': self.valor_cofins_st,
        }