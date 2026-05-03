from src import db


class BpePassagemModel(db.Model):
    __tablename__ = 'bpe_passagem'

    id = db.Column(db.Integer, primary_key=True)
    codigo_localidade_origem = db.Column(db.String(7))
    descricao_localidade_origem = db.Column(db.String(60))
    codigo_localidade_destino = db.Column(db.String(7))
    descricao_localidade_destino = db.Column(db.String(60))
    data_hora_embarque = db.Column(db.DateTime)
    data_hora_validade = db.Column(db.DateTime)
    id_bpe_cabecalho = db.Column(db.Integer, db.ForeignKey('bpe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_bpe_cabecalho = data.get('idBpeCabecalho')
        self.codigo_localidade_origem = data.get('codigoLocalidadeOrigem')
        self.descricao_localidade_origem = data.get('descricaoLocalidadeOrigem')
        self.codigo_localidade_destino = data.get('codigoLocalidadeDestino')
        self.descricao_localidade_destino = data.get('descricaoLocalidadeDestino')
        self.data_hora_embarque = data.get('dataHoraEmbarque')
        self.data_hora_validade = data.get('dataHoraValidade')

    def serialize(self):
        return {
            'id': self.id,
            'idBpeCabecalho': self.id_bpe_cabecalho,
            'codigoLocalidadeOrigem': self.codigo_localidade_origem,
            'descricaoLocalidadeOrigem': self.descricao_localidade_origem,
            'codigoLocalidadeDestino': self.codigo_localidade_destino,
            'descricaoLocalidadeDestino': self.descricao_localidade_destino,
            'dataHoraEmbarque': self.data_hora_embarque.isoformat(),
            'dataHoraValidade': self.data_hora_validade.isoformat(),
        }