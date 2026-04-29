from src import db


class NfeAcessoXmlModel(db.Model):
    __tablename__ = 'nfe_acesso_xml'

    id = db.Column(db.Integer, primary_key=True)
    cnpj = db.Column(db.String(14))
    cpf = db.Column(db.String(11))
    id_nfe_cabecalho = db.Column(db.Integer, db.ForeignKey('nfe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_cabecalho = data.get('idNfeCabecalho')
        self.cnpj = data.get('cnpj')
        self.cpf = data.get('cpf')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeCabecalho': self.id_nfe_cabecalho,
            'cnpj': self.cnpj,
            'cpf': self.cpf,
        }