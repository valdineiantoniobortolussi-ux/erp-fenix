from src import db
from src.model.cte_rodoviario_model import CteRodoviarioModel


class CteRodoviarioVeiculoModel(db.Model):
    __tablename__ = 'cte_rodoviario_veiculo'

    id = db.Column(db.Integer, primary_key=True)
    codigo_interno = db.Column(db.String(10))
    renavam = db.Column(db.String(11))
    placa = db.Column(db.String(7))
    tara = db.Column(db.Integer)
    capacidade_kg = db.Column(db.Integer)
    capacidade_m3 = db.Column(db.Integer)
    tipo_propriedade = db.Column(db.String(1))
    tipo_veiculo = db.Column(db.String(1))
    tipo_rodado = db.Column(db.String(2))
    tipo_carroceria = db.Column(db.String(2))
    uf = db.Column(db.String(2))
    proprietario_cpf = db.Column(db.String(11))
    proprietario_cnpj = db.Column(db.String(14))
    proprietario_rntrc = db.Column(db.String(8))
    proprietario_nome = db.Column(db.String(60))
    proprietario_ie = db.Column(db.String(14))
    proprietario_uf = db.Column(db.String(2))
    proprietario_tipo = db.Column(db.String(1))
    id_cte_rodoviario = db.Column(db.Integer, db.ForeignKey('cte_rodoviario.id'))

    cte_rodoviario_model = db.relationship('CteRodoviarioModel', foreign_keys=[id_cte_rodoviario])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_rodoviario = data.get('idCteRodoviario')
        self.codigo_interno = data.get('codigoInterno')
        self.renavam = data.get('renavam')
        self.placa = data.get('placa')
        self.tara = data.get('tara')
        self.capacidade_kg = data.get('capacidadeKg')
        self.capacidade_m3 = data.get('capacidadeM3')
        self.tipo_propriedade = data.get('tipoPropriedade')
        self.tipo_veiculo = data.get('tipoVeiculo')
        self.tipo_rodado = data.get('tipoRodado')
        self.tipo_carroceria = data.get('tipoCarroceria')
        self.uf = data.get('uf')
        self.proprietario_cpf = data.get('proprietarioCpf')
        self.proprietario_cnpj = data.get('proprietarioCnpj')
        self.proprietario_rntrc = data.get('proprietarioRntrc')
        self.proprietario_nome = data.get('proprietarioNome')
        self.proprietario_ie = data.get('proprietarioIe')
        self.proprietario_uf = data.get('proprietarioUf')
        self.proprietario_tipo = data.get('proprietarioTipo')

    def serialize(self):
        return {
            'id': self.id,
            'idCteRodoviario': self.id_cte_rodoviario,
            'codigoInterno': self.codigo_interno,
            'renavam': self.renavam,
            'placa': self.placa,
            'tara': self.tara,
            'capacidadeKg': self.capacidade_kg,
            'capacidadeM3': self.capacidade_m3,
            'tipoPropriedade': self.tipo_propriedade,
            'tipoVeiculo': self.tipo_veiculo,
            'tipoRodado': self.tipo_rodado,
            'tipoCarroceria': self.tipo_carroceria,
            'uf': self.uf,
            'proprietarioCpf': self.proprietario_cpf,
            'proprietarioCnpj': self.proprietario_cnpj,
            'proprietarioRntrc': self.proprietario_rntrc,
            'proprietarioNome': self.proprietario_nome,
            'proprietarioIe': self.proprietario_ie,
            'proprietarioUf': self.proprietario_uf,
            'proprietarioTipo': self.proprietario_tipo,
            'cteRodoviarioModel': self.cte_rodoviario_model.serialize() if self.cte_rodoviario_model else None,
        }