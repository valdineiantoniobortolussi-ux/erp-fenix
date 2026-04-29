from src import db


class EsocialMotivoDesligamentoModel(db.Model):
    __tablename__ = 'esocial_motivo_desligamento'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(2))
    descricao = db.Column(db.Text)


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'descricao': self.descricao,
        }