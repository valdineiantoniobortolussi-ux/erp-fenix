from src import db
from src.model.frota_ipva_controle_model import FrotaIpvaControleModel
from src.model.frota_dpvat_controle_model import FrotaDpvatControleModel
from src.model.frota_veiculo_sinistro_model import FrotaVeiculoSinistroModel
from src.model.frota_veiculo_movimentacao_model import FrotaVeiculoMovimentacaoModel
from src.model.frota_veiculo_pneu_model import FrotaVeiculoPneuModel
from src.model.frota_veiculo_manutencao_model import FrotaVeiculoManutencaoModel
from src.model.frota_multa_controle_model import FrotaMultaControleModel
from src.model.frota_combustivel_controle_model import FrotaCombustivelControleModel
from src.model.frota_veiculo_tipo_model import FrotaVeiculoTipoModel
from src.model.frota_combustivel_tipo_model import FrotaCombustivelTipoModel


class FrotaVeiculoModel(db.Model):
    __tablename__ = 'frota_veiculo'

    id = db.Column(db.Integer, primary_key=True)
    marca = db.Column(db.String(100))
    modelo = db.Column(db.String(100))
    modelo_ano = db.Column(db.String(4))
    placa = db.Column(db.String(7))
    codigo_fipe = db.Column(db.String(7))
    renavam = db.Column(db.String(11))
    ipva_mes_vencimento = db.Column(db.String(2))
    dpvat_mes_vencimento = db.Column(db.String(2))
    id_frota_veiculo_tipo = db.Column(db.Integer, db.ForeignKey('frota_veiculo_tipo.id'))
    id_frota_combustivel_tipo = db.Column(db.Integer, db.ForeignKey('frota_combustivel_tipo.id'))

    frota_ipva_controle_model_list = db.relationship('FrotaIpvaControleModel', lazy='dynamic')
    frota_dpvat_controle_model_list = db.relationship('FrotaDpvatControleModel', lazy='dynamic')
    frota_veiculo_sinistro_model_list = db.relationship('FrotaVeiculoSinistroModel', lazy='dynamic')
    frota_veiculo_movimentacao_model_list = db.relationship('FrotaVeiculoMovimentacaoModel', lazy='dynamic')
    frota_veiculo_pneu_model_list = db.relationship('FrotaVeiculoPneuModel', lazy='dynamic')
    frota_veiculo_manutencao_model_list = db.relationship('FrotaVeiculoManutencaoModel', lazy='dynamic')
    frota_multa_controle_model_list = db.relationship('FrotaMultaControleModel', lazy='dynamic')
    frota_combustivel_controle_model_list = db.relationship('FrotaCombustivelControleModel', lazy='dynamic')
    frota_veiculo_tipo_model = db.relationship('FrotaVeiculoTipoModel', foreign_keys=[id_frota_veiculo_tipo])
    frota_combustivel_tipo_model = db.relationship('FrotaCombustivelTipoModel', foreign_keys=[id_frota_combustivel_tipo])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_frota_veiculo_tipo = data.get('idFrotaVeiculoTipo')
        self.id_frota_combustivel_tipo = data.get('idFrotaCombustivelTipo')
        self.marca = data.get('marca')
        self.modelo = data.get('modelo')
        self.modelo_ano = data.get('modeloAno')
        self.placa = data.get('placa')
        self.codigo_fipe = data.get('codigoFipe')
        self.renavam = data.get('renavam')
        self.ipva_mes_vencimento = data.get('ipvaMesVencimento')
        self.dpvat_mes_vencimento = data.get('dpvatMesVencimento')

    def serialize(self):
        return {
            'id': self.id,
            'idFrotaVeiculoTipo': self.id_frota_veiculo_tipo,
            'idFrotaCombustivelTipo': self.id_frota_combustivel_tipo,
            'marca': self.marca,
            'modelo': self.modelo,
            'modeloAno': self.modelo_ano,
            'placa': self.placa,
            'codigoFipe': self.codigo_fipe,
            'renavam': self.renavam,
            'ipvaMesVencimento': self.ipva_mes_vencimento,
            'dpvatMesVencimento': self.dpvat_mes_vencimento,
            'frotaIpvaControleModelList': [frota_ipva_controle_model.serialize() for frota_ipva_controle_model in self.frota_ipva_controle_model_list],
            'frotaDpvatControleModelList': [frota_dpvat_controle_model.serialize() for frota_dpvat_controle_model in self.frota_dpvat_controle_model_list],
            'frotaVeiculoSinistroModelList': [frota_veiculo_sinistro_model.serialize() for frota_veiculo_sinistro_model in self.frota_veiculo_sinistro_model_list],
            'frotaVeiculoMovimentacaoModelList': [frota_veiculo_movimentacao_model.serialize() for frota_veiculo_movimentacao_model in self.frota_veiculo_movimentacao_model_list],
            'frotaVeiculoPneuModelList': [frota_veiculo_pneu_model.serialize() for frota_veiculo_pneu_model in self.frota_veiculo_pneu_model_list],
            'frotaVeiculoManutencaoModelList': [frota_veiculo_manutencao_model.serialize() for frota_veiculo_manutencao_model in self.frota_veiculo_manutencao_model_list],
            'frotaMultaControleModelList': [frota_multa_controle_model.serialize() for frota_multa_controle_model in self.frota_multa_controle_model_list],
            'frotaCombustivelControleModelList': [frota_combustivel_controle_model.serialize() for frota_combustivel_controle_model in self.frota_combustivel_controle_model_list],
            'frotaVeiculoTipoModel': self.frota_veiculo_tipo_model.serialize() if self.frota_veiculo_tipo_model else None,
            'frotaCombustivelTipoModel': self.frota_combustivel_tipo_model.serialize() if self.frota_combustivel_tipo_model else None,
        }