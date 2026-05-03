from src import db
from sqlalchemy import text
from src.model.rateio_centro_resultado_cab_model import RateioCentroResultadoCabModel
from src.model.rateio_centro_resultado_det_model import RateioCentroResultadoDetModel

class RateioCentroResultadoCabService:
    def get_list(self):
        return RateioCentroResultadoCabModel.query.all()

    def get_list_filter(self, filter_obj):
        return RateioCentroResultadoCabModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return RateioCentroResultadoCabModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = RateioCentroResultadoCabModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = RateioCentroResultadoCabModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = RateioCentroResultadoCabModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # rateioCentroResultadoDetModel
        children_data = data.get('rateioCentroResultadoDetModelList', []) 
        for child_data in children_data:
            child = RateioCentroResultadoDetModel()
            child.mapping(child_data)
            parent.rateio_centro_resultado_det_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # rateioCentroResultadoDetModel
        for child in parent.rateio_centro_resultado_det_model_list: 
            db.session.delete(child)

