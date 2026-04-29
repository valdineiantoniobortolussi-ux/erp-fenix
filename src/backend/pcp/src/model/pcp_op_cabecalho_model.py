from src import db
from src.model.pcp_op_detalhe_model import PcpOpDetalheModel
from src.model.pcp_instrucao_op_model import PcpInstrucaoOpModel


class PcpOpCabecalhoModel(db.Model):
    __tablename__ = 'pcp_op_cabecalho'

    id = db.Column(db.Integer, primary_key=True)
    data_inicio = db.Column(db.DateTime)
    data_previsao_entrega = db.Column(db.DateTime)
    data_termino = db.Column(db.DateTime)
    custo_total_previsto = db.Column(db.Float)
    custo_total_realizado = db.Column(db.Float)
    porcento_venda = db.Column(db.Float)
    porcento_estoque = db.Column(db.Float)

    pcp_op_detalhe_model_list = db.relationship('PcpOpDetalheModel', lazy='dynamic')
    pcp_instrucao_op_model_list = db.relationship('PcpInstrucaoOpModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.data_inicio = data.get('dataInicio')
        self.data_previsao_entrega = data.get('dataPrevisaoEntrega')
        self.data_termino = data.get('dataTermino')
        self.custo_total_previsto = data.get('custoTotalPrevisto')
        self.custo_total_realizado = data.get('custoTotalRealizado')
        self.porcento_venda = data.get('porcentoVenda')
        self.porcento_estoque = data.get('porcentoEstoque')

    def serialize(self):
        return {
            'id': self.id,
            'dataInicio': self.data_inicio.isoformat(),
            'dataPrevisaoEntrega': self.data_previsao_entrega.isoformat(),
            'dataTermino': self.data_termino.isoformat(),
            'custoTotalPrevisto': self.custo_total_previsto,
            'custoTotalRealizado': self.custo_total_realizado,
            'porcentoVenda': self.porcento_venda,
            'porcentoEstoque': self.porcento_estoque,
            'pcpOpDetalheModelList': [pcp_op_detalhe_model.serialize() for pcp_op_detalhe_model in self.pcp_op_detalhe_model_list],
            'pcpInstrucaoOpModelList': [pcp_instrucao_op_model.serialize() for pcp_instrucao_op_model in self.pcp_instrucao_op_model_list],
        }