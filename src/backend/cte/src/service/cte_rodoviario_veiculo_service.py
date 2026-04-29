from src import db
from sqlalchemy import text
from src.model.cte_rodoviario_veiculo_model import CteRodoviarioVeiculoModel

class CteRodoviarioVeiculoService:
    def get_list(self):
        return CteRodoviarioVeiculoModel.query.all()

    def get_list_filter(self, filter_obj):
        return CteRodoviarioVeiculoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CteRodoviarioVeiculoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CteRodoviarioVeiculoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CteRodoviarioVeiculoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CteRodoviarioVeiculoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()