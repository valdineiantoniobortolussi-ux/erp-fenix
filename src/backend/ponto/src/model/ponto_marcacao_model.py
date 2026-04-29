from src import db
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel
from src.model.ponto_relogio_model import PontoRelogioModel


class PontoMarcacaoModel(db.Model):
    __tablename__ = 'ponto_marcacao'

    id = db.Column(db.Integer, primary_key=True)
    nsr = db.Column(db.Integer)
    data_marcacao = db.Column(db.DateTime)
    hora_marcacao = db.Column(db.String(8))
    tipo_marcacao = db.Column(db.String(1))
    tipo_registro = db.Column(db.String(1))
    par_entrada_saida = db.Column(db.String(2))
    justificativa = db.Column(db.String(100))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))
    id_ponto_relogio = db.Column(db.Integer, db.ForeignKey('ponto_relogio.id'))

    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])
    ponto_relogio_model = db.relationship('PontoRelogioModel', foreign_keys=[id_ponto_relogio])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_ponto_relogio = data.get('idPontoRelogio')
        self.id_colaborador = data.get('idColaborador')
        self.nsr = data.get('nsr')
        self.data_marcacao = data.get('dataMarcacao')
        self.hora_marcacao = data.get('horaMarcacao')
        self.tipo_marcacao = data.get('tipoMarcacao')
        self.tipo_registro = data.get('tipoRegistro')
        self.par_entrada_saida = data.get('parEntradaSaida')
        self.justificativa = data.get('justificativa')

    def serialize(self):
        return {
            'id': self.id,
            'idPontoRelogio': self.id_ponto_relogio,
            'idColaborador': self.id_colaborador,
            'nsr': self.nsr,
            'dataMarcacao': self.data_marcacao.isoformat(),
            'horaMarcacao': self.hora_marcacao,
            'tipoMarcacao': self.tipo_marcacao,
            'tipoRegistro': self.tipo_registro,
            'parEntradaSaida': self.par_entrada_saida,
            'justificativa': self.justificativa,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
            'pontoRelogioModel': self.ponto_relogio_model.serialize() if self.ponto_relogio_model else None,
        }