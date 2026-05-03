from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.cnae_service import CnaeService

cnae_bp = Blueprint('cnae', __name__)
service = CnaeService()

@cnae_bp.route('/cnae', methods=['GET'])
@cnae_bp.route('/cnae/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@cnae_bp.route('/cnae/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@cnae_bp.route('/cnae', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@cnae_bp.route('/cnae', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@cnae_bp.route('/cnae/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})