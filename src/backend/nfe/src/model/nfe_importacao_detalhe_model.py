from src import db
from src.model.nfe_declaracao_importacao_model import NfeDeclaracaoImportacaoModel


class NfeImportacaoDetalheModel(db.Model):
    __tablename__ = 'nfe_importacao_detalhe'

    id = db.Column(db.Integer, primary_key=True)
    numero_adicao = db.Column(db.Integer)
    numero_sequencial = db.Column(db.Integer)
    codigo_fabricante_estrangeiro = db.Column(db.String(60))
    valor_desconto = db.Column(db.Float)
    drawback = db.Column(db.Integer)
    id_nfe_declaracao_importacao = db.Column(db.Integer, db.ForeignKey('nfe_declaracao_importacao.id'))

    nfe_declaracao_importacao_model = db.relationship('NfeDeclaracaoImportacaoModel', foreign_keys=[id_nfe_declaracao_importacao])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_declaracao_importacao = data.get('idNfeDeclaracaoImportacao')
        self.numero_adicao = data.get('numeroAdicao')
        self.numero_sequencial = data.get('numeroSequencial')
        self.codigo_fabricante_estrangeiro = data.get('codigoFabricanteEstrangeiro')
        self.valor_desconto = data.get('valorDesconto')
        self.drawback = data.get('drawback')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeDeclaracaoImportacao': self.id_nfe_declaracao_importacao,
            'numeroAdicao': self.numero_adicao,
            'numeroSequencial': self.numero_sequencial,
            'codigoFabricanteEstrangeiro': self.codigo_fabricante_estrangeiro,
            'valorDesconto': self.valor_desconto,
            'drawback': self.drawback,
            'nfeDeclaracaoImportacaoModel': self.nfe_declaracao_importacao_model.serialize() if self.nfe_declaracao_importacao_model else None,
        }