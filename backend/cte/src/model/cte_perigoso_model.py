from src import db


class CtePerigosoModel(db.Model):
    __tablename__ = 'cte_perigoso'

    id = db.Column(db.Integer, primary_key=True)
    numero_onu = db.Column(db.String(4))
    nome_apropriado = db.Column(db.String(150))
    classe_risco = db.Column(db.String(40))
    grupo_embalagem = db.Column(db.String(6))
    quantidade_total_produto = db.Column(db.String(20))
    quantidade_tipo_volume = db.Column(db.String(60))
    ponto_fulgor = db.Column(db.String(6))
    id_cte_cabecalho = db.Column(db.Integer, db.ForeignKey('cte_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_cabecalho = data.get('idCteCabecalho')
        self.numero_onu = data.get('numeroOnu')
        self.nome_apropriado = data.get('nomeApropriado')
        self.classe_risco = data.get('classeRisco')
        self.grupo_embalagem = data.get('grupoEmbalagem')
        self.quantidade_total_produto = data.get('quantidadeTotalProduto')
        self.quantidade_tipo_volume = data.get('quantidadeTipoVolume')
        self.ponto_fulgor = data.get('pontoFulgor')

    def serialize(self):
        return {
            'id': self.id,
            'idCteCabecalho': self.id_cte_cabecalho,
            'numeroOnu': self.numero_onu,
            'nomeApropriado': self.nome_apropriado,
            'classeRisco': self.classe_risco,
            'grupoEmbalagem': self.grupo_embalagem,
            'quantidadeTotalProduto': self.quantidade_total_produto,
            'quantidadeTipoVolume': self.quantidade_tipo_volume,
            'pontoFulgor': self.ponto_fulgor,
        }