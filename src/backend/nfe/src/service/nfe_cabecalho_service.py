from src import db
from sqlalchemy import text
from src.model.nfe_cabecalho_model import NfeCabecalhoModel
from src.model.nfe_referenciada_model import NfeReferenciadaModel
from src.model.nfe_emitente_model import NfeEmitenteModel
from src.model.nfe_destinatario_model import NfeDestinatarioModel
from src.model.nfe_local_retirada_model import NfeLocalRetiradaModel
from src.model.nfe_local_entrega_model import NfeLocalEntregaModel
from src.model.nfe_transporte_model import NfeTransporteModel
from src.model.nfe_fatura_model import NfeFaturaModel
from src.model.nfe_cana_model import NfeCanaModel
from src.model.nfe_prod_rural_referenciada_model import NfeProdRuralReferenciadaModel
from src.model.nfe_nf_referenciada_model import NfeNfReferenciadaModel
from src.model.nfe_processo_referenciado_model import NfeProcessoReferenciadoModel
from src.model.nfe_acesso_xml_model import NfeAcessoXmlModel
from src.model.nfe_informacao_pagamento_model import NfeInformacaoPagamentoModel
from src.model.nfe_responsavel_tecnico_model import NfeResponsavelTecnicoModel
from src.model.nfe_cte_referenciado_model import NfeCteReferenciadoModel
from src.model.nfe_cupom_fiscal_referenciado_model import NfeCupomFiscalReferenciadoModel

class NfeCabecalhoService:
    def get_list(self):
        return NfeCabecalhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return NfeCabecalhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return NfeCabecalhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = NfeCabecalhoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = NfeCabecalhoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = NfeCabecalhoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # nfeReferenciadaModel
        children_data = data.get('nfeReferenciadaModelList', []) 
        for child_data in children_data:
            child = NfeReferenciadaModel()
            child.mapping(child_data)
            parent.nfe_referenciada_model_list.append(child)
            db.session.add(child)

        # nfeEmitenteModel
        children_data = data.get('nfeEmitenteModelList', []) 
        for child_data in children_data:
            child = NfeEmitenteModel()
            child.mapping(child_data)
            parent.nfe_emitente_model_list.append(child)
            db.session.add(child)

        # nfeDestinatarioModel
        children_data = data.get('nfeDestinatarioModelList', []) 
        for child_data in children_data:
            child = NfeDestinatarioModel()
            child.mapping(child_data)
            parent.nfe_destinatario_model_list.append(child)
            db.session.add(child)

        # nfeLocalRetiradaModel
        children_data = data.get('nfeLocalRetiradaModelList', []) 
        for child_data in children_data:
            child = NfeLocalRetiradaModel()
            child.mapping(child_data)
            parent.nfe_local_retirada_model_list.append(child)
            db.session.add(child)

        # nfeLocalEntregaModel
        children_data = data.get('nfeLocalEntregaModelList', []) 
        for child_data in children_data:
            child = NfeLocalEntregaModel()
            child.mapping(child_data)
            parent.nfe_local_entrega_model_list.append(child)
            db.session.add(child)

        # nfeTransporteModel
        children_data = data.get('nfeTransporteModelList', []) 
        for child_data in children_data:
            child = NfeTransporteModel()
            child.mapping(child_data)
            parent.nfe_transporte_model_list.append(child)
            db.session.add(child)

        # nfeFaturaModel
        children_data = data.get('nfeFaturaModelList', []) 
        for child_data in children_data:
            child = NfeFaturaModel()
            child.mapping(child_data)
            parent.nfe_fatura_model_list.append(child)
            db.session.add(child)

        # nfeCanaModel
        children_data = data.get('nfeCanaModelList', []) 
        for child_data in children_data:
            child = NfeCanaModel()
            child.mapping(child_data)
            parent.nfe_cana_model_list.append(child)
            db.session.add(child)

        # nfeProdRuralReferenciadaModel
        children_data = data.get('nfeProdRuralReferenciadaModelList', []) 
        for child_data in children_data:
            child = NfeProdRuralReferenciadaModel()
            child.mapping(child_data)
            parent.nfe_prod_rural_referenciada_model_list.append(child)
            db.session.add(child)

        # nfeNfReferenciadaModel
        children_data = data.get('nfeNfReferenciadaModelList', []) 
        for child_data in children_data:
            child = NfeNfReferenciadaModel()
            child.mapping(child_data)
            parent.nfe_nf_referenciada_model_list.append(child)
            db.session.add(child)

        # nfeProcessoReferenciadoModel
        children_data = data.get('nfeProcessoReferenciadoModelList', []) 
        for child_data in children_data:
            child = NfeProcessoReferenciadoModel()
            child.mapping(child_data)
            parent.nfe_processo_referenciado_model_list.append(child)
            db.session.add(child)

        # nfeAcessoXmlModel
        children_data = data.get('nfeAcessoXmlModelList', []) 
        for child_data in children_data:
            child = NfeAcessoXmlModel()
            child.mapping(child_data)
            parent.nfe_acesso_xml_model_list.append(child)
            db.session.add(child)

        # nfeInformacaoPagamentoModel
        children_data = data.get('nfeInformacaoPagamentoModelList', []) 
        for child_data in children_data:
            child = NfeInformacaoPagamentoModel()
            child.mapping(child_data)
            parent.nfe_informacao_pagamento_model_list.append(child)
            db.session.add(child)

        # nfeResponsavelTecnicoModel
        children_data = data.get('nfeResponsavelTecnicoModelList', []) 
        for child_data in children_data:
            child = NfeResponsavelTecnicoModel()
            child.mapping(child_data)
            parent.nfe_responsavel_tecnico_model_list.append(child)
            db.session.add(child)

        # nfeCteReferenciadoModel
        children_data = data.get('nfeCteReferenciadoModelList', []) 
        for child_data in children_data:
            child = NfeCteReferenciadoModel()
            child.mapping(child_data)
            parent.nfe_cte_referenciado_model_list.append(child)
            db.session.add(child)

        # nfeCupomFiscalReferenciadoModel
        children_data = data.get('nfeCupomFiscalReferenciadoModelList', []) 
        for child_data in children_data:
            child = NfeCupomFiscalReferenciadoModel()
            child.mapping(child_data)
            parent.nfe_cupom_fiscal_referenciado_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # nfeReferenciadaModel
        for child in parent.nfe_referenciada_model_list: 
            db.session.delete(child)

        # nfeEmitenteModel
        for child in parent.nfe_emitente_model_list: 
            db.session.delete(child)

        # nfeDestinatarioModel
        for child in parent.nfe_destinatario_model_list: 
            db.session.delete(child)

        # nfeLocalRetiradaModel
        for child in parent.nfe_local_retirada_model_list: 
            db.session.delete(child)

        # nfeLocalEntregaModel
        for child in parent.nfe_local_entrega_model_list: 
            db.session.delete(child)

        # nfeTransporteModel
        for child in parent.nfe_transporte_model_list: 
            db.session.delete(child)

        # nfeFaturaModel
        for child in parent.nfe_fatura_model_list: 
            db.session.delete(child)

        # nfeCanaModel
        for child in parent.nfe_cana_model_list: 
            db.session.delete(child)

        # nfeProdRuralReferenciadaModel
        for child in parent.nfe_prod_rural_referenciada_model_list: 
            db.session.delete(child)

        # nfeNfReferenciadaModel
        for child in parent.nfe_nf_referenciada_model_list: 
            db.session.delete(child)

        # nfeProcessoReferenciadoModel
        for child in parent.nfe_processo_referenciado_model_list: 
            db.session.delete(child)

        # nfeAcessoXmlModel
        for child in parent.nfe_acesso_xml_model_list: 
            db.session.delete(child)

        # nfeInformacaoPagamentoModel
        for child in parent.nfe_informacao_pagamento_model_list: 
            db.session.delete(child)

        # nfeResponsavelTecnicoModel
        for child in parent.nfe_responsavel_tecnico_model_list: 
            db.session.delete(child)

        # nfeCteReferenciadoModel
        for child in parent.nfe_cte_referenciado_model_list: 
            db.session.delete(child)

        # nfeCupomFiscalReferenciadoModel
        for child in parent.nfe_cupom_fiscal_referenciado_model_list: 
            db.session.delete(child)

