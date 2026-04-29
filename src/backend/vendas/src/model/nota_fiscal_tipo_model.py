from src import db
from src.model.nota_fiscal_modelo_model import NotaFiscalModeloModel


class NotaFiscalTipoModel(db.Model):
    __tablename__ = 'nota_fiscal_tipo'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(50))
    descricao = db.Column(db.Text)
    serie = db.Column(db.String(3))
    serie_scan = db.Column(db.String(3))
    ultimo_numero = db.Column(db.Integer)
    id_nota_fiscal_modelo = db.Column(db.Integer, db.ForeignKey('nota_fiscal_modelo.id'))

    nota_fiscal_modelo_model = db.relationship('NotaFiscalModeloModel', foreign_keys=[id_nota_fiscal_modelo])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_nota_fiscal_modelo = data.get('idNotaFiscalModelo')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')
        self.serie = data.get('serie')
        self.serie_scan = data.get('serieScan')
        self.ultimo_numero = data.get('ultimoNumero')

    def serialize(self):
        return {
            'id': self.id,
            'idNotaFiscalModelo': self.id_nota_fiscal_modelo,
            'nome': self.nome,
            'descricao': self.descricao,
            'serie': self.serie,
            'serieScan': self.serie_scan,
            'ultimoNumero': self.ultimo_numero,
            'notaFiscalModeloModel': self.nota_fiscal_modelo_model.serialize() if self.nota_fiscal_modelo_model else None,
        }