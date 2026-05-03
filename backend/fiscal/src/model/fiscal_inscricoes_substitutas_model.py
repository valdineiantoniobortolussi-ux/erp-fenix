from src import db


class FiscalInscricoesSubstitutasModel(db.Model):
    __tablename__ = 'fiscal_inscricoes_substitutas'

    id = db.Column(db.Integer, primary_key=True)
    uf = db.Column(db.String(2))
    inscricao_estadual = db.Column(db.String(30))
    pmpf = db.Column(db.String(1))
    id_fiscal_parametros = db.Column(db.Integer, db.ForeignKey('fiscal_parametro.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_fiscal_parametros = data.get('idFiscalParametros')
        self.uf = data.get('uf')
        self.inscricao_estadual = data.get('inscricaoEstadual')
        self.pmpf = data.get('pmpf')

    def serialize(self):
        return {
            'id': self.id,
            'idFiscalParametros': self.id_fiscal_parametros,
            'uf': self.uf,
            'inscricaoEstadual': self.inscricao_estadual,
            'pmpf': self.pmpf,
        }