from src import db


class NfseListaServicoModel(db.Model):
    __tablename__ = 'nfse_lista_servico'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(5))
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