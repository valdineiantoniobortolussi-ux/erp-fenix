from src import db


class NfeDetEspecificoVeiculoModel(db.Model):
    __tablename__ = 'nfe_det_especifico_veiculo'

    id = db.Column(db.Integer, primary_key=True)
    tipo_operacao = db.Column(db.String(1))
    chassi = db.Column(db.String(17))
    cor = db.Column(db.String(4))
    descricao_cor = db.Column(db.String(40))
    potencia_motor = db.Column(db.String(4))
    cilindradas = db.Column(db.String(4))
    peso_liquido = db.Column(db.String(9))
    peso_bruto = db.Column(db.String(9))
    numero_serie = db.Column(db.String(9))
    tipo_combustivel = db.Column(db.String(2))
    numero_motor = db.Column(db.String(21))
    capacidade_maxima_tracao = db.Column(db.String(9))
    distancia_eixos = db.Column(db.String(4))
    ano_modelo = db.Column(db.String(4))
    ano_fabricacao = db.Column(db.String(4))
    tipo_pintura = db.Column(db.String(1))
    tipo_veiculo = db.Column(db.String(2))
    especie_veiculo = db.Column(db.String(1))
    condicao_vin = db.Column(db.String(1))
    condicao_veiculo = db.Column(db.String(1))
    codigo_marca_modelo = db.Column(db.String(6))
    codigo_cor_denatran = db.Column(db.String(2))
    lotacao_maxima = db.Column(db.Integer)
    restricao = db.Column(db.String(1))
    id_nfe_detalhe = db.Column(db.Integer, db.ForeignKey('nfe_detalhe.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_detalhe = data.get('idNfeDetalhe')
        self.tipo_operacao = data.get('tipoOperacao')
        self.chassi = data.get('chassi')
        self.cor = data.get('cor')
        self.descricao_cor = data.get('descricaoCor')
        self.potencia_motor = data.get('potenciaMotor')
        self.cilindradas = data.get('cilindradas')
        self.peso_liquido = data.get('pesoLiquido')
        self.peso_bruto = data.get('pesoBruto')
        self.numero_serie = data.get('numeroSerie')
        self.tipo_combustivel = data.get('tipoCombustivel')
        self.numero_motor = data.get('numeroMotor')
        self.capacidade_maxima_tracao = data.get('capacidadeMaximaTracao')
        self.distancia_eixos = data.get('distanciaEixos')
        self.ano_modelo = data.get('anoModelo')
        self.ano_fabricacao = data.get('anoFabricacao')
        self.tipo_pintura = data.get('tipoPintura')
        self.tipo_veiculo = data.get('tipoVeiculo')
        self.especie_veiculo = data.get('especieVeiculo')
        self.condicao_vin = data.get('condicaoVin')
        self.condicao_veiculo = data.get('condicaoVeiculo')
        self.codigo_marca_modelo = data.get('codigoMarcaModelo')
        self.codigo_cor_denatran = data.get('codigoCorDenatran')
        self.lotacao_maxima = data.get('lotacaoMaxima')
        self.restricao = data.get('restricao')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeDetalhe': self.id_nfe_detalhe,
            'tipoOperacao': self.tipo_operacao,
            'chassi': self.chassi,
            'cor': self.cor,
            'descricaoCor': self.descricao_cor,
            'potenciaMotor': self.potencia_motor,
            'cilindradas': self.cilindradas,
            'pesoLiquido': self.peso_liquido,
            'pesoBruto': self.peso_bruto,
            'numeroSerie': self.numero_serie,
            'tipoCombustivel': self.tipo_combustivel,
            'numeroMotor': self.numero_motor,
            'capacidadeMaximaTracao': self.capacidade_maxima_tracao,
            'distanciaEixos': self.distancia_eixos,
            'anoModelo': self.ano_modelo,
            'anoFabricacao': self.ano_fabricacao,
            'tipoPintura': self.tipo_pintura,
            'tipoVeiculo': self.tipo_veiculo,
            'especieVeiculo': self.especie_veiculo,
            'condicaoVin': self.condicao_vin,
            'condicaoVeiculo': self.condicao_veiculo,
            'codigoMarcaModelo': self.codigo_marca_modelo,
            'codigoCorDenatran': self.codigo_cor_denatran,
            'lotacaoMaxima': self.lotacao_maxima,
            'restricao': self.restricao,
        }