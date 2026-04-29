from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.estado_civil_service import EstadoCivilService

estado_civil_bp = Blueprint('estado-civil', __name__)
service = EstadoCivilService()

@estado_civil_bp.route('/estado-civil', methods=['GET'])
@estado_civil_bp.route('/estado-civil/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@estado_civil_bp.route('/estado-civil/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@estado_civil_bp.route('/estado-civil', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@estado_civil_bp.route('/estado-civil', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@estado_civil_bp.route('/estado-civil/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})