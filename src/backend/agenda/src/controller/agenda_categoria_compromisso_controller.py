from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.agenda_categoria_compromisso_service import AgendaCategoriaCompromissoService

agenda_categoria_compromisso_bp = Blueprint('agenda-categoria-compromisso', __name__)
service = AgendaCategoriaCompromissoService()

@agenda_categoria_compromisso_bp.route('/agenda-categoria-compromisso', methods=['GET'])
@agenda_categoria_compromisso_bp.route('/agenda-categoria-compromisso/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@agenda_categoria_compromisso_bp.route('/agenda-categoria-compromisso/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@agenda_categoria_compromisso_bp.route('/agenda-categoria-compromisso', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@agenda_categoria_compromisso_bp.route('/agenda-categoria-compromisso', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@agenda_categoria_compromisso_bp.route('/agenda-categoria-compromisso/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})