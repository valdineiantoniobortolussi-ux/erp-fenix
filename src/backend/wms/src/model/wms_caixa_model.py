from src import db
from src.model.wms_armazenamento_model import WmsArmazenamentoModel
from src.model.wms_estante_model import WmsEstanteModel


class WmsCaixaModel(db.Model):
    __tablename__ = 'wms_caixa'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(10))
    altura = db.Column(db.Integer)
    largura = db.Column(db.Integer)
    profundidade = db.Column(db.Integer)
    id_wms_estante = db.Column(db.Integer, db.ForeignKey('wms_estante.id'))

    wms_armazenamento_model_list = db.relationship('WmsArmazenamentoModel', lazy='dynamic')
    wms_estante_model = db.relationship('WmsEstanteModel', foreign_keys=[id_wms_estante])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_wms_estante = data.get('idWmsEstante')
        self.codigo = data.get('codigo')
        self.altura = data.get('altura')
        self.largura = data.get('largura')
        self.profundidade = data.get('profundidade')

    def serialize(self):
        return {
            'id': self.id,
            'idWmsEstante': self.id_wms_estante,
            'codigo': self.codigo,
            'altura': self.altura,
            'largura': self.largura,
            'profundidade': self.profundidade,
            'wmsArmazenamentoModelList': [wms_armazenamento_model.serialize() for wms_armazenamento_model in self.wms_armazenamento_model_list],
            'wmsEstanteModel': self.wms_estante_model.serialize() if self.wms_estante_model else None,
        }