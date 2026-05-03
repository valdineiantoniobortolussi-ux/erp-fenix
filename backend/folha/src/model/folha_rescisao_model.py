from src import db
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel


class FolhaRescisaoModel(db.Model):
    __tablename__ = 'folha_rescisao'

    id = db.Column(db.Integer, primary_key=True)
    data_demissao = db.Column(db.DateTime)
    data_pagamento = db.Column(db.DateTime)
    motivo = db.Column(db.String(100))
    motivo_esocial = db.Column(db.String(2))
    data_aviso_previo = db.Column(db.DateTime)
    dias_aviso_previo = db.Column(db.Integer)
    comprovou_novo_emprego = db.Column(db.String(1))
    dispensou_empregado = db.Column(db.String(1))
    pensao_alimenticia = db.Column(db.Float)
    pensao_alimenticia_fgts = db.Column(db.Float)
    fgts_valor_rescisao = db.Column(db.Float)
    fgts_saldo_banco = db.Column(db.Float)
    fgts_complemento_saldo = db.Column(db.Float)
    fgts_codigo_afastamento = db.Column(db.String(10))
    fgts_codigo_saque = db.Column(db.String(10))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))

    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_colaborador = data.get('idColaborador')
        self.data_demissao = data.get('dataDemissao')
        self.data_pagamento = data.get('dataPagamento')
        self.motivo = data.get('motivo')
        self.motivo_esocial = data.get('motivoEsocial')
        self.data_aviso_previo = data.get('dataAvisoPrevio')
        self.dias_aviso_previo = data.get('diasAvisoPrevio')
        self.comprovou_novo_emprego = data.get('comprovouNovoEmprego')
        self.dispensou_empregado = data.get('dispensouEmpregado')
        self.pensao_alimenticia = data.get('pensaoAlimenticia')
        self.pensao_alimenticia_fgts = data.get('pensaoAlimenticiaFgts')
        self.fgts_valor_rescisao = data.get('fgtsValorRescisao')
        self.fgts_saldo_banco = data.get('fgtsSaldoBanco')
        self.fgts_complemento_saldo = data.get('fgtsComplementoSaldo')
        self.fgts_codigo_afastamento = data.get('fgtsCodigoAfastamento')
        self.fgts_codigo_saque = data.get('fgtsCodigoSaque')

    def serialize(self):
        return {
            'id': self.id,
            'idColaborador': self.id_colaborador,
            'dataDemissao': self.data_demissao.isoformat(),
            'dataPagamento': self.data_pagamento.isoformat(),
            'motivo': self.motivo,
            'motivoEsocial': self.motivo_esocial,
            'dataAvisoPrevio': self.data_aviso_previo.isoformat(),
            'diasAvisoPrevio': self.dias_aviso_previo,
            'comprovouNovoEmprego': self.comprovou_novo_emprego,
            'dispensouEmpregado': self.dispensou_empregado,
            'pensaoAlimenticia': self.pensao_alimenticia,
            'pensaoAlimenticiaFgts': self.pensao_alimenticia_fgts,
            'fgtsValorRescisao': self.fgts_valor_rescisao,
            'fgtsSaldoBanco': self.fgts_saldo_banco,
            'fgtsComplementoSaldo': self.fgts_complemento_saldo,
            'fgtsCodigoAfastamento': self.fgts_codigo_afastamento,
            'fgtsCodigoSaque': self.fgts_codigo_saque,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
        }