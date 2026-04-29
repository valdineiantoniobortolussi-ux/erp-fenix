from src import db
from src.model.ged_documento_detalhe_model import GedDocumentoDetalheModel
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel


class GedVersaoDocumentoModel(db.Model):
    __tablename__ = 'ged_versao_documento'

    id = db.Column(db.Integer, primary_key=True)
    acao = db.Column(db.String(1))
    versao = db.Column(db.Integer)
    data_versao = db.Column(db.DateTime)
    hora_versao = db.Column(db.String(8))
    hash_arquivo = db.Column(db.String(250))
    caminho = db.Column(db.String(250))
    id_ged_documento_detalhe = db.Column(db.Integer, db.ForeignKey('ged_documento_detalhe.id'))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    ged_documento_detalhe_model = db.relationship('GedDocumentoDetalheModel', foreign_keys=[id_ged_documento_detalhe])
    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_ged_documento_detalhe = data.get('idGedDocumentoDetalhe')
        self.id_colaborador = data.get('idColaborador')
        self.acao = data.get('acao')
        self.versao = data.get('versao')
        self.data_versao = data.get('dataVersao')
        self.hora_versao = data.get('horaVersao')
        self.hash_arquivo = data.get('hashArquivo')
        self.caminho = data.get('caminho')

    def serialize(self):
        return {
            'id': self.id,
            'idGedDocumentoDetalhe': self.id_ged_documento_detalhe,
            'idColaborador': self.id_colaborador,
            'acao': self.acao,
            'versao': self.versao,
            'dataVersao': self.data_versao.isoformat(),
            'horaVersao': self.hora_versao,
            'hashArquivo': self.hash_arquivo,
            'caminho': self.caminho,
            'gedDocumentoDetalheModel': self.ged_documento_detalhe_model.serialize() if self.ged_documento_detalhe_model else None,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
        }