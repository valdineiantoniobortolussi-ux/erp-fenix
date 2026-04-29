from src import db


class NfeDetalheImpostoIiModel(db.Model):
    __tablename__ = 'nfe_detalhe_imposto_ii'

    id = db.Column(db.Integer, primary_key=True)
    valor_bc_ii = db.Column(db.Float)
    valor_despesas_aduaneiras = db.Column(db.Float)
    valor_imposto_importacao = db.Column(db.Float)
    valor_iof = db.Column(db.Float)
    id_nfe_detalhe = db.Column(db.Integer, db.ForeignKey('nfe_detalhe.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_detalhe = data.get('idNfeDetalhe')
        self.valor_bc_ii = data.get('valorBcIi')
        self.valor_despesas_aduaneiras = data.get('valorDespesasAduaneiras')
        self.valor_imposto_importacao = data.get('valorImpostoImportacao')
        self.valor_iof = data.get('valorIof')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeDetalhe': self.id_nfe_detalhe,
            'valorBcIi': self.valor_bc_ii,
            'valorDespesasAduaneiras': self.valor_despesas_aduaneiras,
            'valorImpostoImportacao': self.valor_imposto_importacao,
            'valorIof': self.valor_iof,
        }