from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.inss_service import InssService

inss_bp = Blueprint('inss', __name__)
service = InssService()

@inss_bp.route('/inss', methods=['GET'])
@inss_bp.route('/inss/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@inss_bp.route('/inss/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@inss_bp.route('/inss', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@inss_bp.route('/inss', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@inss_bp.route('/inss/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})