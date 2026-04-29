from src import db


class FolhaEventoModel(db.Model):
    __tablename__ = 'folha_evento'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(3))
    nome = db.Column(db.String(100))
    descricao = db.Column(db.Text)
    base_calculo = db.Column(db.String(2))
    tipo = db.Column(db.String(1))
    unidade = db.Column(db.String(1))
    taxa = db.Column(db.Float)
    rubrica_esocial = db.Column(db.String(4))
    cod_incidencia_previdencia = db.Column(db.String(2))
    cod_incidencia_irrf = db.Column(db.String(2))
    cod_incidencia_fgts = db.Column(db.String(2))
    cod_incidencia_sindicato = db.Column(db.String(2))
    repercute_dsr = db.Column(db.String(1))
    repercute_13 = db.Column(db.String(1))
    repercute_ferias = db.Column(db.String(1))
    repercute_aviso = db.Column(db.String(1))


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')
        self.base_calculo = data.get('baseCalculo')
        self.tipo = data.get('tipo')
        self.unidade = data.get('unidade')
        self.taxa = data.get('taxa')
        self.rubrica_esocial = data.get('rubricaEsocial')
        self.cod_incidencia_previdencia = data.get('codIncidenciaPrevidencia')
        self.cod_incidencia_irrf = data.get('codIncidenciaIrrf')
        self.cod_incidencia_fgts = data.get('codIncidenciaFgts')
        self.cod_incidencia_sindicato = data.get('codIncidenciaSindicato')
        self.repercute_dsr = data.get('repercuteDsr')
        self.repercute_13 = data.get('repercute13')
        self.repercute_ferias = data.get('repercuteFerias')
        self.repercute_aviso = data.get('repercuteAviso')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'nome': self.nome,
            'descricao': self.descricao,
            'baseCalculo': self.base_calculo,
            'tipo': self.tipo,
            'unidade': self.unidade,
            'taxa': self.taxa,
            'rubricaEsocial': self.rubrica_esocial,
            'codIncidenciaPrevidencia': self.cod_incidencia_previdencia,
            'codIncidenciaIrrf': self.cod_incidencia_irrf,
            'codIncidenciaFgts': self.cod_incidencia_fgts,
            'codIncidenciaSindicato': self.cod_incidencia_sindicato,
            'repercuteDsr': self.repercute_dsr,
            'repercute13': self.repercute_13,
            'repercuteFerias': self.repercute_ferias,
            'repercuteAviso': self.repercute_aviso,
        }