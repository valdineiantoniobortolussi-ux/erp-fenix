from src import db
from sqlalchemy import text
from src.model.patrim_bem_model import PatrimBemModel
from src.model.patrim_documento_bem_model import PatrimDocumentoBemModel
from src.model.patrim_depreciacao_bem_model import PatrimDepreciacaoBemModel
from src.model.patrim_movimentacao_bem_model import PatrimMovimentacaoBemModel
from src.model.patrim_apolice_seguro_model import PatrimApoliceSeguroModel

class PatrimBemService:
    def get_list(self):
        return PatrimBemModel.query.all()

    def get_list_filter(self, filter_obj):
        return PatrimBemModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PatrimBemModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PatrimBemModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PatrimBemModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PatrimBemModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # patrimDocumentoBemModel
        children_data = data.get('patrimDocumentoBemModelList', []) 
        for child_data in children_data:
            child = PatrimDocumentoBemModel()
            child.mapping(child_data)
            parent.patrim_documento_bem_model_list.append(child)
            db.session.add(child)

        # patrimDepreciacaoBemModel
        children_data = data.get('patrimDepreciacaoBemModelList', []) 
        for child_data in children_data:
            child = PatrimDepreciacaoBemModel()
            child.mapping(child_data)
            parent.patrim_depreciacao_bem_model_list.append(child)
            db.session.add(child)

        # patrimMovimentacaoBemModel
        children_data = data.get('patrimMovimentacaoBemModelList', []) 
        for child_data in children_data:
            child = PatrimMovimentacaoBemModel()
            child.mapping(child_data)
            parent.patrim_movimentacao_bem_model_list.append(child)
            db.session.add(child)

        # patrimApoliceSeguroModel
        children_data = data.get('patrimApoliceSeguroModelList', []) 
        for child_data in children_data:
            child = PatrimApoliceSeguroModel()
            child.mapping(child_data)
            parent.patrim_apolice_seguro_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # patrimDocumentoBemModel
        for child in parent.patrim_documento_bem_model_list: 
            db.session.delete(child)

        # patrimDepreciacaoBemModel
        for child in parent.patrim_depreciacao_bem_model_list: 
            db.session.delete(child)

        # patrimMovimentacaoBemModel
        for child in parent.patrim_movimentacao_bem_model_list: 
            db.session.delete(child)

        # patrimApoliceSeguroModel
        for child in parent.patrim_apolice_seguro_model_list: 
            db.session.delete(child)

