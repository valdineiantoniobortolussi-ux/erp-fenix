from src import db
from src.model.ged_tipo_documento_model import GedTipoDocumentoModel


class GedDocumentoDetalheModel(db.Model):
    __tablename__ = 'ged_documento_detalhe'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    descricao = db.Column(db.Text)
    palavras_chave = db.Column(db.String(250))
    pode_excluir = db.Column(db.String(1))
    pode_alterar = db.Column(db.String(1))
    assinado = db.Column(db.String(1))
    data_fim_vigencia = db.Column(db.DateTime)
    data_exclusao = db.Column(db.DateTime)
    id_ged_tipo_documento = db.Column(db.Integer, db.ForeignKey('ged_tipo_documento.id'))
    id_ged_documento_cabecalho = db.Column(db.Integer, db.ForeignKey('ged_documento_cabecalho.id'))

    ged_tipo_documento_model = db.relationship('GedTipoDocumentoModel', foreign_keys=[id_ged_tipo_documento])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_ged_documento_cabecalho = data.get('idGedDocumentoCabecalho')
        self.id_ged_tipo_documento = data.get('idGedTipoDocumento')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')
        self.palavras_chave = data.get('palavrasChave')
        self.pode_excluir = data.get('podeExcluir')
        self.pode_alterar = data.get('podeAlterar')
        self.assinado = data.get('assinado')
        self.data_fim_vigencia = data.get('dataFimVigencia')
        self.data_exclusao = data.get('dataExclusao')

    def serialize(self):
        return {
            'id': self.id,
            'idGedDocumentoCabecalho': self.id_ged_documento_cabecalho,
            'idGedTipoDocumento': self.id_ged_tipo_documento,
            'nome': self.nome,
            'descricao': self.descricao,
            'palavrasChave': self.palavras_chave,
            'podeExcluir': self.pode_excluir,
            'podeAlterar': self.pode_alterar,
            'assinado': self.assinado,
            'dataFimVigencia': self.data_fim_vigencia.isoformat(),
            'dataExclusao': self.data_exclusao.isoformat(),
            'gedTipoDocumentoModel': self.ged_tipo_documento_model.serialize() if self.ged_tipo_documento_model else None,
        }