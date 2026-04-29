from src import db


class ViewControleAcessoModel(db.Model):
    __tablename__ = 'view_controle_acesso'

    id = db.Column(db.Integer, primary_key=True)
    id_pessoa = db.Column(db.Integer)
    pessoa_nome = db.Column(db.String(450))
    id_colaborador = db.Column(db.Integer)
    id_usuario = db.Column(db.Integer)
    administrador = db.Column(db.String(3))
    id_papel = db.Column(db.Integer)
    papel_nome = db.Column(db.String(300))
    papel_descricao = db.Column(db.String(750))
    id_funcao = db.Column(db.Integer)
    funcao_nome = db.Column(db.String(300))
    funcao_descricao = db.Column(db.String(750))
    id_papel_funcao = db.Column(db.Integer)
    habilitado = db.Column(db.String(3))
    pode_inserir = db.Column(db.String(3))
    pode_alterar = db.Column(db.String(3))
    pode_excluir = db.Column(db.String(3))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_pessoa = data.get('idPessoa')
        self.pessoa_nome = data.get('pessoaNome')
        self.id_colaborador = data.get('idColaborador')
        self.id_usuario = data.get('idUsuario')
        self.administrador = data.get('administrador')
        self.id_papel = data.get('idPapel')
        self.papel_nome = data.get('papelNome')
        self.papel_descricao = data.get('papelDescricao')
        self.id_funcao = data.get('idFuncao')
        self.funcao_nome = data.get('funcaoNome')
        self.funcao_descricao = data.get('funcaoDescricao')
        self.id_papel_funcao = data.get('idPapelFuncao')
        self.habilitado = data.get('habilitado')
        self.pode_inserir = data.get('podeInserir')
        self.pode_alterar = data.get('podeAlterar')
        self.pode_excluir = data.get('podeExcluir')

    def serialize(self):
        return {
            'id': self.id,
            'idPessoa': self.id_pessoa,
            'pessoaNome': self.pessoa_nome,
            'idColaborador': self.id_colaborador,
            'idUsuario': self.id_usuario,
            'administrador': self.administrador,
            'idPapel': self.id_papel,
            'papelNome': self.papel_nome,
            'papelDescricao': self.papel_descricao,
            'idFuncao': self.id_funcao,
            'funcaoNome': self.funcao_nome,
            'funcaoDescricao': self.funcao_descricao,
            'idPapelFuncao': self.id_papel_funcao,
            'habilitado': self.habilitado,
            'podeInserir': self.pode_inserir,
            'podeAlterar': self.pode_alterar,
            'podeExcluir': self.pode_excluir,
        }