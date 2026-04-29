from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.fap_service import FapService

fap_bp = Blueprint('fap', __name__)
service = FapService()

@fap_bp.route('/fap', methods=['GET'])
@fap_bp.route('/fap/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@fap_bp.route('/fap/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@fap_bp.route('/fap', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@fap_bp.route('/fap', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@fap_bp.route('/fap/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})