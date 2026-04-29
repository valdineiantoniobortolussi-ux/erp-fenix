from src import db
from sqlalchemy import text
from src.model.mdfe_rodoviario_ciot_model import MdfeRodoviarioCiotModel

class MdfeRodoviarioCiotService:
    def get_list(self):
        return MdfeRodoviarioCiotModel.query.all()

    def get_list_filter(self, filter_obj):
        return MdfeRodoviarioCiotModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return MdfeRodoviarioCiotModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = MdfeRodoviarioCiotModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = MdfeRodoviarioCiotModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = MdfeRodoviarioCiotModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()