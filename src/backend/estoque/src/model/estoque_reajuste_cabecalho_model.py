from src import db
from src.model.estoque_reajuste_detalhe_model import EstoqueReajusteDetalheModel
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel


class EstoqueReajusteCabecalhoModel(db.Model):
    __tablename__ = 'estoque_reajuste_cabecalho'

    id = db.Column(db.Integer, primary_key=True)
    data_reajuste = db.Column(db.DateTime)
    taxa = db.Column(db.Float)
    tipo_reajuste = db.Column(db.String(1))
    justificativa = db.Column(db.String(100))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    estoque_reajuste_detalhe_model_list = db.relationship('EstoqueReajusteDetalheModel', lazy='dynamic')
    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_colaborador = data.get('idColaborador')
        self.data_reajuste = data.get('dataReajuste')
        self.taxa = data.get('taxa')
        self.tipo_reajuste = data.get('tipoReajuste')
        self.justificativa = data.get('justificativa')

    def serialize(self):
        return {
            'id': self.id,
            'idColaborador': self.id_colaborador,
            'dataReajuste': self.data_reajuste.isoformat(),
            'taxa': self.taxa,
            'tipoReajuste': self.tipo_reajuste,
            'justificativa': self.justificativa,
            'estoqueReajusteDetalheModelList': [estoque_reajuste_detalhe_model.serialize() for estoque_reajuste_detalhe_model in self.estoque_reajuste_detalhe_model_list],
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
        }