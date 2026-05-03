from src import db


class NfeItemRastreadoModel(db.Model):
    __tablename__ = 'nfe_item_rastreado'

    id = db.Column(db.Integer, primary_key=True)
    numero_lote = db.Column(db.String(20))
    quantidade_itens = db.Column(db.Float)
    data_fabricacao = db.Column(db.DateTime)
    data_validade = db.Column(db.DateTime)
    codigo_agregacao = db.Column(db.String(20))
    id_nfe_detalhe = db.Column(db.Integer, db.ForeignKey('nfe_detalhe.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_detalhe = data.get('idNfeDetalhe')
        self.numero_lote = data.get('numeroLote')
        self.quantidade_itens = data.get('quantidadeItens')
        self.data_fabricacao = data.get('dataFabricacao')
        self.data_validade = data.get('dataValidade')
        self.codigo_agregacao = data.get('codigoAgregacao')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeDetalhe': self.id_nfe_detalhe,
            'numeroLote': self.numero_lote,
            'quantidadeItens': self.quantidade_itens,
            'dataFabricacao': self.data_fabricacao.isoformat(),
            'dataValidade': self.data_validade.isoformat(),
            'codigoAgregacao': self.codigo_agregacao,
        }