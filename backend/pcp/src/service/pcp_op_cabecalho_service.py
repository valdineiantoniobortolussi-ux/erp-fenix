from src import db
from sqlalchemy import text
from src.model.pcp_op_cabecalho_model import PcpOpCabecalhoModel
from src.model.pcp_op_detalhe_model import PcpOpDetalheModel
from src.model.pcp_instrucao_op_model import PcpInstrucaoOpModel

class PcpOpCabecalhoService:
    def get_list(self):
        return PcpOpCabecalhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return PcpOpCabecalhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PcpOpCabecalhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PcpOpCabecalhoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PcpOpCabecalhoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PcpOpCabecalhoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # pcpOpDetalheModel
        children_data = data.get('pcpOpDetalheModelList', []) 
        for child_data in children_data:
            child = PcpOpDetalheModel()
            child.mapping(child_data)
            parent.pcp_op_detalhe_model_list.append(child)
            db.session.add(child)

        # pcpInstrucaoOpModel
        children_data = data.get('pcpInstrucaoOpModelList', []) 
        for child_data in children_data:
            child = PcpInstrucaoOpModel()
            child.mapping(child_data)
            parent.pcp_instrucao_op_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # pcpOpDetalheModel
        for child in parent.pcp_op_detalhe_model_list: 
            db.session.delete(child)

        # pcpInstrucaoOpModel
        for child in parent.pcp_instrucao_op_model_list: 
            db.session.delete(child)

