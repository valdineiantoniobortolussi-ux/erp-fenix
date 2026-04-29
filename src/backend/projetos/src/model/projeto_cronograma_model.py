from src import db


class ProjetoCronogramaModel(db.Model):
    __tablename__ = 'projeto_cronograma'

    id = db.Column(db.Integer, primary_key=True)
    tarefa = db.Column(db.String(100))
    data_tarefa = db.Column(db.DateTime)
    descricao = db.Column(db.Text)
    id_projeto_principal = db.Column(db.Integer, db.ForeignKey('projeto_principal.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_projeto_principal = data.get('idProjetoPrincipal')
        self.tarefa = data.get('tarefa')
        self.data_tarefa = data.get('dataTarefa')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'idProjetoPrincipal': self.id_projeto_principal,
            'tarefa': self.tarefa,
            'dataTarefa': self.data_tarefa.isoformat(),
            'descricao': self.descricao,
        }