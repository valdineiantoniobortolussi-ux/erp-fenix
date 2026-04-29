from src import db
from src.model.contabil_encerramento_exe_det_model import ContabilEncerramentoExeDetModel


class ContabilEncerramentoExeCabModel(db.Model):
    __tablename__ = 'contabil_encerramento_exe_cab'

    id = db.Column(db.Integer, primary_key=True)
    data_inicio = db.Column(db.DateTime)
    data_fim = db.Column(db.DateTime)
    data_inclusao = db.Column(db.DateTime)
    motivo = db.Column(db.String(100))

    contabil_encerramento_exe_det_model_list = db.relationship('ContabilEncerramentoExeDetModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.data_inicio = data.get('dataInicio')
        self.data_fim = data.get('dataFim')
        self.data_inclusao = data.get('dataInclusao')
        self.motivo = data.get('motivo')

    def serialize(self):
        return {
            'id': self.id,
            'dataInicio': self.data_inicio.isoformat(),
            'dataFim': self.data_fim.isoformat(),
            'dataInclusao': self.data_inclusao.isoformat(),
            'motivo': self.motivo,
            'contabilEncerramentoExeDetModelList': [contabil_encerramento_exe_det_model.serialize() for contabil_encerramento_exe_det_model in self.contabil_encerramento_exe_det_model_list],
        }