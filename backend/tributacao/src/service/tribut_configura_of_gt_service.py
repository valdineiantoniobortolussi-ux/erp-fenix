from src import db
from sqlalchemy import text
from src.model.tribut_configura_of_gt_model import TributConfiguraOfGtModel
from src.model.tribut_ipi_model import TributIpiModel
from src.model.tribut_cofins_model import TributCofinsModel
from src.model.tribut_pis_model import TributPisModel
from src.model.tribut_icms_uf_model import TributIcmsUfModel

class TributConfiguraOfGtService:
    def get_list(self):
        return TributConfiguraOfGtModel.query.all()

    def get_list_filter(self, filter_obj):
        return TributConfiguraOfGtModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return TributConfiguraOfGtModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = TributConfiguraOfGtModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = TributConfiguraOfGtModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = TributConfiguraOfGtModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # tributIpiModel
        child_data = data.get('tributIpiModel') 
        if child_data:
            child = TributIpiModel()
            child.mapping(child_data)
            parent.tribut_ipi_model = child
            db.session.add(child)

        # tributCofinsModel
        child_data = data.get('tributCofinsModel') 
        if child_data:
            child = TributCofinsModel()
            child.mapping(child_data)
            parent.tribut_cofins_model = child
            db.session.add(child)

        # tributPisModel
        child_data = data.get('tributPisModel') 
        if child_data:
            child = TributPisModel()
            child.mapping(child_data)
            parent.tribut_pis_model = child
            db.session.add(child)

        # tributIcmsUfModel
        children_data = data.get('tributIcmsUfModelList', []) 
        for child_data in children_data:
            child = TributIcmsUfModel()
            child.mapping(child_data)
            parent.tribut_icms_uf_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # tributIpiModel
        if parent.tribut_ipi_model: 
            db.session.delete(parent.tribut_ipi_model)

        # tributCofinsModel
        if parent.tribut_cofins_model: 
            db.session.delete(parent.tribut_cofins_model)

        # tributPisModel
        if parent.tribut_pis_model: 
            db.session.delete(parent.tribut_pis_model)

        # tributIcmsUfModel
        for child in parent.tribut_icms_uf_model_list: 
            db.session.delete(child)

