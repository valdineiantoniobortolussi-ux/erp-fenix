from src import db
from src.model.view_pessoa_transportadora_model import ViewPessoaTransportadoraModel


class VendaFreteModel(db.Model):
    __tablename__ = 'venda_frete'

    id = db.Column(db.Integer, primary_key=True)
    responsavel = db.Column(db.String(1))
    conhecimento = db.Column(db.Integer)
    placa = db.Column(db.String(7))
    uf_placa = db.Column(db.String(2))
    selo_fiscal = db.Column(db.Integer)
    quantidade_volume = db.Column(db.Float)
    marca_volume = db.Column(db.String(50))
    especie_volume = db.Column(db.String(20))
    peso_bruto = db.Column(db.Float)
    peso_liquido = db.Column(db.Float)
    id_venda_cabecalho = db.Column(db.Integer, db.ForeignKey('venda_cabecalho.id'))
    id_transportadora = db.Column(db.Integer, db.ForeignKey('view_pessoa_transportadora.id'))

    view_pessoa_transportadora_model = db.relationship('ViewPessoaTransportadoraModel', foreign_keys=[id_transportadora])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_venda_cabecalho = data.get('idVendaCabecalho')
        self.id_transportadora = data.get('idTransportadora')
        self.responsavel = data.get('responsavel')
        self.conhecimento = data.get('conhecimento')
        self.placa = data.get('placa')
        self.uf_placa = data.get('ufPlaca')
        self.selo_fiscal = data.get('seloFiscal')
        self.quantidade_volume = data.get('quantidadeVolume')
        self.marca_volume = data.get('marcaVolume')
        self.especie_volume = data.get('especieVolume')
        self.peso_bruto = data.get('pesoBruto')
        self.peso_liquido = data.get('pesoLiquido')

    def serialize(self):
        return {
            'id': self.id,
            'idVendaCabecalho': self.id_venda_cabecalho,
            'idTransportadora': self.id_transportadora,
            'responsavel': self.responsavel,
            'conhecimento': self.conhecimento,
            'placa': self.placa,
            'ufPlaca': self.uf_placa,
            'seloFiscal': self.selo_fiscal,
            'quantidadeVolume': self.quantidade_volume,
            'marcaVolume': self.marca_volume,
            'especieVolume': self.especie_volume,
            'pesoBruto': self.peso_bruto,
            'pesoLiquido': self.peso_liquido,
            'viewPessoaTransportadoraModel': self.view_pessoa_transportadora_model.serialize() if self.view_pessoa_transportadora_model else None,
        }