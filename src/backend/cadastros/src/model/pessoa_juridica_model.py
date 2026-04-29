from src import db


class PessoaJuridicaModel(db.Model):
    __tablename__ = 'pessoa_juridica'

    id = db.Column(db.Integer, primary_key=True)
    cnpj = db.Column(db.String(14))
    nome_fantasia = db.Column(db.String(100))
    inscricao_estadual = db.Column(db.String(45))
    inscricao_municipal = db.Column(db.String(45))
    data_constituicao = db.Column(db.DateTime)
    tipo_regime = db.Column(db.String(1))
    crt = db.Column(db.String(1))
    id_pessoa = db.Column(db.Integer, db.ForeignKey('pessoa.id'), unique=True)


    def mapping(self, data):
        self.id = data.get('id')
        self.id_pessoa = data.get('idPessoa')
        self.cnpj = data.get('cnpj')
        self.nome_fantasia = data.get('nomeFantasia')
        self.inscricao_estadual = data.get('inscricaoEstadual')
        self.inscricao_municipal = data.get('inscricaoMunicipal')
        self.data_constituicao = data.get('dataConstituicao')
        self.tipo_regime = data.get('tipoRegime')
        self.crt = data.get('crt')

    def serialize(self):
        return {
            'id': self.id,
            'idPessoa': self.id_pessoa,
            'cnpj': self.cnpj,
            'nomeFantasia': self.nome_fantasia,
            'inscricaoEstadual': self.inscricao_estadual,
            'inscricaoMunicipal': self.inscricao_municipal,
            'dataConstituicao': self.data_constituicao.isoformat(),
            'tipoRegime': self.tipo_regime,
            'crt': self.crt,
        }