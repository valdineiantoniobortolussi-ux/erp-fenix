from src import db
from sqlalchemy import text
from src.model.tribut_icms_custom_cab_model import TributIcmsCustomCabModel
from src.model.tribut_icms_custom_det_model import TributIcmsCustomDetModel

class TributIcmsCustomCabService:
    def get_list(self):
        return TributIcmsCustomCabModel.query.all()

    def get_list_filter(self, filter_obj):
        return TributIcmsCustomCabModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return TributIcmsCustomCabModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = TributIcmsCustomCabModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = TributIcmsCustomCabModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = TributIcmsCustomCabModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # tributIcmsCustomDetModel
        children_data = data.get('tributIcmsCustomDetModelList', []) 
        for child_data in children_data:
            child = TributIcmsCustomDetModel()
            child.mapping(child_data)
            parent.tribut_icms_custom_det_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # tributIcmsCustomDetModel
        for child in parent.tribut_icms_custom_det_model_list: 
            db.session.delete(child)

