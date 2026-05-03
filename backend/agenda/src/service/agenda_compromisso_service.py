from src import db
from sqlalchemy import text
from src.model.agenda_compromisso_model import AgendaCompromissoModel
from src.model.agenda_notificacao_model import AgendaNotificacaoModel
from src.model.agenda_compromisso_convidado_model import AgendaCompromissoConvidadoModel
from src.model.reuniao_sala_evento_model import ReuniaoSalaEventoModel

class AgendaCompromissoService:
    def get_list(self):
        return AgendaCompromissoModel.query.all()

    def get_list_filter(self, filter_obj):
        return AgendaCompromissoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return AgendaCompromissoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = AgendaCompromissoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = AgendaCompromissoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = AgendaCompromissoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # agendaNotificacaoModel
        children_data = data.get('agendaNotificacaoModelList', []) 
        for child_data in children_data:
            child = AgendaNotificacaoModel()
            child.mapping(child_data)
            parent.agenda_notificacao_model_list.append(child)
            db.session.add(child)

        # agendaCompromissoConvidadoModel
        children_data = data.get('agendaCompromissoConvidadoModelList', []) 
        for child_data in children_data:
            child = AgendaCompromissoConvidadoModel()
            child.mapping(child_data)
            parent.agenda_compromisso_convidado_model_list.append(child)
            db.session.add(child)

        # reuniaoSalaEventoModel
        children_data = data.get('reuniaoSalaEventoModelList', []) 
        for child_data in children_data:
            child = ReuniaoSalaEventoModel()
            child.mapping(child_data)
            parent.reuniao_sala_evento_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # agendaNotificacaoModel
        for child in parent.agenda_notificacao_model_list: 
            db.session.delete(child)

        # agendaCompromissoConvidadoModel
        for child in parent.agenda_compromisso_convidado_model_list: 
            db.session.delete(child)

        # reuniaoSalaEventoModel
        for child in parent.reuniao_sala_evento_model_list: 
            db.session.delete(child)

