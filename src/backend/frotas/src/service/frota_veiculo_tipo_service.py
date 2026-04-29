from src import db
from sqlalchemy import text
from src.model.frota_veiculo_tipo_model import FrotaVeiculoTipoModel

class FrotaVeiculoTipoService:
    def get_list(self):
        return FrotaVeiculoTipoModel.query.all()

    def get_list_filter(self, filter_obj):
        return FrotaVeiculoTipoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FrotaVeiculoTipoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FrotaVeiculoTipoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FrotaVeiculoTipoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FrotaVeiculoTipoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()