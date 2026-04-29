from src import db


class MdfeInformacaoSeguroModel(db.Model):
    __tablename__ = 'mdfe_informacao_seguro'

    id = db.Column(db.Integer, primary_key=True)
    responsavel = db.Column(db.Integer)
    cnpj_cpf = db.Column(db.String(14))
    seguradora = db.Column(db.String(11))
    cnpj_seguradora = db.Column(db.String(14))
    apolice = db.Column(db.String(20))
    averbacao = db.Column(db.String(40))
    id_mdfe_cabecalho = db.Column(db.Integer, db.ForeignKey('mdfe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_mdfe_cabecalho = data.get('idMdfeCabecalho')
        self.responsavel = data.get('responsavel')
        self.cnpj_cpf = data.get('cnpjCpf')
        self.seguradora = data.get('seguradora')
        self.cnpj_seguradora = data.get('cnpjSeguradora')
        self.apolice = data.get('apolice')
        self.averbacao = data.get('averbacao')

    def serialize(self):
        return {
            'id': self.id,
            'idMdfeCabecalho': self.id_mdfe_cabecalho,
            'responsavel': self.responsavel,
            'cnpjCpf': self.cnpj_cpf,
            'seguradora': self.seguradora,
            'cnpjSeguradora': self.cnpj_seguradora,
            'apolice': self.apolice,
            'averbacao': self.averbacao,
        }