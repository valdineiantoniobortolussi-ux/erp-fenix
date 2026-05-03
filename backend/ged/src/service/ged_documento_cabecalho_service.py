from src import db
from sqlalchemy import text
from src.model.ged_documento_cabecalho_model import GedDocumentoCabecalhoModel
from src.model.ged_documento_detalhe_model import GedDocumentoDetalheModel

class GedDocumentoCabecalhoService:
    def get_list(self):
        return GedDocumentoCabecalhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return GedDocumentoCabecalhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return GedDocumentoCabecalhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = GedDocumentoCabecalhoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = GedDocumentoCabecalhoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = GedDocumentoCabecalhoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # gedDocumentoDetalheModel
        children_data = data.get('gedDocumentoDetalheModelList', []) 
        for child_data in children_data:
            child = GedDocumentoDetalheModel()
            child.mapping(child_data)
            parent.ged_documento_detalhe_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # gedDocumentoDetalheModel
        for child in parent.ged_documento_detalhe_model_list: 
            db.session.delete(child)

