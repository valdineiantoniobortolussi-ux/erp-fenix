from src import db
from sqlalchemy import text
from src.model.mdfe_cabecalho_model import MdfeCabecalhoModel
from src.model.mdfe_lacre_model import MdfeLacreModel
from src.model.mdfe_municipio_descarrega_model import MdfeMunicipioDescarregaModel
from src.model.mdfe_emitente_model import MdfeEmitenteModel
from src.model.mdfe_percurso_model import MdfePercursoModel
from src.model.mdfe_municipio_carregamento_model import MdfeMunicipioCarregamentoModel
from src.model.mdfe_rodoviario_model import MdfeRodoviarioModel
from src.model.mdfe_informacao_seguro_model import MdfeInformacaoSeguroModel

class MdfeCabecalhoService:
    def get_list(self):
        return MdfeCabecalhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return MdfeCabecalhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return MdfeCabecalhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = MdfeCabecalhoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = MdfeCabecalhoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = MdfeCabecalhoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # mdfeLacreModel
        children_data = data.get('mdfeLacreModelList', []) 
        for child_data in children_data:
            child = MdfeLacreModel()
            child.mapping(child_data)
            parent.mdfe_lacre_model_list.append(child)
            db.session.add(child)

        # mdfeMunicipioDescarregaModel
        children_data = data.get('mdfeMunicipioDescarregaModelList', []) 
        for child_data in children_data:
            child = MdfeMunicipioDescarregaModel()
            child.mapping(child_data)
            parent.mdfe_municipio_descarrega_model_list.append(child)
            db.session.add(child)

        # mdfeEmitenteModel
        children_data = data.get('mdfeEmitenteModelList', []) 
        for child_data in children_data:
            child = MdfeEmitenteModel()
            child.mapping(child_data)
            parent.mdfe_emitente_model_list.append(child)
            db.session.add(child)

        # mdfePercursoModel
        children_data = data.get('mdfePercursoModelList', []) 
        for child_data in children_data:
            child = MdfePercursoModel()
            child.mapping(child_data)
            parent.mdfe_percurso_model_list.append(child)
            db.session.add(child)

        # mdfeMunicipioCarregamentoModel
        children_data = data.get('mdfeMunicipioCarregamentoModelList', []) 
        for child_data in children_data:
            child = MdfeMunicipioCarregamentoModel()
            child.mapping(child_data)
            parent.mdfe_municipio_carregamento_model_list.append(child)
            db.session.add(child)

        # mdfeRodoviarioModel
        children_data = data.get('mdfeRodoviarioModelList', []) 
        for child_data in children_data:
            child = MdfeRodoviarioModel()
            child.mapping(child_data)
            parent.mdfe_rodoviario_model_list.append(child)
            db.session.add(child)

        # mdfeInformacaoSeguroModel
        children_data = data.get('mdfeInformacaoSeguroModelList', []) 
        for child_data in children_data:
            child = MdfeInformacaoSeguroModel()
            child.mapping(child_data)
            parent.mdfe_informacao_seguro_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # mdfeLacreModel
        for child in parent.mdfe_lacre_model_list: 
            db.session.delete(child)

        # mdfeMunicipioDescarregaModel
        for child in parent.mdfe_municipio_descarrega_model_list: 
            db.session.delete(child)

        # mdfeEmitenteModel
        for child in parent.mdfe_emitente_model_list: 
            db.session.delete(child)

        # mdfePercursoModel
        for child in parent.mdfe_percurso_model_list: 
            db.session.delete(child)

        # mdfeMunicipioCarregamentoModel
        for child in parent.mdfe_municipio_carregamento_model_list: 
            db.session.delete(child)

        # mdfeRodoviarioModel
        for child in parent.mdfe_rodoviario_model_list: 
            db.session.delete(child)

        # mdfeInformacaoSeguroModel
        for child in parent.mdfe_informacao_seguro_model_list: 
            db.session.delete(child)

