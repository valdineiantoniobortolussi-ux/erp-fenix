from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.estoque_tamanho_service import EstoqueTamanhoService

estoque_tamanho_bp = Blueprint('estoque-tamanho', __name__)
service = EstoqueTamanhoService()

@estoque_tamanho_bp.route('/estoque-tamanho', methods=['GET'])
@estoque_tamanho_bp.route('/estoque-tamanho/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@estoque_tamanho_bp.route('/estoque-tamanho/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@estoque_tamanho_bp.route('/estoque-tamanho', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@estoque_tamanho_bp.route('/estoque-tamanho', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@estoque_tamanho_bp.route('/estoque-tamanho/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})