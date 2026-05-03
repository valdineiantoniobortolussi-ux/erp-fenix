from src import db
from sqlalchemy import text
from src.model.sefip_categoria_trabalho_model import SefipCategoriaTrabalhoModel

class SefipCategoriaTrabalhoService:
    def get_list(self):
        return SefipCategoriaTrabalhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return SefipCategoriaTrabalhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return SefipCategoriaTrabalhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = SefipCategoriaTrabalhoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = SefipCategoriaTrabalhoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = SefipCategoriaTrabalhoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()