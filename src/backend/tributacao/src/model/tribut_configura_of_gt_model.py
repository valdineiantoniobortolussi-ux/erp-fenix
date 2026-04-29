from src import db
from src.model.tribut_ipi_model import TributIpiModel
from src.model.tribut_cofins_model import TributCofinsModel
from src.model.tribut_pis_model import TributPisModel
from src.model.tribut_grupo_tributario_model import TributGrupoTributarioModel
from src.model.tribut_operacao_fiscal_model import TributOperacaoFiscalModel
from src.model.tribut_icms_uf_model import TributIcmsUfModel


class TributConfiguraOfGtModel(db.Model):
    __tablename__ = 'tribut_configura_of_gt'

    id = db.Column(db.Integer, primary_key=True)
    id_tribut_grupo_tributario = db.Column(db.Integer, db.ForeignKey('tribut_grupo_tributario.id'))
    id_tribut_operacao_fiscal = db.Column(db.Integer, db.ForeignKey('tribut_operacao_fiscal.id'))

    tribut_ipi_model = db.relationship('TributIpiModel', uselist=False)
    tribut_cofins_model = db.relationship('TributCofinsModel', uselist=False)
    tribut_pis_model = db.relationship('TributPisModel', uselist=False)
    tribut_grupo_tributario_model = db.relationship('TributGrupoTributarioModel', foreign_keys=[id_tribut_grupo_tributario])
    tribut_operacao_fiscal_model = db.relationship('TributOperacaoFiscalModel', foreign_keys=[id_tribut_operacao_fiscal])
    tribut_icms_uf_model_list = db.relationship('TributIcmsUfModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.id_tribut_grupo_tributario = data.get('idTributGrupoTributario')
        self.id_tribut_operacao_fiscal = data.get('idTributOperacaoFiscal')

    def serialize(self):
        return {
            'id': self.id,
            'idTributGrupoTributario': self.id_tribut_grupo_tributario,
            'idTributOperacaoFiscal': self.id_tribut_operacao_fiscal,
            'tributIpiModel': self.tribut_ipi_model.serialize() if self.tribut_ipi_model else None,
            'tributCofinsModel': self.tribut_cofins_model.serialize() if self.tribut_cofins_model else None,
            'tributPisModel': self.tribut_pis_model.serialize() if self.tribut_pis_model else None,
            'tributGrupoTributarioModel': self.tribut_grupo_tributario_model.serialize() if self.tribut_grupo_tributario_model else None,
            'tributOperacaoFiscalModel': self.tribut_operacao_fiscal_model.serialize() if self.tribut_operacao_fiscal_model else None,
            'tributIcmsUfModelList': [tribut_icms_uf_model.serialize() for tribut_icms_uf_model in self.tribut_icms_uf_model_list],
        }