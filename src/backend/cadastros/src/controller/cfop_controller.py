from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.cfop_service import CfopService

cfop_bp = Blueprint('cfop', __name__)
service = CfopService()

@cfop_bp.route('/cfop', methods=['GET'])
@cfop_bp.route('/cfop/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@cfop_bp.route('/cfop/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@cfop_bp.route('/cfop', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@cfop_bp.route('/cfop', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@cfop_bp.route('/cfop/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})