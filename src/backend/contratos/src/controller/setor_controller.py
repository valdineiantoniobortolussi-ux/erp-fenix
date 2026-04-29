from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.setor_service import SetorService

setor_bp = Blueprint('setor', __name__)
service = SetorService()

@setor_bp.route('/setor', methods=['GET'])
@setor_bp.route('/setor/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@setor_bp.route('/setor/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@setor_bp.route('/setor', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@setor_bp.route('/setor', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@setor_bp.route('/setor/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})