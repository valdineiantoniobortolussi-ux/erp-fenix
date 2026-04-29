from src import db


class PcpInstrucaoModel(db.Model):
    __tablename__ = 'pcp_instrucao'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(3))
    descricao = db.Column(db.String(100))


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