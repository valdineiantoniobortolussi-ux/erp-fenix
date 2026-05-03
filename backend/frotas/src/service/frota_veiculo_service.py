from src import db
from sqlalchemy import text
from src.model.frota_veiculo_model import FrotaVeiculoModel
from src.model.frota_ipva_controle_model import FrotaIpvaControleModel
from src.model.frota_dpvat_controle_model import FrotaDpvatControleModel
from src.model.frota_veiculo_sinistro_model import FrotaVeiculoSinistroModel
from src.model.frota_veiculo_movimentacao_model import FrotaVeiculoMovimentacaoModel
from src.model.frota_veiculo_pneu_model import FrotaVeiculoPneuModel
from src.model.frota_veiculo_manutencao_model import FrotaVeiculoManutencaoModel
from src.model.frota_multa_controle_model import FrotaMultaControleModel
from src.model.frota_combustivel_controle_model import FrotaCombustivelControleModel

class FrotaVeiculoService:
    def get_list(self):
        return FrotaVeiculoModel.query.all()

    def get_list_filter(self, filter_obj):
        return FrotaVeiculoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FrotaVeiculoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FrotaVeiculoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FrotaVeiculoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FrotaVeiculoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # frotaIpvaControleModel
        children_data = data.get('frotaIpvaControleModelList', []) 
        for child_data in children_data:
            child = FrotaIpvaControleModel()
            child.mapping(child_data)
            parent.frota_ipva_controle_model_list.append(child)
            db.session.add(child)

        # frotaDpvatControleModel
        children_data = data.get('frotaDpvatControleModelList', []) 
        for child_data in children_data:
            child = FrotaDpvatControleModel()
            child.mapping(child_data)
            parent.frota_dpvat_controle_model_list.append(child)
            db.session.add(child)

        # frotaVeiculoSinistroModel
        children_data = data.get('frotaVeiculoSinistroModelList', []) 
        for child_data in children_data:
            child = FrotaVeiculoSinistroModel()
            child.mapping(child_data)
            parent.frota_veiculo_sinistro_model_list.append(child)
            db.session.add(child)

        # frotaVeiculoMovimentacaoModel
        children_data = data.get('frotaVeiculoMovimentacaoModelList', []) 
        for child_data in children_data:
            child = FrotaVeiculoMovimentacaoModel()
            child.mapping(child_data)
            parent.frota_veiculo_movimentacao_model_list.append(child)
            db.session.add(child)

        # frotaVeiculoPneuModel
        children_data = data.get('frotaVeiculoPneuModelList', []) 
        for child_data in children_data:
            child = FrotaVeiculoPneuModel()
            child.mapping(child_data)
            parent.frota_veiculo_pneu_model_list.append(child)
            db.session.add(child)

        # frotaVeiculoManutencaoModel
        children_data = data.get('frotaVeiculoManutencaoModelList', []) 
        for child_data in children_data:
            child = FrotaVeiculoManutencaoModel()
            child.mapping(child_data)
            parent.frota_veiculo_manutencao_model_list.append(child)
            db.session.add(child)

        # frotaMultaControleModel
        children_data = data.get('frotaMultaControleModelList', []) 
        for child_data in children_data:
            child = FrotaMultaControleModel()
            child.mapping(child_data)
            parent.frota_multa_controle_model_list.append(child)
            db.session.add(child)

        # frotaCombustivelControleModel
        children_data = data.get('frotaCombustivelControleModelList', []) 
        for child_data in children_data:
            child = FrotaCombustivelControleModel()
            child.mapping(child_data)
            parent.frota_combustivel_controle_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # frotaIpvaControleModel
        for child in parent.frota_ipva_controle_model_list: 
            db.session.delete(child)

        # frotaDpvatControleModel
        for child in parent.frota_dpvat_controle_model_list: 
            db.session.delete(child)

        # frotaVeiculoSinistroModel
        for child in parent.frota_veiculo_sinistro_model_list: 
            db.session.delete(child)

        # frotaVeiculoMovimentacaoModel
        for child in parent.frota_veiculo_movimentacao_model_list: 
            db.session.delete(child)

        # frotaVeiculoPneuModel
        for child in parent.frota_veiculo_pneu_model_list: 
            db.session.delete(child)

        # frotaVeiculoManutencaoModel
        for child in parent.frota_veiculo_manutencao_model_list: 
            db.session.delete(child)

        # frotaMultaControleModel
        for child in parent.frota_multa_controle_model_list: 
            db.session.delete(child)

        # frotaCombustivelControleModel
        for child in parent.frota_combustivel_controle_model_list: 
            db.session.delete(child)

