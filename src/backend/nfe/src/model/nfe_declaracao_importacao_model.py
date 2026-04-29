from src import db


class NfeDeclaracaoImportacaoModel(db.Model):
    __tablename__ = 'nfe_declaracao_importacao'

    id = db.Column(db.Integer, primary_key=True)
    numero_documento = db.Column(db.String(12))
    data_registro = db.Column(db.DateTime)
    local_desembaraco = db.Column(db.String(60))
    uf_desembaraco = db.Column(db.String(2))
    data_desembaraco = db.Column(db.DateTime)
    via_transporte = db.Column(db.String(1))
    valor_afrmm = db.Column(db.Float)
    forma_intermediacao = db.Column(db.String(1))
    cnpj = db.Column(db.String(14))
    uf_terceiro = db.Column(db.String(2))
    codigo_exportador = db.Column(db.String(60))
    id_nfe_detalhe = db.Column(db.Integer, db.ForeignKey('nfe_detalhe.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_detalhe = data.get('idNfeDetalhe')
        self.numero_documento = data.get('numeroDocumento')
        self.data_registro = data.get('dataRegistro')
        self.local_desembaraco = data.get('localDesembaraco')
        self.uf_desembaraco = data.get('ufDesembaraco')
        self.data_desembaraco = data.get('dataDesembaraco')
        self.via_transporte = data.get('viaTransporte')
        self.valor_afrmm = data.get('valorAfrmm')
        self.forma_intermediacao = data.get('formaIntermediacao')
        self.cnpj = data.get('cnpj')
        self.uf_terceiro = data.get('ufTerceiro')
        self.codigo_exportador = data.get('codigoExportador')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeDetalhe': self.id_nfe_detalhe,
            'numeroDocumento': self.numero_documento,
            'dataRegistro': self.data_registro.isoformat(),
            'localDesembaraco': self.local_desembaraco,
            'ufDesembaraco': self.uf_desembaraco,
            'dataDesembaraco': self.data_desembaraco.isoformat(),
            'viaTransporte': self.via_transporte,
            'valorAfrmm': self.valor_afrmm,
            'formaIntermediacao': self.forma_intermediacao,
            'cnpj': self.cnpj,
            'ufTerceiro': self.uf_terceiro,
            'codigoExportador': self.codigo_exportador,
        }