from src import db


class PapelFuncaoModel(db.Model):
    __tablename__ = 'papel_funcao'

    id = db.Column(db.Integer, primary_key=True)
    habilitado = db.Column(db.String(1))
    pode_inserir = db.Column(db.String(1))
    pode_alterar = db.Column(db.String(1))
    pode_excluir = db.Column(db.String(1))
    id_papel = db.Column(db.Integer, db.ForeignKey('papel.id'))
    id_funcao = db.Column(db.Integer, db.ForeignKey('funcao.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_papel = data.get('idPapel')
        self.id_funcao = data.get('idFuncao')
        self.habilitado = data.get('habilitado')
        self.pode_inserir = data.get('podeInserir')
        self.pode_alterar = data.get('podeAlterar')
        self.pode_excluir = data.get('podeExcluir')

    def serialize(self):
        return {
            'id': self.id,
            'idPapel': self.id_papel,
            'idFuncao': self.id_funcao,
            'habilitado': self.habilitado,
            'podeInserir': self.pode_inserir,
            'podeAlterar': self.pode_alterar,
            'podeExcluir': self.pode_excluir,
        }