from src import db
from src.model.gondola_armazenamento_model import GondolaArmazenamentoModel
from src.model.gondola_estante_model import GondolaEstanteModel


class GondolaCaixaModel(db.Model):
    __tablename__ = 'gondola_caixa'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(10))
    altura = db.Column(db.Integer)
    largura = db.Column(db.Integer)
    profundidade = db.Column(db.Integer)
    id_gondola_estante = db.Column(db.Integer, db.ForeignKey('gondola_estante.id'))

    gondola_armazenamento_model_list = db.relationship('GondolaArmazenamentoModel', lazy='dynamic')
    gondola_estante_model = db.relationship('GondolaEstanteModel', foreign_keys=[id_gondola_estante])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_gondola_estante = data.get('idGondolaEstante')
        self.codigo = data.get('codigo')
        self.altura = data.get('altura')
        self.largura = data.get('largura')
        self.profundidade = data.get('profundidade')

    def serialize(self):
        return {
            'id': self.id,
            'idGondolaEstante': self.id_gondola_estante,
            'codigo': self.codigo,
            'altura': self.altura,
            'largura': self.largura,
            'profundidade': self.profundidade,
            'gondolaArmazenamentoModelList': [gondola_armazenamento_model.serialize() for gondola_armazenamento_model in self.gondola_armazenamento_model_list],
            'gondolaEstanteModel': self.gondola_estante_model.serialize() if self.gondola_estante_model else None,
        }