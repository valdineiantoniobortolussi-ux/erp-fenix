from src import db
from sqlalchemy import text
from src.model.os_abertura_model import OsAberturaModel
from src.model.os_abertura_equipamento_model import OsAberturaEquipamentoModel
from src.model.os_produto_servico_model import OsProdutoServicoModel
from src.model.os_evolucao_model import OsEvolucaoModel

class OsAberturaService:
    def get_list(self):
        return OsAberturaModel.query.all()

    def get_list_filter(self, filter_obj):
        return OsAberturaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return OsAberturaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = OsAberturaModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = OsAberturaModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = OsAberturaModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # osAberturaEquipamentoModel
        children_data = data.get('osAberturaEquipamentoModelList', []) 
        for child_data in children_data:
            child = OsAberturaEquipamentoModel()
            child.mapping(child_data)
            parent.os_abertura_equipamento_model_list.append(child)
            db.session.add(child)

        # osProdutoServicoModel
        children_data = data.get('osProdutoServicoModelList', []) 
        for child_data in children_data:
            child = OsProdutoServicoModel()
            child.mapping(child_data)
            parent.os_produto_servico_model_list.append(child)
            db.session.add(child)

        # osEvolucaoModel
        children_data = data.get('osEvolucaoModelList', []) 
        for child_data in children_data:
            child = OsEvolucaoModel()
            child.mapping(child_data)
            parent.os_evolucao_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # osAberturaEquipamentoModel
        for child in parent.os_abertura_equipamento_model_list: 
            db.session.delete(child)

        # osProdutoServicoModel
        for child in parent.os_produto_servico_model_list: 
            db.session.delete(child)

        # osEvolucaoModel
        for child in parent.os_evolucao_model_list: 
            db.session.delete(child)

