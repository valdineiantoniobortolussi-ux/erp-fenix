from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.ncm_service import NcmService

ncm_bp = Blueprint('ncm', __name__)
service = NcmService()

@ncm_bp.route('/ncm', methods=['GET'])
@ncm_bp.route('/ncm/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@ncm_bp.route('/ncm/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@ncm_bp.route('/ncm', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@ncm_bp.route('/ncm', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@ncm_bp.route('/ncm/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})