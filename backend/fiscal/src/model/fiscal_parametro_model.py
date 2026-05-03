from src import db
from src.model.fiscal_inscricoes_substitutas_model import FiscalInscricoesSubstitutasModel
from src.model.fiscal_estadual_regime_model import FiscalEstadualRegimeModel
from src.model.fiscal_estadual_porte_model import FiscalEstadualPorteModel
from src.model.fiscal_municipal_regime_model import FiscalMunicipalRegimeModel


class FiscalParametroModel(db.Model):
    __tablename__ = 'fiscal_parametro'

    id = db.Column(db.Integer, primary_key=True)
    vigencia = db.Column(db.String(7))
    descricao_vigencia = db.Column(db.String(100))
    criterio_lancamento = db.Column(db.String(1))
    apuracao = db.Column(db.String(1))
    microempree_individual = db.Column(db.String(1))
    calc_pis_cofins_efd = db.Column(db.String(2))
    simples_codigo_acesso = db.Column(db.String(50))
    simples_tabela = db.Column(db.String(1))
    simples_atividade = db.Column(db.String(2))
    perfil_sped = db.Column(db.String(1))
    apuracao_consolidada = db.Column(db.String(1))
    substituicao_tributaria = db.Column(db.String(1))
    forma_calculo_iss = db.Column(db.String(2))
    id_fiscal_estadual_regime = db.Column(db.Integer, db.ForeignKey('fiscal_estadual_regime.id'))
    id_fiscal_estadual_porte = db.Column(db.Integer, db.ForeignKey('fiscal_estadual_porte.id'))
    id_fiscal_municipal_regime = db.Column(db.Integer, db.ForeignKey('fiscal_municipal_regime.id'))

    fiscal_inscricoes_substitutas_model_list = db.relationship('FiscalInscricoesSubstitutasModel', lazy='dynamic')
    fiscal_estadual_regime_model = db.relationship('FiscalEstadualRegimeModel', foreign_keys=[id_fiscal_estadual_regime])
    fiscal_estadual_porte_model = db.relationship('FiscalEstadualPorteModel', foreign_keys=[id_fiscal_estadual_porte])
    fiscal_municipal_regime_model = db.relationship('FiscalMunicipalRegimeModel', foreign_keys=[id_fiscal_municipal_regime])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_fiscal_estadual_porte = data.get('idFiscalEstadualPorte')
        self.id_fiscal_estadual_regime = data.get('idFiscalEstadualRegime')
        self.id_fiscal_municipal_regime = data.get('idFiscalMunicipalRegime')
        self.vigencia = data.get('vigencia')
        self.descricao_vigencia = data.get('descricaoVigencia')
        self.criterio_lancamento = data.get('criterioLancamento')
        self.apuracao = data.get('apuracao')
        self.microempree_individual = data.get('microempreeIndividual')
        self.calc_pis_cofins_efd = data.get('calcPisCofinsEfd')
        self.simples_codigo_acesso = data.get('simplesCodigoAcesso')
        self.simples_tabela = data.get('simplesTabela')
        self.simples_atividade = data.get('simplesAtividade')
        self.perfil_sped = data.get('perfilSped')
        self.apuracao_consolidada = data.get('apuracaoConsolidada')
        self.substituicao_tributaria = data.get('substituicaoTributaria')
        self.forma_calculo_iss = data.get('formaCalculoIss')

    def serialize(self):
        return {
            'id': self.id,
            'idFiscalEstadualPorte': self.id_fiscal_estadual_porte,
            'idFiscalEstadualRegime': self.id_fiscal_estadual_regime,
            'idFiscalMunicipalRegime': self.id_fiscal_municipal_regime,
            'vigencia': self.vigencia,
            'descricaoVigencia': self.descricao_vigencia,
            'criterioLancamento': self.criterio_lancamento,
            'apuracao': self.apuracao,
            'microempreeIndividual': self.microempree_individual,
            'calcPisCofinsEfd': self.calc_pis_cofins_efd,
            'simplesCodigoAcesso': self.simples_codigo_acesso,
            'simplesTabela': self.simples_tabela,
            'simplesAtividade': self.simples_atividade,
            'perfilSped': self.perfil_sped,
            'apuracaoConsolidada': self.apuracao_consolidada,
            'substituicaoTributaria': self.substituicao_tributaria,
            'formaCalculoIss': self.forma_calculo_iss,
            'fiscalInscricoesSubstitutasModelList': [fiscal_inscricoes_substitutas_model.serialize() for fiscal_inscricoes_substitutas_model in self.fiscal_inscricoes_substitutas_model_list],
            'fiscalEstadualRegimeModel': self.fiscal_estadual_regime_model.serialize() if self.fiscal_estadual_regime_model else None,
            'fiscalEstadualPorteModel': self.fiscal_estadual_porte_model.serialize() if self.fiscal_estadual_porte_model else None,
            'fiscalMunicipalRegimeModel': self.fiscal_municipal_regime_model.serialize() if self.fiscal_municipal_regime_model else None,
        }