from src import db
from sqlalchemy import text
from src.model.pcp_servico_model import PcpServicoModel
from src.model.pcp_servico_colaborador_model import PcpServicoColaboradorModel
from src.model.pcp_servico_equipamento_model import PcpServicoEquipamentoModel

class PcpServicoService:
    def get_list(self):
        return PcpServicoModel.query.all()

    def get_list_filter(self, filter_obj):
        return PcpServicoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PcpServicoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PcpServicoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PcpServicoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PcpServicoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # pcpServicoColaboradorModel
        children_data = data.get('pcpServicoColaboradorModelList', []) 
        for child_data in children_data:
            child = PcpServicoColaboradorModel()
            child.mapping(child_data)
            parent.pcp_servico_colaborador_model_list.append(child)
            db.session.add(child)

        # pcpServicoEquipamentoModel
        children_data = data.get('pcpServicoEquipamentoModelList', []) 
        for child_data in children_data:
            child = PcpServicoEquipamentoModel()
            child.mapping(child_data)
            parent.pcp_servico_equipamento_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # pcpServicoColaboradorModel
        for child in parent.pcp_servico_colaborador_model_list: 
            db.session.delete(child)

        # pcpServicoEquipamentoModel
        for child in parent.pcp_servico_equipamento_model_list: 
            db.session.delete(child)

