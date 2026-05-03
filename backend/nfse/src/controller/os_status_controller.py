from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.os_status_service import OsStatusService

os_status_bp = Blueprint('os-status', __name__)
service = OsStatusService()

@os_status_bp.route('/os-status', methods=['GET'])
@os_status_bp.route('/os-status/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@os_status_bp.route('/os-status/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@os_status_bp.route('/os-status', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@os_status_bp.route('/os-status', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@os_status_bp.route('/os-status/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})