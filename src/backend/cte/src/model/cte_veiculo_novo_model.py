from src import db


class CteVeiculoNovoModel(db.Model):
    __tablename__ = 'cte_veiculo_novo'

    id = db.Column(db.Integer, primary_key=True)
    chassi = db.Column(db.String(17))
    cor = db.Column(db.String(4))
    descricao_cor = db.Column(db.String(40))
    codigo_marca_modelo = db.Column(db.String(6))
    valor_unitario = db.Column(db.Float)
    valor_frete = db.Column(db.Float)
    id_cte_cabecalho = db.Column(db.Integer, db.ForeignKey('cte_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_cabecalho = data.get('idCteCabecalho')
        self.chassi = data.get('chassi')
        self.cor = data.get('cor')
        self.descricao_cor = data.get('descricaoCor')
        self.codigo_marca_modelo = data.get('codigoMarcaModelo')
        self.valor_unitario = data.get('valorUnitario')
        self.valor_frete = data.get('valorFrete')

    def serialize(self):
        return {
            'id': self.id,
            'idCteCabecalho': self.id_cte_cabecalho,
            'chassi': self.chassi,
            'cor': self.cor,
            'descricaoCor': self.descricao_cor,
            'codigoMarcaModelo': self.codigo_marca_modelo,
            'valorUnitario': self.valor_unitario,
            'valorFrete': self.valor_frete,
        }