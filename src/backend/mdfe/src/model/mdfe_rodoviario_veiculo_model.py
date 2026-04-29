from src import db
from src.model.mdfe_rodoviario_model import MdfeRodoviarioModel


class MdfeRodoviarioVeiculoModel(db.Model):
    __tablename__ = 'mdfe_rodoviario_veiculo'

    id = db.Column(db.Integer, primary_key=True)
    codigo_interno = db.Column(db.String(10))
    placa = db.Column(db.String(7))
    renavam = db.Column(db.String(11))
    tara = db.Column(db.Integer)
    capacidade_kg = db.Column(db.Integer)
    capacidade_m3 = db.Column(db.Integer)
    tipo_rodado = db.Column(db.String(2))
    tipo_carroceria = db.Column(db.String(2))
    uf_licenciamento = db.Column(db.String(2))
    proprietario_cpf = db.Column(db.String(11))
    proprietario_cnpj = db.Column(db.String(14))
    proprietario_rntrc = db.Column(db.String(8))
    proprietario_nome = db.Column(db.String(60))
    proprietario_ie = db.Column(db.String(2))
    proprietario_tipo = db.Column(db.Integer)
    id_mdfe_rodoviario = db.Column(db.Integer, db.ForeignKey('mdfe_rodoviario.id'))

    mdfe_rodoviario_model = db.relationship('MdfeRodoviarioModel', foreign_keys=[id_mdfe_rodoviario])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_mdfe_rodoviario = data.get('idMdfeRodoviario')
        self.codigo_interno = data.get('codigoInterno')
        self.placa = data.get('placa')
        self.renavam = data.get('renavam')
        self.tara = data.get('tara')
        self.capacidade_kg = data.get('capacidadeKg')
        self.capacidade_m3 = data.get('capacidadeM3')
        self.tipo_rodado = data.get('tipoRodado')
        self.tipo_carroceria = data.get('tipoCarroceria')
        self.uf_licenciamento = data.get('ufLicenciamento')
        self.proprietario_cpf = data.get('proprietarioCpf')
        self.proprietario_cnpj = data.get('proprietarioCnpj')
        self.proprietario_rntrc = data.get('proprietarioRntrc')
        self.proprietario_nome = data.get('proprietarioNome')
        self.proprietario_ie = data.get('proprietarioIe')
        self.proprietario_tipo = data.get('proprietarioTipo')

    def serialize(self):
        return {
            'id': self.id,
            'idMdfeRodoviario': self.id_mdfe_rodoviario,
            'codigoInterno': self.codigo_interno,
            'placa': self.placa,
            'renavam': self.renavam,
            'tara': self.tara,
            'capacidadeKg': self.capacidade_kg,
            'capacidadeM3': self.capacidade_m3,
            'tipoRodado': self.tipo_rodado,
            'tipoCarroceria': self.tipo_carroceria,
            'ufLicenciamento': self.uf_licenciamento,
            'proprietarioCpf': self.proprietario_cpf,
            'proprietarioCnpj': self.proprietario_cnpj,
            'proprietarioRntrc': self.proprietario_rntrc,
            'proprietarioNome': self.proprietario_nome,
            'proprietarioIe': self.proprietario_ie,
            'proprietarioTipo': self.proprietario_tipo,
            'mdfeRodoviarioModel': self.mdfe_rodoviario_model.serialize() if self.mdfe_rodoviario_model else None,
        }