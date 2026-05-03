from src import db
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel
from src.model.inventario_ajuste_det_model import InventarioAjusteDetModel


class InventarioAjusteCabModel(db.Model):
    __tablename__ = 'inventario_ajuste_cab'

    id = db.Column(db.Integer, primary_key=True)
    data_ajuste = db.Column(db.DateTime)
    tipo = db.Column(db.String(1))
    taxa = db.Column(db.Float)
    justificativa = db.Column(db.Text)
    id_view_pessoa_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_view_pessoa_colaborador])
    inventario_ajuste_det_model_list = db.relationship('InventarioAjusteDetModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.id_view_pessoa_colaborador = data.get('idViewPessoaColaborador')
        self.data_ajuste = data.get('dataAjuste')
        self.tipo = data.get('tipo')
        self.taxa = data.get('taxa')
        self.justificativa = data.get('justificativa')

    def serialize(self):
        return {
            'id': self.id,
            'idViewPessoaColaborador': self.id_view_pessoa_colaborador,
            'dataAjuste': self.data_ajuste.isoformat(),
            'tipo': self.tipo,
            'taxa': self.taxa,
            'justificativa': self.justificativa,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
            'inventarioAjusteDetModelList': [inventario_ajuste_det_model.serialize() for inventario_ajuste_det_model in self.inventario_ajuste_det_model_list],
        }