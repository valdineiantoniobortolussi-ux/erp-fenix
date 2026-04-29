from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.agenda_compromisso_service import AgendaCompromissoService

agenda_compromisso_bp = Blueprint('agenda-compromisso', __name__)
service = AgendaCompromissoService()

@agenda_compromisso_bp.route('/agenda-compromisso', methods=['GET'])
@agenda_compromisso_bp.route('/agenda-compromisso/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@agenda_compromisso_bp.route('/agenda-compromisso/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@agenda_compromisso_bp.route('/agenda-compromisso', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@agenda_compromisso_bp.route('/agenda-compromisso', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@agenda_compromisso_bp.route('/agenda-compromisso/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})