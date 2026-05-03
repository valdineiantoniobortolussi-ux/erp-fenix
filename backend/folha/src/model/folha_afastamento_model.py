from src import db
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel
from src.model.folha_tipo_afastamento_model import FolhaTipoAfastamentoModel


class FolhaAfastamentoModel(db.Model):
    __tablename__ = 'folha_afastamento'

    id = db.Column(db.Integer, primary_key=True)
    data_inicio = db.Column(db.DateTime)
    data_fim = db.Column(db.DateTime)
    dias_afastado = db.Column(db.Integer)
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))
    id_folha_tipo_afastamento = db.Column(db.Integer, db.ForeignKey('folha_tipo_afastamento.id'))

    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])
    folha_tipo_afastamento_model = db.relationship('FolhaTipoAfastamentoModel', foreign_keys=[id_folha_tipo_afastamento])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_colaborador = data.get('idColaborador')
        self.id_folha_tipo_afastamento = data.get('idFolhaTipoAfastamento')
        self.data_inicio = data.get('dataInicio')
        self.data_fim = data.get('dataFim')
        self.dias_afastado = data.get('diasAfastado')

    def serialize(self):
        return {
            'id': self.id,
            'idColaborador': self.id_colaborador,
            'idFolhaTipoAfastamento': self.id_folha_tipo_afastamento,
            'dataInicio': self.data_inicio.isoformat(),
            'dataFim': self.data_fim.isoformat(),
            'diasAfastado': self.dias_afastado,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
            'folhaTipoAfastamentoModel': self.folha_tipo_afastamento_model.serialize() if self.folha_tipo_afastamento_model else None,
        }