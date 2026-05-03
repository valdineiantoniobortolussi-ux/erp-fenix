from src import db


class CteAereoModel(db.Model):
    __tablename__ = 'cte_aereo'

    id = db.Column(db.Integer, primary_key=True)
    numero_minuta = db.Column(db.Integer)
    numero_conhecimento = db.Column(db.Integer)
    data_prevista_entrega = db.Column(db.DateTime)
    id_emissor = db.Column(db.String(20))
    id_interna_tomador = db.Column(db.String(14))
    tarifa_classe = db.Column(db.String(1))
    tarifa_codigo = db.Column(db.String(4))
    tarifa_valor = db.Column(db.Float)
    carga_dimensao = db.Column(db.String(14))
    carga_informacao_manuseio = db.Column(db.String(1))
    carga_especial = db.Column(db.String(3))
    id_cte_cabecalho = db.Column(db.Integer, db.ForeignKey('cte_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_cabecalho = data.get('idCteCabecalho')
        self.numero_minuta = data.get('numeroMinuta')
        self.numero_conhecimento = data.get('numeroConhecimento')
        self.data_prevista_entrega = data.get('dataPrevistaEntrega')
        self.id_emissor = data.get('idEmissor')
        self.id_interna_tomador = data.get('idInternaTomador')
        self.tarifa_classe = data.get('tarifaClasse')
        self.tarifa_codigo = data.get('tarifaCodigo')
        self.tarifa_valor = data.get('tarifaValor')
        self.carga_dimensao = data.get('cargaDimensao')
        self.carga_informacao_manuseio = data.get('cargaInformacaoManuseio')
        self.carga_especial = data.get('cargaEspecial')

    def serialize(self):
        return {
            'id': self.id,
            'idCteCabecalho': self.id_cte_cabecalho,
            'numeroMinuta': self.numero_minuta,
            'numeroConhecimento': self.numero_conhecimento,
            'dataPrevistaEntrega': self.data_prevista_entrega.isoformat(),
            'idEmissor': self.id_emissor,
            'idInternaTomador': self.id_interna_tomador,
            'tarifaClasse': self.tarifa_classe,
            'tarifaCodigo': self.tarifa_codigo,
            'tarifaValor': self.tarifa_valor,
            'cargaDimensao': self.carga_dimensao,
            'cargaInformacaoManuseio': self.carga_informacao_manuseio,
            'cargaEspecial': self.carga_especial,
        }