from src import db
from sqlalchemy import text
from src.model.orcamento_fluxo_caixa_periodo_model import OrcamentoFluxoCaixaPeriodoModel

class OrcamentoFluxoCaixaPeriodoService:
    def get_list(self):
        return OrcamentoFluxoCaixaPeriodoModel.query.all()

    def get_list_filter(self, filter_obj):
        return OrcamentoFluxoCaixaPeriodoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return OrcamentoFluxoCaixaPeriodoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = OrcamentoFluxoCaixaPeriodoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = OrcamentoFluxoCaixaPeriodoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = OrcamentoFluxoCaixaPeriodoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()