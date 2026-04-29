from src import db


class FolhaPppAtividadeModel(db.Model):
    __tablename__ = 'folha_ppp_atividade'

    id = db.Column(db.Integer, primary_key=True)
    data_inicio = db.Column(db.DateTime)
    data_fim = db.Column(db.DateTime)
    descricao = db.Column(db.Text)
    id_folha_ppp = db.Column(db.Integer, db.ForeignKey('folha_ppp.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_folha_ppp = data.get('idFolhaPpp')
        self.data_inicio = data.get('dataInicio')
        self.data_fim = data.get('dataFim')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'idFolhaPpp': self.id_folha_ppp,
            'dataInicio': self.data_inicio.isoformat(),
            'dataFim': self.data_fim.isoformat(),
            'descricao': self.descricao,
        }