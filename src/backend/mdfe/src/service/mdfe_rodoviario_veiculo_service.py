from src import db
from sqlalchemy import text
from src.model.mdfe_rodoviario_veiculo_model import MdfeRodoviarioVeiculoModel

class MdfeRodoviarioVeiculoService:
    def get_list(self):
        return MdfeRodoviarioVeiculoModel.query.all()

    def get_list_filter(self, filter_obj):
        return MdfeRodoviarioVeiculoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return MdfeRodoviarioVeiculoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = MdfeRodoviarioVeiculoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = MdfeRodoviarioVeiculoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = MdfeRodoviarioVeiculoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()