from src import db


class FiscalTermoModel(db.Model):
    __tablename__ = 'fiscal_termo'

    id = db.Column(db.Integer, primary_key=True)
    abertura_encerramento = db.Column(db.String(1))
    numero = db.Column(db.Integer)
    pagina_inicial = db.Column(db.Integer)
    pagina_final = db.Column(db.Integer)
    numero_registro = db.Column(db.String(50))
    registrado = db.Column(db.String(100))
    data_despacho = db.Column(db.DateTime)
    data_abertura = db.Column(db.DateTime)
    data_encerramento = db.Column(db.DateTime)
    escrituracao_inicio = db.Column(db.DateTime)
    escrituracao_fim = db.Column(db.DateTime)
    texto = db.Column(db.Text)
    id_fiscal_livro = db.Column(db.Integer, db.ForeignKey('fiscal_livro.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_fiscal_livro = data.get('idFiscalLivro')
        self.abertura_encerramento = data.get('aberturaEncerramento')
        self.numero = data.get('numero')
        self.pagina_inicial = data.get('paginaInicial')
        self.pagina_final = data.get('paginaFinal')
        self.numero_registro = data.get('numeroRegistro')
        self.registrado = data.get('registrado')
        self.data_despacho = data.get('dataDespacho')
        self.data_abertura = data.get('dataAbertura')
        self.data_encerramento = data.get('dataEncerramento')
        self.escrituracao_inicio = data.get('escrituracaoInicio')
        self.escrituracao_fim = data.get('escrituracaoFim')
        self.texto = data.get('texto')

    def serialize(self):
        return {
            'id': self.id,
            'idFiscalLivro': self.id_fiscal_livro,
            'aberturaEncerramento': self.abertura_encerramento,
            'numero': self.numero,
            'paginaInicial': self.pagina_inicial,
            'paginaFinal': self.pagina_final,
            'numeroRegistro': self.numero_registro,
            'registrado': self.registrado,
            'dataDespacho': self.data_despacho.isoformat(),
            'dataAbertura': self.data_abertura.isoformat(),
            'dataEncerramento': self.data_encerramento.isoformat(),
            'escrituracaoInicio': self.escrituracao_inicio.isoformat(),
            'escrituracaoFim': self.escrituracao_fim.isoformat(),
            'texto': self.texto,
        }