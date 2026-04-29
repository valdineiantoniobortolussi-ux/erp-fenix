from src import db
from sqlalchemy import text
from src.model.folha_ppp_model import FolhaPppModel
from src.model.folha_ppp_cat_model import FolhaPppCatModel
from src.model.folha_ppp_atividade_model import FolhaPppAtividadeModel
from src.model.folha_ppp_fator_risco_model import FolhaPppFatorRiscoModel
from src.model.folha_ppp_exame_medico_model import FolhaPppExameMedicoModel

class FolhaPppService:
    def get_list(self):
        return FolhaPppModel.query.all()

    def get_list_filter(self, filter_obj):
        return FolhaPppModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FolhaPppModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FolhaPppModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FolhaPppModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FolhaPppModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # folhaPppCatModel
        children_data = data.get('folhaPppCatModelList', []) 
        for child_data in children_data:
            child = FolhaPppCatModel()
            child.mapping(child_data)
            parent.folha_ppp_cat_model_list.append(child)
            db.session.add(child)

        # folhaPppAtividadeModel
        children_data = data.get('folhaPppAtividadeModelList', []) 
        for child_data in children_data:
            child = FolhaPppAtividadeModel()
            child.mapping(child_data)
            parent.folha_ppp_atividade_model_list.append(child)
            db.session.add(child)

        # folhaPppFatorRiscoModel
        children_data = data.get('folhaPppFatorRiscoModelList', []) 
        for child_data in children_data:
            child = FolhaPppFatorRiscoModel()
            child.mapping(child_data)
            parent.folha_ppp_fator_risco_model_list.append(child)
            db.session.add(child)

        # folhaPppExameMedicoModel
        children_data = data.get('folhaPppExameMedicoModelList', []) 
        for child_data in children_data:
            child = FolhaPppExameMedicoModel()
            child.mapping(child_data)
            parent.folha_ppp_exame_medico_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # folhaPppCatModel
        for child in parent.folha_ppp_cat_model_list: 
            db.session.delete(child)

        # folhaPppAtividadeModel
        for child in parent.folha_ppp_atividade_model_list: 
            db.session.delete(child)

        # folhaPppFatorRiscoModel
        for child in parent.folha_ppp_fator_risco_model_list: 
            db.session.delete(child)

        # folhaPppExameMedicoModel
        for child in parent.folha_ppp_exame_medico_model_list: 
            db.session.delete(child)

