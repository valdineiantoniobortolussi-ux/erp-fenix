from src import db
from sqlalchemy import text
from src.model.cte_cabecalho_model import CteCabecalhoModel
from src.model.cte_emitente_model import CteEmitenteModel
from src.model.cte_local_coleta_model import CteLocalColetaModel
from src.model.cte_tomador_model import CteTomadorModel
from src.model.cte_passagem_model import CtePassagemModel
from src.model.cte_remetente_model import CteRemetenteModel
from src.model.cte_expedidor_model import CteExpedidorModel
from src.model.cte_recebedor_model import CteRecebedorModel
from src.model.cte_destinatario_model import CteDestinatarioModel
from src.model.cte_local_entrega_model import CteLocalEntregaModel
from src.model.cte_componente_model import CteComponenteModel
from src.model.cte_carga_model import CteCargaModel
from src.model.cte_informacao_nf_outros_model import CteInformacaoNfOutrosModel
from src.model.cte_seguro_model import CteSeguroModel
from src.model.cte_perigoso_model import CtePerigosoModel
from src.model.cte_veiculo_novo_model import CteVeiculoNovoModel
from src.model.cte_fatura_model import CteFaturaModel
from src.model.cte_duplicata_model import CteDuplicataModel
from src.model.cte_rodoviario_model import CteRodoviarioModel
from src.model.cte_aereo_model import CteAereoModel
from src.model.cte_aquaviario_model import CteAquaviarioModel
from src.model.cte_ferroviario_model import CteFerroviarioModel
from src.model.cte_dutoviario_model import CteDutoviarioModel
from src.model.cte_multimodal_model import CteMultimodalModel

class CteCabecalhoService:
    def get_list(self):
        return CteCabecalhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return CteCabecalhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CteCabecalhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CteCabecalhoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CteCabecalhoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CteCabecalhoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # cteEmitenteModel
        children_data = data.get('cteEmitenteModelList', []) 
        for child_data in children_data:
            child = CteEmitenteModel()
            child.mapping(child_data)
            parent.cte_emitente_model_list.append(child)
            db.session.add(child)

        # cteLocalColetaModel
        children_data = data.get('cteLocalColetaModelList', []) 
        for child_data in children_data:
            child = CteLocalColetaModel()
            child.mapping(child_data)
            parent.cte_local_coleta_model_list.append(child)
            db.session.add(child)

        # cteTomadorModel
        children_data = data.get('cteTomadorModelList', []) 
        for child_data in children_data:
            child = CteTomadorModel()
            child.mapping(child_data)
            parent.cte_tomador_model_list.append(child)
            db.session.add(child)

        # ctePassagemModel
        children_data = data.get('ctePassagemModelList', []) 
        for child_data in children_data:
            child = CtePassagemModel()
            child.mapping(child_data)
            parent.cte_passagem_model_list.append(child)
            db.session.add(child)

        # cteRemetenteModel
        children_data = data.get('cteRemetenteModelList', []) 
        for child_data in children_data:
            child = CteRemetenteModel()
            child.mapping(child_data)
            parent.cte_remetente_model_list.append(child)
            db.session.add(child)

        # cteExpedidorModel
        children_data = data.get('cteExpedidorModelList', []) 
        for child_data in children_data:
            child = CteExpedidorModel()
            child.mapping(child_data)
            parent.cte_expedidor_model_list.append(child)
            db.session.add(child)

        # cteRecebedorModel
        children_data = data.get('cteRecebedorModelList', []) 
        for child_data in children_data:
            child = CteRecebedorModel()
            child.mapping(child_data)
            parent.cte_recebedor_model_list.append(child)
            db.session.add(child)

        # cteDestinatarioModel
        children_data = data.get('cteDestinatarioModelList', []) 
        for child_data in children_data:
            child = CteDestinatarioModel()
            child.mapping(child_data)
            parent.cte_destinatario_model_list.append(child)
            db.session.add(child)

        # cteLocalEntregaModel
        children_data = data.get('cteLocalEntregaModelList', []) 
        for child_data in children_data:
            child = CteLocalEntregaModel()
            child.mapping(child_data)
            parent.cte_local_entrega_model_list.append(child)
            db.session.add(child)

        # cteComponenteModel
        children_data = data.get('cteComponenteModelList', []) 
        for child_data in children_data:
            child = CteComponenteModel()
            child.mapping(child_data)
            parent.cte_componente_model_list.append(child)
            db.session.add(child)

        # cteCargaModel
        children_data = data.get('cteCargaModelList', []) 
        for child_data in children_data:
            child = CteCargaModel()
            child.mapping(child_data)
            parent.cte_carga_model_list.append(child)
            db.session.add(child)

        # cteInformacaoNfOutrosModel
        children_data = data.get('cteInformacaoNfOutrosModelList', []) 
        for child_data in children_data:
            child = CteInformacaoNfOutrosModel()
            child.mapping(child_data)
            parent.cte_informacao_nf_outros_model_list.append(child)
            db.session.add(child)

        # cteSeguroModel
        children_data = data.get('cteSeguroModelList', []) 
        for child_data in children_data:
            child = CteSeguroModel()
            child.mapping(child_data)
            parent.cte_seguro_model_list.append(child)
            db.session.add(child)

        # ctePerigosoModel
        children_data = data.get('ctePerigosoModelList', []) 
        for child_data in children_data:
            child = CtePerigosoModel()
            child.mapping(child_data)
            parent.cte_perigoso_model_list.append(child)
            db.session.add(child)

        # cteVeiculoNovoModel
        children_data = data.get('cteVeiculoNovoModelList', []) 
        for child_data in children_data:
            child = CteVeiculoNovoModel()
            child.mapping(child_data)
            parent.cte_veiculo_novo_model_list.append(child)
            db.session.add(child)

        # cteFaturaModel
        children_data = data.get('cteFaturaModelList', []) 
        for child_data in children_data:
            child = CteFaturaModel()
            child.mapping(child_data)
            parent.cte_fatura_model_list.append(child)
            db.session.add(child)

        # cteDuplicataModel
        children_data = data.get('cteDuplicataModelList', []) 
        for child_data in children_data:
            child = CteDuplicataModel()
            child.mapping(child_data)
            parent.cte_duplicata_model_list.append(child)
            db.session.add(child)

        # cteRodoviarioModel
        children_data = data.get('cteRodoviarioModelList', []) 
        for child_data in children_data:
            child = CteRodoviarioModel()
            child.mapping(child_data)
            parent.cte_rodoviario_model_list.append(child)
            db.session.add(child)

        # cteAereoModel
        children_data = data.get('cteAereoModelList', []) 
        for child_data in children_data:
            child = CteAereoModel()
            child.mapping(child_data)
            parent.cte_aereo_model_list.append(child)
            db.session.add(child)

        # cteAquaviarioModel
        children_data = data.get('cteAquaviarioModelList', []) 
        for child_data in children_data:
            child = CteAquaviarioModel()
            child.mapping(child_data)
            parent.cte_aquaviario_model_list.append(child)
            db.session.add(child)

        # cteFerroviarioModel
        children_data = data.get('cteFerroviarioModelList', []) 
        for child_data in children_data:
            child = CteFerroviarioModel()
            child.mapping(child_data)
            parent.cte_ferroviario_model_list.append(child)
            db.session.add(child)

        # cteDutoviarioModel
        children_data = data.get('cteDutoviarioModelList', []) 
        for child_data in children_data:
            child = CteDutoviarioModel()
            child.mapping(child_data)
            parent.cte_dutoviario_model_list.append(child)
            db.session.add(child)

        # cteMultimodalModel
        children_data = data.get('cteMultimodalModelList', []) 
        for child_data in children_data:
            child = CteMultimodalModel()
            child.mapping(child_data)
            parent.cte_multimodal_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # cteEmitenteModel
        for child in parent.cte_emitente_model_list: 
            db.session.delete(child)

        # cteLocalColetaModel
        for child in parent.cte_local_coleta_model_list: 
            db.session.delete(child)

        # cteTomadorModel
        for child in parent.cte_tomador_model_list: 
            db.session.delete(child)

        # ctePassagemModel
        for child in parent.cte_passagem_model_list: 
            db.session.delete(child)

        # cteRemetenteModel
        for child in parent.cte_remetente_model_list: 
            db.session.delete(child)

        # cteExpedidorModel
        for child in parent.cte_expedidor_model_list: 
            db.session.delete(child)

        # cteRecebedorModel
        for child in parent.cte_recebedor_model_list: 
            db.session.delete(child)

        # cteDestinatarioModel
        for child in parent.cte_destinatario_model_list: 
            db.session.delete(child)

        # cteLocalEntregaModel
        for child in parent.cte_local_entrega_model_list: 
            db.session.delete(child)

        # cteComponenteModel
        for child in parent.cte_componente_model_list: 
            db.session.delete(child)

        # cteCargaModel
        for child in parent.cte_carga_model_list: 
            db.session.delete(child)

        # cteInformacaoNfOutrosModel
        for child in parent.cte_informacao_nf_outros_model_list: 
            db.session.delete(child)

        # cteSeguroModel
        for child in parent.cte_seguro_model_list: 
            db.session.delete(child)

        # ctePerigosoModel
        for child in parent.cte_perigoso_model_list: 
            db.session.delete(child)

        # cteVeiculoNovoModel
        for child in parent.cte_veiculo_novo_model_list: 
            db.session.delete(child)

        # cteFaturaModel
        for child in parent.cte_fatura_model_list: 
            db.session.delete(child)

        # cteDuplicataModel
        for child in parent.cte_duplicata_model_list: 
            db.session.delete(child)

        # cteRodoviarioModel
        for child in parent.cte_rodoviario_model_list: 
            db.session.delete(child)

        # cteAereoModel
        for child in parent.cte_aereo_model_list: 
            db.session.delete(child)

        # cteAquaviarioModel
        for child in parent.cte_aquaviario_model_list: 
            db.session.delete(child)

        # cteFerroviarioModel
        for child in parent.cte_ferroviario_model_list: 
            db.session.delete(child)

        # cteDutoviarioModel
        for child in parent.cte_dutoviario_model_list: 
            db.session.delete(child)

        # cteMultimodalModel
        for child in parent.cte_multimodal_model_list: 
            db.session.delete(child)

