from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.cbo_service import CboService

cbo_bp = Blueprint('cbo', __name__)
service = CboService()

@cbo_bp.route('/cbo', methods=['GET'])
@cbo_bp.route('/cbo/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@cbo_bp.route('/cbo/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@cbo_bp.route('/cbo', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@cbo_bp.route('/cbo', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@cbo_bp.route('/cbo/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})