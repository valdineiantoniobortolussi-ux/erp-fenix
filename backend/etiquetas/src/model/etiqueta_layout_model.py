from src import db
from src.model.etiqueta_template_model import EtiquetaTemplateModel
from src.model.etiqueta_formato_papel_model import EtiquetaFormatoPapelModel


class EtiquetaLayoutModel(db.Model):
    __tablename__ = 'etiqueta_layout'

    id = db.Column(db.Integer, primary_key=True)
    codigo_fabricante = db.Column(db.String(50))
    quantidade = db.Column(db.Integer)
    quantidade_horizontal = db.Column(db.Integer)
    quantidade_vertical = db.Column(db.Integer)
    margem_superior = db.Column(db.Integer)
    margem_inferior = db.Column(db.Integer)
    margem_esquerda = db.Column(db.Integer)
    margem_direita = db.Column(db.Integer)
    espacamento_horizontal = db.Column(db.Integer)
    espacamento_vertical = db.Column(db.Integer)
    id_formato_papel = db.Column(db.Integer, db.ForeignKey('etiqueta_formato_papel.id'))

    etiqueta_template_model_list = db.relationship('EtiquetaTemplateModel', lazy='dynamic')
    etiqueta_formato_papel_model = db.relationship('EtiquetaFormatoPapelModel', foreign_keys=[id_formato_papel])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_formato_papel = data.get('idFormatoPapel')
        self.codigo_fabricante = data.get('codigoFabricante')
        self.quantidade = data.get('quantidade')
        self.quantidade_horizontal = data.get('quantidadeHorizontal')
        self.quantidade_vertical = data.get('quantidadeVertical')
        self.margem_superior = data.get('margemSuperior')
        self.margem_inferior = data.get('margemInferior')
        self.margem_esquerda = data.get('margemEsquerda')
        self.margem_direita = data.get('margemDireita')
        self.espacamento_horizontal = data.get('espacamentoHorizontal')
        self.espacamento_vertical = data.get('espacamentoVertical')

    def serialize(self):
        return {
            'id': self.id,
            'idFormatoPapel': self.id_formato_papel,
            'codigoFabricante': self.codigo_fabricante,
            'quantidade': self.quantidade,
            'quantidadeHorizontal': self.quantidade_horizontal,
            'quantidadeVertical': self.quantidade_vertical,
            'margemSuperior': self.margem_superior,
            'margemInferior': self.margem_inferior,
            'margemEsquerda': self.margem_esquerda,
            'margemDireita': self.margem_direita,
            'espacamentoHorizontal': self.espacamento_horizontal,
            'espacamentoVertical': self.espacamento_vertical,
            'etiquetaTemplateModelList': [etiqueta_template_model.serialize() for etiqueta_template_model in self.etiqueta_template_model_list],
            'etiquetaFormatoPapelModel': self.etiqueta_formato_papel_model.serialize() if self.etiqueta_formato_papel_model else None,
        }