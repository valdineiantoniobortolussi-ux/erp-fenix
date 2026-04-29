from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.cep_service import CepService

cep_bp = Blueprint('cep', __name__)
service = CepService()

@cep_bp.route('/cep', methods=['GET'])
@cep_bp.route('/cep/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@cep_bp.route('/cep/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@cep_bp.route('/cep', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@cep_bp.route('/cep', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@cep_bp.route('/cep/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})