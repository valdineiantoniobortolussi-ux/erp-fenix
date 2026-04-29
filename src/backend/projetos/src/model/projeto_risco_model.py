from src import db


class ProjetoRiscoModel(db.Model):
    __tablename__ = 'projeto_risco'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    probabilidade = db.Column(db.Integer)
    impacto = db.Column(db.Integer)
    descricao = db.Column(db.Text)
    id_projeto_principal = db.Column(db.Integer, db.ForeignKey('projeto_principal.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_projeto_principal = data.get('idProjetoPrincipal')
        self.nome = data.get('nome')
        self.probabilidade = data.get('probabilidade')
        self.impacto = data.get('impacto')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'idProjetoPrincipal': self.id_projeto_principal,
            'nome': self.nome,
            'probabilidade': self.probabilidade,
            'impacto': self.impacto,
            'descricao': self.descricao,
        }