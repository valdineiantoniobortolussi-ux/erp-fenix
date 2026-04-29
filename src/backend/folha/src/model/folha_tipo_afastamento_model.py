from src import db


class FolhaTipoAfastamentoModel(db.Model):
    __tablename__ = 'folha_tipo_afastamento'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(3))
    nome = db.Column(db.String(100))
    codigo_esocial = db.Column(db.String(2))
    descricao = db.Column(db.Text)


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.nome = data.get('nome')
        self.codigo_esocial = data.get('codigoEsocial')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'nome': self.nome,
            'codigoEsocial': self.codigo_esocial,
            'descricao': self.descricao,
        }