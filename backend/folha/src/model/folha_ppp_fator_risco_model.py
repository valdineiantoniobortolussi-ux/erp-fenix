from src import db


class FolhaPppFatorRiscoModel(db.Model):
    __tablename__ = 'folha_ppp_fator_risco'

    id = db.Column(db.Integer, primary_key=True)
    data_inicio = db.Column(db.DateTime)
    data_fim = db.Column(db.DateTime)
    tipo = db.Column(db.String(1))
    fator_risco = db.Column(db.String(40))
    intensidade = db.Column(db.String(15))
    tecnica_utilizada = db.Column(db.String(40))
    epc_eficaz = db.Column(db.String(1))
    epi_eficaz = db.Column(db.String(1))
    ca_epi = db.Column(db.Integer)
    atendimento_nr06_1 = db.Column(db.String(1))
    atendimento_nr06_2 = db.Column(db.String(1))
    atendimento_nr06_3 = db.Column(db.String(1))
    atendimento_nr06_4 = db.Column(db.String(1))
    atendimento_nr06_5 = db.Column(db.String(1))
    id_folha_ppp = db.Column(db.Integer, db.ForeignKey('folha_ppp.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_folha_ppp = data.get('idFolhaPpp')
        self.data_inicio = data.get('dataInicio')
        self.data_fim = data.get('dataFim')
        self.tipo = data.get('tipo')
        self.fator_risco = data.get('fatorRisco')
        self.intensidade = data.get('intensidade')
        self.tecnica_utilizada = data.get('tecnicaUtilizada')
        self.epc_eficaz = data.get('epcEficaz')
        self.epi_eficaz = data.get('epiEficaz')
        self.ca_epi = data.get('caEpi')
        self.atendimento_nr06_1 = data.get('atendimentoNr061')
        self.atendimento_nr06_2 = data.get('atendimentoNr062')
        self.atendimento_nr06_3 = data.get('atendimentoNr063')
        self.atendimento_nr06_4 = data.get('atendimentoNr064')
        self.atendimento_nr06_5 = data.get('atendimentoNr065')

    def serialize(self):
        return {
            'id': self.id,
            'idFolhaPpp': self.id_folha_ppp,
            'dataInicio': self.data_inicio.isoformat(),
            'dataFim': self.data_fim.isoformat(),
            'tipo': self.tipo,
            'fatorRisco': self.fator_risco,
            'intensidade': self.intensidade,
            'tecnicaUtilizada': self.tecnica_utilizada,
            'epcEficaz': self.epc_eficaz,
            'epiEficaz': self.epi_eficaz,
            'caEpi': self.ca_epi,
            'atendimentoNr061': self.atendimento_nr06_1,
            'atendimentoNr062': self.atendimento_nr06_2,
            'atendimentoNr063': self.atendimento_nr06_3,
            'atendimentoNr064': self.atendimento_nr06_4,
            'atendimentoNr065': self.atendimento_nr06_5,
        }