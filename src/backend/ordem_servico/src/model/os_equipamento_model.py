from src import db


class OsEquipamentoModel(db.Model):
    __tablename__ = 'os_equipamento'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    descricao = db.Column(db.Text)


    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'descricao': self.descricao,
        }