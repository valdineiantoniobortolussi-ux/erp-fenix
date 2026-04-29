from src import db
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel
from src.model.operadora_plano_saude_model import OperadoraPlanoSaudeModel


class FolhaPlanoSaudeModel(db.Model):
    __tablename__ = 'folha_plano_saude'

    id = db.Column(db.Integer, primary_key=True)
    data_inicio = db.Column(db.DateTime)
    beneficiario = db.Column(db.String(1))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))
    id_operadora_plano_saude = db.Column(db.Integer, db.ForeignKey('operadora_plano_saude.id'))

    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])
    operadora_plano_saude_model = db.relationship('OperadoraPlanoSaudeModel', foreign_keys=[id_operadora_plano_saude])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_operadora_plano_saude = data.get('idOperadoraPlanoSaude')
        self.id_colaborador = data.get('idColaborador')
        self.data_inicio = data.get('dataInicio')
        self.beneficiario = data.get('beneficiario')

    def serialize(self):
        return {
            'id': self.id,
            'idOperadoraPlanoSaude': self.id_operadora_plano_saude,
            'idColaborador': self.id_colaborador,
            'dataInicio': self.data_inicio.isoformat(),
            'beneficiario': self.beneficiario,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
            'operadoraPlanoSaudeModel': self.operadora_plano_saude_model.serialize() if self.operadora_plano_saude_model else None,
        }