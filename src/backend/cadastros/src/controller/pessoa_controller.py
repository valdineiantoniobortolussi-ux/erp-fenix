from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.pessoa_service import PessoaService

pessoa_bp = Blueprint('pessoa', __name__)
service = PessoaService()

@pessoa_bp.route('/pessoa', methods=['GET'])
@pessoa_bp.route('/pessoa/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@pessoa_bp.route('/pessoa/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@pessoa_bp.route('/pessoa', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@pessoa_bp.route('/pessoa', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@pessoa_bp.route('/pessoa/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})