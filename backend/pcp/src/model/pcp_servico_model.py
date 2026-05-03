from src import db
from src.model.pcp_servico_colaborador_model import PcpServicoColaboradorModel
from src.model.pcp_servico_equipamento_model import PcpServicoEquipamentoModel
from src.model.pcp_op_detalhe_model import PcpOpDetalheModel


class PcpServicoModel(db.Model):
    __tablename__ = 'pcp_servico'

    id = db.Column(db.Integer, primary_key=True)
    inicio_realizado = db.Column(db.DateTime)
    termino_realizado = db.Column(db.DateTime)
    horas_realizado = db.Column(db.Integer)
    minutos_realizado = db.Column(db.Integer)
    segundos_realizado = db.Column(db.Integer)
    custo_realizado = db.Column(db.Float)
    inicio_previsto = db.Column(db.DateTime)
    termino_previsto = db.Column(db.DateTime)
    horas_previsto = db.Column(db.Integer)
    minutos_previsto = db.Column(db.Integer)
    segundos_previsto = db.Column(db.Integer)
    custo_previsto = db.Column(db.Float)
    id_pcp_op_detalhe = db.Column(db.Integer, db.ForeignKey('pcp_op_detalhe.id'))

    pcp_servico_colaborador_model_list = db.relationship('PcpServicoColaboradorModel', lazy='dynamic')
    pcp_servico_equipamento_model_list = db.relationship('PcpServicoEquipamentoModel', lazy='dynamic')
    pcp_op_detalhe_model = db.relationship('PcpOpDetalheModel', foreign_keys=[id_pcp_op_detalhe])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_pcp_op_detalhe = data.get('idPcpOpDetalhe')
        self.inicio_realizado = data.get('inicioRealizado')
        self.termino_realizado = data.get('terminoRealizado')
        self.horas_realizado = data.get('horasRealizado')
        self.minutos_realizado = data.get('minutosRealizado')
        self.segundos_realizado = data.get('segundosRealizado')
        self.custo_realizado = data.get('custoRealizado')
        self.inicio_previsto = data.get('inicioPrevisto')
        self.termino_previsto = data.get('terminoPrevisto')
        self.horas_previsto = data.get('horasPrevisto')
        self.minutos_previsto = data.get('minutosPrevisto')
        self.segundos_previsto = data.get('segundosPrevisto')
        self.custo_previsto = data.get('custoPrevisto')

    def serialize(self):
        return {
            'id': self.id,
            'idPcpOpDetalhe': self.id_pcp_op_detalhe,
            'inicioRealizado': self.inicio_realizado.isoformat(),
            'terminoRealizado': self.termino_realizado.isoformat(),
            'horasRealizado': self.horas_realizado,
            'minutosRealizado': self.minutos_realizado,
            'segundosRealizado': self.segundos_realizado,
            'custoRealizado': self.custo_realizado,
            'inicioPrevisto': self.inicio_previsto.isoformat(),
            'terminoPrevisto': self.termino_previsto.isoformat(),
            'horasPrevisto': self.horas_previsto,
            'minutosPrevisto': self.minutos_previsto,
            'segundosPrevisto': self.segundos_previsto,
            'custoPrevisto': self.custo_previsto,
            'pcpServicoColaboradorModelList': [pcp_servico_colaborador_model.serialize() for pcp_servico_colaborador_model in self.pcp_servico_colaborador_model_list],
            'pcpServicoEquipamentoModelList': [pcp_servico_equipamento_model.serialize() for pcp_servico_equipamento_model in self.pcp_servico_equipamento_model_list],
            'pcpOpDetalheModel': self.pcp_op_detalhe_model.serialize() if self.pcp_op_detalhe_model else None,
        }