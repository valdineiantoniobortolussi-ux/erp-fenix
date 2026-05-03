from src import db


class BpeViagemModel(db.Model):
    __tablename__ = 'bpe_viagem'

    id = db.Column(db.Integer, primary_key=True)
    codigo_percurso = db.Column(db.String(20))
    descricao_percurso = db.Column(db.String(100))
    tipo_viagem = db.Column(db.String(1))
    tipo_servico = db.Column(db.String(1))
    tipo_acomodacao = db.Column(db.String(1))
    tipo_trecho = db.Column(db.String(1))
    data_hora_viagem = db.Column(db.DateTime)
    data_hora_conexao = db.Column(db.DateTime)
    prefixo_linha = db.Column(db.String(20))
    poltrona = db.Column(db.String(3))
    plataforma = db.Column(db.String(10))
    id_bpe_cabecalho = db.Column(db.Integer, db.ForeignKey('bpe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_bpe_cabecalho = data.get('idBpeCabecalho')
        self.codigo_percurso = data.get('codigoPercurso')
        self.descricao_percurso = data.get('descricaoPercurso')
        self.tipo_viagem = data.get('tipoViagem')
        self.tipo_servico = data.get('tipoServico')
        self.tipo_acomodacao = data.get('tipoAcomodacao')
        self.tipo_trecho = data.get('tipoTrecho')
        self.data_hora_viagem = data.get('dataHoraViagem')
        self.data_hora_conexao = data.get('dataHoraConexao')
        self.prefixo_linha = data.get('prefixoLinha')
        self.poltrona = data.get('poltrona')
        self.plataforma = data.get('plataforma')

    def serialize(self):
        return {
            'id': self.id,
            'idBpeCabecalho': self.id_bpe_cabecalho,
            'codigoPercurso': self.codigo_percurso,
            'descricaoPercurso': self.descricao_percurso,
            'tipoViagem': self.tipo_viagem,
            'tipoServico': self.tipo_servico,
            'tipoAcomodacao': self.tipo_acomodacao,
            'tipoTrecho': self.tipo_trecho,
            'dataHoraViagem': self.data_hora_viagem.isoformat(),
            'dataHoraConexao': self.data_hora_conexao.isoformat(),
            'prefixoLinha': self.prefixo_linha,
            'poltrona': self.poltrona,
            'plataforma': self.plataforma,
        }