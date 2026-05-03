from src import db
from src.model.cte_aquaviario_model import CteAquaviarioModel


class CteAquaviarioBalsaModel(db.Model):
    __tablename__ = 'cte_aquaviario_balsa'

    id = db.Column(db.Integer, primary_key=True)
    id_balsa = db.Column(db.String(60))
    numero_viagem = db.Column(db.Integer)
    direcao = db.Column(db.String(1))
    porto_embarque = db.Column(db.String(60))
    porto_transbordo = db.Column(db.String(60))
    porto_destino = db.Column(db.String(60))
    tipo_navegacao = db.Column(db.String(1))
    irin = db.Column(db.String(10))
    id_cte_aquaviario = db.Column(db.Integer, db.ForeignKey('cte_aquaviario.id'))

    cte_aquaviario_model = db.relationship('CteAquaviarioModel', foreign_keys=[id_cte_aquaviario])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_aquaviario = data.get('idCteAquaviario')
        self.id_balsa = data.get('idBalsa')
        self.numero_viagem = data.get('numeroViagem')
        self.direcao = data.get('direcao')
        self.porto_embarque = data.get('portoEmbarque')
        self.porto_transbordo = data.get('portoTransbordo')
        self.porto_destino = data.get('portoDestino')
        self.tipo_navegacao = data.get('tipoNavegacao')
        self.irin = data.get('irin')

    def serialize(self):
        return {
            'id': self.id,
            'idCteAquaviario': self.id_cte_aquaviario,
            'idBalsa': self.id_balsa,
            'numeroViagem': self.numero_viagem,
            'direcao': self.direcao,
            'portoEmbarque': self.porto_embarque,
            'portoTransbordo': self.porto_transbordo,
            'portoDestino': self.porto_destino,
            'tipoNavegacao': self.tipo_navegacao,
            'irin': self.irin,
            'cteAquaviarioModel': self.cte_aquaviario_model.serialize() if self.cte_aquaviario_model else None,
        }