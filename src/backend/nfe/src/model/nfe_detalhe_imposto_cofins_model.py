from src import db


class NfeDetalheImpostoCofinsModel(db.Model):
    __tablename__ = 'nfe_detalhe_imposto_cofins'

    id = db.Column(db.Integer, primary_key=True)
    cst_cofins = db.Column(db.String(2))
    base_calculo_cofins = db.Column(db.Float)
    aliquota_cofins_percentual = db.Column(db.Float)
    quantidade_vendida = db.Column(db.Float)
    aliquota_cofins_reais = db.Column(db.Float)
    valor_cofins = db.Column(db.Float)
    id_nfe_detalhe = db.Column(db.Integer, db.ForeignKey('nfe_detalhe.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_detalhe = data.get('idNfeDetalhe')
        self.cst_cofins = data.get('cstCofins')
        self.base_calculo_cofins = data.get('baseCalculoCofins')
        self.aliquota_cofins_percentual = data.get('aliquotaCofinsPercentual')
        self.quantidade_vendida = data.get('quantidadeVendida')
        self.aliquota_cofins_reais = data.get('aliquotaCofinsReais')
        self.valor_cofins = data.get('valorCofins')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeDetalhe': self.id_nfe_detalhe,
            'cstCofins': self.cst_cofins,
            'baseCalculoCofins': self.base_calculo_cofins,
            'aliquotaCofinsPercentual': self.aliquota_cofins_percentual,
            'quantidadeVendida': self.quantidade_vendida,
            'aliquotaCofinsReais': self.aliquota_cofins_reais,
            'valorCofins': self.valor_cofins,
        }