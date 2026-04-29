from src import db


class EtiquetaTemplateModel(db.Model):
    __tablename__ = 'etiqueta_template'

    id = db.Column(db.Integer, primary_key=True)
    tabela = db.Column(db.String(50))
    campo = db.Column(db.String(50))
    formato = db.Column(db.String(1))
    quantidade_repeticoes = db.Column(db.Integer)
    filtro = db.Column(db.String(100))
    id_etiqueta_layout = db.Column(db.Integer, db.ForeignKey('etiqueta_layout.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_etiqueta_layout = data.get('idEtiquetaLayout')
        self.tabela = data.get('tabela')
        self.campo = data.get('campo')
        self.formato = data.get('formato')
        self.quantidade_repeticoes = data.get('quantidadeRepeticoes')
        self.filtro = data.get('filtro')

    def serialize(self):
        return {
            'id': self.id,
            'idEtiquetaLayout': self.id_etiqueta_layout,
            'tabela': self.tabela,
            'campo': self.campo,
            'formato': self.formato,
            'quantidadeRepeticoes': self.quantidade_repeticoes,
            'filtro': self.filtro,
        }