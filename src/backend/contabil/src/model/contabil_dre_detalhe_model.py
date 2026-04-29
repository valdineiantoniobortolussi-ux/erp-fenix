from src import db


class ContabilDreDetalheModel(db.Model):
    __tablename__ = 'contabil_dre_detalhe'

    id = db.Column(db.Integer, primary_key=True)
    classificacao = db.Column(db.String(30))
    descricao = db.Column(db.String(100))
    forma_calculo = db.Column(db.String(1))
    sinal = db.Column(db.String(1))
    natureza = db.Column(db.String(1))
    valor = db.Column(db.Float)
    id_contabil_dre_cabecalho = db.Column(db.Integer, db.ForeignKey('contabil_dre_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_contabil_dre_cabecalho = data.get('idContabilDreCabecalho')
        self.classificacao = data.get('classificacao')
        self.descricao = data.get('descricao')
        self.forma_calculo = data.get('formaCalculo')
        self.sinal = data.get('sinal')
        self.natureza = data.get('natureza')
        self.valor = data.get('valor')

    def serialize(self):
        return {
            'id': self.id,
            'idContabilDreCabecalho': self.id_contabil_dre_cabecalho,
            'classificacao': self.classificacao,
            'descricao': self.descricao,
            'formaCalculo': self.forma_calculo,
            'sinal': self.sinal,
            'natureza': self.natureza,
            'valor': self.valor,
        }