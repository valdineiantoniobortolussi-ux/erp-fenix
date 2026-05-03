from src import db


class FrotaVeiculoTipoModel(db.Model):
    __tablename__ = 'frota_veiculo_tipo'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(2))
    nome = db.Column(db.String(100))


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.nome = data.get('nome')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'nome': self.nome,
        }