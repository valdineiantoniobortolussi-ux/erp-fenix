from src import db


class NfeDetEspecificoCombustivelModel(db.Model):
    __tablename__ = 'nfe_det_especifico_combustivel'

    id = db.Column(db.Integer, primary_key=True)
    codigo_anp = db.Column(db.Integer)
    descricao_anp = db.Column(db.String(95))
    percentual_glp = db.Column(db.Float)
    percentual_gas_nacional = db.Column(db.Float)
    percentual_gas_importado = db.Column(db.Float)
    valor_partida = db.Column(db.Float)
    codif = db.Column(db.String(21))
    quantidade_temp_ambiente = db.Column(db.Float)
    uf_consumo = db.Column(db.String(2))
    cide_base_calculo = db.Column(db.Float)
    cide_aliquota = db.Column(db.Float)
    cide_valor = db.Column(db.Float)
    encerrante_bico = db.Column(db.Integer)
    encerrante_bomba = db.Column(db.Integer)
    encerrante_tanque = db.Column(db.Integer)
    encerrante_valor_inicio = db.Column(db.Float)
    encerrante_valor_fim = db.Column(db.Float)
    id_nfe_detalhe = db.Column(db.Integer, db.ForeignKey('nfe_detalhe.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_detalhe = data.get('idNfeDetalhe')
        self.codigo_anp = data.get('codigoAnp')
        self.descricao_anp = data.get('descricaoAnp')
        self.percentual_glp = data.get('percentualGlp')
        self.percentual_gas_nacional = data.get('percentualGasNacional')
        self.percentual_gas_importado = data.get('percentualGasImportado')
        self.valor_partida = data.get('valorPartida')
        self.codif = data.get('codif')
        self.quantidade_temp_ambiente = data.get('quantidadeTempAmbiente')
        self.uf_consumo = data.get('ufConsumo')
        self.cide_base_calculo = data.get('cideBaseCalculo')
        self.cide_aliquota = data.get('cideAliquota')
        self.cide_valor = data.get('cideValor')
        self.encerrante_bico = data.get('encerranteBico')
        self.encerrante_bomba = data.get('encerranteBomba')
        self.encerrante_tanque = data.get('encerranteTanque')
        self.encerrante_valor_inicio = data.get('encerranteValorInicio')
        self.encerrante_valor_fim = data.get('encerranteValorFim')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeDetalhe': self.id_nfe_detalhe,
            'codigoAnp': self.codigo_anp,
            'descricaoAnp': self.descricao_anp,
            'percentualGlp': self.percentual_glp,
            'percentualGasNacional': self.percentual_gas_nacional,
            'percentualGasImportado': self.percentual_gas_importado,
            'valorPartida': self.valor_partida,
            'codif': self.codif,
            'quantidadeTempAmbiente': self.quantidade_temp_ambiente,
            'ufConsumo': self.uf_consumo,
            'cideBaseCalculo': self.cide_base_calculo,
            'cideAliquota': self.cide_aliquota,
            'cideValor': self.cide_valor,
            'encerranteBico': self.encerrante_bico,
            'encerranteBomba': self.encerrante_bomba,
            'encerranteTanque': self.encerrante_tanque,
            'encerranteValorInicio': self.encerrante_valor_inicio,
            'encerranteValorFim': self.encerrante_valor_fim,
        }