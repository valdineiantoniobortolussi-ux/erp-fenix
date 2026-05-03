from src import db
from src.model.wms_rua_model import WmsRuaModel


class WmsEstanteModel(db.Model):
    __tablename__ = 'wms_estante'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(10))
    quantidade_caixa = db.Column(db.Integer)
    id_wms_rua = db.Column(db.Integer, db.ForeignKey('wms_rua.id'))

    wms_rua_model = db.relationship('WmsRuaModel', foreign_keys=[id_wms_rua])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_wms_rua = data.get('idWmsRua')
        self.codigo = data.get('codigo')
        self.quantidade_caixa = data.get('quantidadeCaixa')

    def serialize(self):
        return {
            'id': self.id,
            'idWmsRua': self.id_wms_rua,
            'codigo': self.codigo,
            'quantidadeCaixa': self.quantidade_caixa,
            'wmsRuaModel': self.wms_rua_model.serialize() if self.wms_rua_model else None,
        }