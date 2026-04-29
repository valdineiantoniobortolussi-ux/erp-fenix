from src import db
from src.model.folha_ppp_cat_model import FolhaPppCatModel
from src.model.folha_ppp_atividade_model import FolhaPppAtividadeModel
from src.model.folha_ppp_fator_risco_model import FolhaPppFatorRiscoModel
from src.model.folha_ppp_exame_medico_model import FolhaPppExameMedicoModel
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel


class FolhaPppModel(db.Model):
    __tablename__ = 'folha_ppp'

    id = db.Column(db.Integer, primary_key=True)
    observacao = db.Column(db.Text)
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    folha_ppp_cat_model_list = db.relationship('FolhaPppCatModel', lazy='dynamic')
    folha_ppp_atividade_model_list = db.relationship('FolhaPppAtividadeModel', lazy='dynamic')
    folha_ppp_fator_risco_model_list = db.relationship('FolhaPppFatorRiscoModel', lazy='dynamic')
    folha_ppp_exame_medico_model_list = db.relationship('FolhaPppExameMedicoModel', lazy='dynamic')
    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_colaborador = data.get('idColaborador')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idColaborador': self.id_colaborador,
            'observacao': self.observacao,
            'folhaPppCatModelList': [folha_ppp_cat_model.serialize() for folha_ppp_cat_model in self.folha_ppp_cat_model_list],
            'folhaPppAtividadeModelList': [folha_ppp_atividade_model.serialize() for folha_ppp_atividade_model in self.folha_ppp_atividade_model_list],
            'folhaPppFatorRiscoModelList': [folha_ppp_fator_risco_model.serialize() for folha_ppp_fator_risco_model in self.folha_ppp_fator_risco_model_list],
            'folhaPppExameMedicoModelList': [folha_ppp_exame_medico_model.serialize() for folha_ppp_exame_medico_model in self.folha_ppp_exame_medico_model_list],
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
        }