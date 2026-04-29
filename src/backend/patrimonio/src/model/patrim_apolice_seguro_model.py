from src import db
from src.model.seguradora_model import SeguradoraModel


class PatrimApoliceSeguroModel(db.Model):
    __tablename__ = 'patrim_apolice_seguro'

    id = db.Column(db.Integer, primary_key=True)
    numero = db.Column(db.String(20))
    data_contratacao = db.Column(db.DateTime)
    data_vencimento = db.Column(db.DateTime)
    valor_premio = db.Column(db.Float)
    valor_segurado = db.Column(db.Float)
    observacao = db.Column(db.Text)
    imagem = db.Column(db.Text)
    id_patrim_bem = db.Column(db.Integer, db.ForeignKey('patrim_bem.id'))
    id_seguradora = db.Column(db.Integer, db.ForeignKey('seguradora.id'))

    seguradora_model = db.relationship('SeguradoraModel', foreign_keys=[id_seguradora])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_patrim_bem = data.get('idPatrimBem')
        self.id_seguradora = data.get('idSeguradora')
        self.numero = data.get('numero')
        self.data_contratacao = data.get('dataContratacao')
        self.data_vencimento = data.get('dataVencimento')
        self.valor_premio = data.get('valorPremio')
        self.valor_segurado = data.get('valorSegurado')
        self.observacao = data.get('observacao')
        self.imagem = data.get('imagem')

    def serialize(self):
        return {
            'id': self.id,
            'idPatrimBem': self.id_patrim_bem,
            'idSeguradora': self.id_seguradora,
            'numero': self.numero,
            'dataContratacao': self.data_contratacao.isoformat(),
            'dataVencimento': self.data_vencimento.isoformat(),
            'valorPremio': self.valor_premio,
            'valorSegurado': self.valor_segurado,
            'observacao': self.observacao,
            'imagem': self.imagem,
            'seguradoraModel': self.seguradora_model.serialize() if self.seguradora_model else None,
        }