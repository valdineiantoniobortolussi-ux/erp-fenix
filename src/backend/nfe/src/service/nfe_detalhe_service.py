from src import db
from sqlalchemy import text
from src.model.nfe_detalhe_model import NfeDetalheModel
from src.model.nfe_det_especifico_veiculo_model import NfeDetEspecificoVeiculoModel
from src.model.nfe_det_especifico_medicamento_model import NfeDetEspecificoMedicamentoModel
from src.model.nfe_det_especifico_armamento_model import NfeDetEspecificoArmamentoModel
from src.model.nfe_det_especifico_combustivel_model import NfeDetEspecificoCombustivelModel
from src.model.nfe_declaracao_importacao_model import NfeDeclaracaoImportacaoModel
from src.model.nfe_detalhe_imposto_icms_model import NfeDetalheImpostoIcmsModel
from src.model.nfe_detalhe_imposto_ipi_model import NfeDetalheImpostoIpiModel
from src.model.nfe_detalhe_imposto_ii_model import NfeDetalheImpostoIiModel
from src.model.nfe_detalhe_imposto_pis_model import NfeDetalheImpostoPisModel
from src.model.nfe_detalhe_imposto_cofins_model import NfeDetalheImpostoCofinsModel
from src.model.nfe_detalhe_imposto_issqn_model import NfeDetalheImpostoIssqnModel
from src.model.nfe_exportacao_model import NfeExportacaoModel
from src.model.nfe_item_rastreado_model import NfeItemRastreadoModel
from src.model.nfe_detalhe_imposto_pis_st_model import NfeDetalheImpostoPisStModel
from src.model.nfe_detalhe_imposto_icms_ufdest_model import NfeDetalheImpostoIcmsUfdestModel
from src.model.nfe_detalhe_imposto_cofins_st_model import NfeDetalheImpostoCofinsStModel

class NfeDetalheService:
    def get_list(self):
        return NfeDetalheModel.query.all()

    def get_list_filter(self, filter_obj):
        return NfeDetalheModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return NfeDetalheModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = NfeDetalheModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = NfeDetalheModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = NfeDetalheModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # nfeDetEspecificoVeiculoModel
        children_data = data.get('nfeDetEspecificoVeiculoModelList', []) 
        for child_data in children_data:
            child = NfeDetEspecificoVeiculoModel()
            child.mapping(child_data)
            parent.nfe_det_especifico_veiculo_model_list.append(child)
            db.session.add(child)

        # nfeDetEspecificoMedicamentoModel
        children_data = data.get('nfeDetEspecificoMedicamentoModelList', []) 
        for child_data in children_data:
            child = NfeDetEspecificoMedicamentoModel()
            child.mapping(child_data)
            parent.nfe_det_especifico_medicamento_model_list.append(child)
            db.session.add(child)

        # nfeDetEspecificoArmamentoModel
        children_data = data.get('nfeDetEspecificoArmamentoModelList', []) 
        for child_data in children_data:
            child = NfeDetEspecificoArmamentoModel()
            child.mapping(child_data)
            parent.nfe_det_especifico_armamento_model_list.append(child)
            db.session.add(child)

        # nfeDetEspecificoCombustivelModel
        children_data = data.get('nfeDetEspecificoCombustivelModelList', []) 
        for child_data in children_data:
            child = NfeDetEspecificoCombustivelModel()
            child.mapping(child_data)
            parent.nfe_det_especifico_combustivel_model_list.append(child)
            db.session.add(child)

        # nfeDeclaracaoImportacaoModel
        children_data = data.get('nfeDeclaracaoImportacaoModelList', []) 
        for child_data in children_data:
            child = NfeDeclaracaoImportacaoModel()
            child.mapping(child_data)
            parent.nfe_declaracao_importacao_model_list.append(child)
            db.session.add(child)

        # nfeDetalheImpostoIcmsModel
        children_data = data.get('nfeDetalheImpostoIcmsModelList', []) 
        for child_data in children_data:
            child = NfeDetalheImpostoIcmsModel()
            child.mapping(child_data)
            parent.nfe_detalhe_imposto_icms_model_list.append(child)
            db.session.add(child)

        # nfeDetalheImpostoIpiModel
        children_data = data.get('nfeDetalheImpostoIpiModelList', []) 
        for child_data in children_data:
            child = NfeDetalheImpostoIpiModel()
            child.mapping(child_data)
            parent.nfe_detalhe_imposto_ipi_model_list.append(child)
            db.session.add(child)

        # nfeDetalheImpostoIiModel
        children_data = data.get('nfeDetalheImpostoIiModelList', []) 
        for child_data in children_data:
            child = NfeDetalheImpostoIiModel()
            child.mapping(child_data)
            parent.nfe_detalhe_imposto_ii_model_list.append(child)
            db.session.add(child)

        # nfeDetalheImpostoPisModel
        children_data = data.get('nfeDetalheImpostoPisModelList', []) 
        for child_data in children_data:
            child = NfeDetalheImpostoPisModel()
            child.mapping(child_data)
            parent.nfe_detalhe_imposto_pis_model_list.append(child)
            db.session.add(child)

        # nfeDetalheImpostoCofinsModel
        children_data = data.get('nfeDetalheImpostoCofinsModelList', []) 
        for child_data in children_data:
            child = NfeDetalheImpostoCofinsModel()
            child.mapping(child_data)
            parent.nfe_detalhe_imposto_cofins_model_list.append(child)
            db.session.add(child)

        # nfeDetalheImpostoIssqnModel
        children_data = data.get('nfeDetalheImpostoIssqnModelList', []) 
        for child_data in children_data:
            child = NfeDetalheImpostoIssqnModel()
            child.mapping(child_data)
            parent.nfe_detalhe_imposto_issqn_model_list.append(child)
            db.session.add(child)

        # nfeExportacaoModel
        children_data = data.get('nfeExportacaoModelList', []) 
        for child_data in children_data:
            child = NfeExportacaoModel()
            child.mapping(child_data)
            parent.nfe_exportacao_model_list.append(child)
            db.session.add(child)

        # nfeItemRastreadoModel
        children_data = data.get('nfeItemRastreadoModelList', []) 
        for child_data in children_data:
            child = NfeItemRastreadoModel()
            child.mapping(child_data)
            parent.nfe_item_rastreado_model_list.append(child)
            db.session.add(child)

        # nfeDetalheImpostoPisStModel
        children_data = data.get('nfeDetalheImpostoPisStModelList', []) 
        for child_data in children_data:
            child = NfeDetalheImpostoPisStModel()
            child.mapping(child_data)
            parent.nfe_detalhe_imposto_pis_st_model_list.append(child)
            db.session.add(child)

        # nfeDetalheImpostoIcmsUfdestModel
        children_data = data.get('nfeDetalheImpostoIcmsUfdestModelList', []) 
        for child_data in children_data:
            child = NfeDetalheImpostoIcmsUfdestModel()
            child.mapping(child_data)
            parent.nfe_detalhe_imposto_icms_ufdest_model_list.append(child)
            db.session.add(child)

        # nfeDetalheImpostoCofinsStModel
        children_data = data.get('nfeDetalheImpostoCofinsStModelList', []) 
        for child_data in children_data:
            child = NfeDetalheImpostoCofinsStModel()
            child.mapping(child_data)
            parent.nfe_detalhe_imposto_cofins_st_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # nfeDetEspecificoVeiculoModel
        for child in parent.nfe_det_especifico_veiculo_model_list: 
            db.session.delete(child)

        # nfeDetEspecificoMedicamentoModel
        for child in parent.nfe_det_especifico_medicamento_model_list: 
            db.session.delete(child)

        # nfeDetEspecificoArmamentoModel
        for child in parent.nfe_det_especifico_armamento_model_list: 
            db.session.delete(child)

        # nfeDetEspecificoCombustivelModel
        for child in parent.nfe_det_especifico_combustivel_model_list: 
            db.session.delete(child)

        # nfeDeclaracaoImportacaoModel
        for child in parent.nfe_declaracao_importacao_model_list: 
            db.session.delete(child)

        # nfeDetalheImpostoIcmsModel
        for child in parent.nfe_detalhe_imposto_icms_model_list: 
            db.session.delete(child)

        # nfeDetalheImpostoIpiModel
        for child in parent.nfe_detalhe_imposto_ipi_model_list: 
            db.session.delete(child)

        # nfeDetalheImpostoIiModel
        for child in parent.nfe_detalhe_imposto_ii_model_list: 
            db.session.delete(child)

        # nfeDetalheImpostoPisModel
        for child in parent.nfe_detalhe_imposto_pis_model_list: 
            db.session.delete(child)

        # nfeDetalheImpostoCofinsModel
        for child in parent.nfe_detalhe_imposto_cofins_model_list: 
            db.session.delete(child)

        # nfeDetalheImpostoIssqnModel
        for child in parent.nfe_detalhe_imposto_issqn_model_list: 
            db.session.delete(child)

        # nfeExportacaoModel
        for child in parent.nfe_exportacao_model_list: 
            db.session.delete(child)

        # nfeItemRastreadoModel
        for child in parent.nfe_item_rastreado_model_list: 
            db.session.delete(child)

        # nfeDetalheImpostoPisStModel
        for child in parent.nfe_detalhe_imposto_pis_st_model_list: 
            db.session.delete(child)

        # nfeDetalheImpostoIcmsUfdestModel
        for child in parent.nfe_detalhe_imposto_icms_ufdest_model_list: 
            db.session.delete(child)

        # nfeDetalheImpostoCofinsStModel
        for child in parent.nfe_detalhe_imposto_cofins_st_model_list: 
            db.session.delete(child)

