from src import db
from sqlalchemy import text
from src.model.nfe_cana_fornecimento_diario_model import NfeCanaFornecimentoDiarioModel

class NfeCanaFornecimentoDiarioService:
    def get_list(self):
        return NfeCanaFornecimentoDiarioModel.query.all()

    def get_list_filter(self, filter_obj):
        return NfeCanaFornecimentoDiarioModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return NfeCanaFornecimentoDiarioModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = NfeCanaFornecimentoDiarioModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = NfeCanaFornecimentoDiarioModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = NfeCanaFornecimentoDiarioModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()