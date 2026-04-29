from src import db
from sqlalchemy import text
from src.model.projeto_principal_model import ProjetoPrincipalModel
from src.model.projeto_cronograma_model import ProjetoCronogramaModel
from src.model.projeto_risco_model import ProjetoRiscoModel
from src.model.projeto_custo_model import ProjetoCustoModel
from src.model.projeto_stakeholders_model import ProjetoStakeholdersModel

class ProjetoPrincipalService:
    def get_list(self):
        return ProjetoPrincipalModel.query.all()

    def get_list_filter(self, filter_obj):
        return ProjetoPrincipalModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ProjetoPrincipalModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ProjetoPrincipalModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ProjetoPrincipalModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ProjetoPrincipalModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # projetoCronogramaModel
        children_data = data.get('projetoCronogramaModelList', []) 
        for child_data in children_data:
            child = ProjetoCronogramaModel()
            child.mapping(child_data)
            parent.projeto_cronograma_model_list.append(child)
            db.session.add(child)

        # projetoRiscoModel
        children_data = data.get('projetoRiscoModelList', []) 
        for child_data in children_data:
            child = ProjetoRiscoModel()
            child.mapping(child_data)
            parent.projeto_risco_model_list.append(child)
            db.session.add(child)

        # projetoCustoModel
        children_data = data.get('projetoCustoModelList', []) 
        for child_data in children_data:
            child = ProjetoCustoModel()
            child.mapping(child_data)
            parent.projeto_custo_model_list.append(child)
            db.session.add(child)

        # projetoStakeholdersModel
        children_data = data.get('projetoStakeholdersModelList', []) 
        for child_data in children_data:
            child = ProjetoStakeholdersModel()
            child.mapping(child_data)
            parent.projeto_stakeholders_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # projetoCronogramaModel
        for child in parent.projeto_cronograma_model_list: 
            db.session.delete(child)

        # projetoRiscoModel
        for child in parent.projeto_risco_model_list: 
            db.session.delete(child)

        # projetoCustoModel
        for child in parent.projeto_custo_model_list: 
            db.session.delete(child)

        # projetoStakeholdersModel
        for child in parent.projeto_stakeholders_model_list: 
            db.session.delete(child)

