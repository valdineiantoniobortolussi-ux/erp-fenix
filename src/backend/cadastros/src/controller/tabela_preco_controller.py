from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.tabela_preco_service import TabelaPrecoService

tabela_preco_bp = Blueprint('tabela-preco', __name__)
service = TabelaPrecoService()

@tabela_preco_bp.route('/tabela-preco', methods=['GET'])
@tabela_preco_bp.route('/tabela-preco/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@tabela_preco_bp.route('/tabela-preco/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@tabela_preco_bp.route('/tabela-preco', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@tabela_preco_bp.route('/tabela-preco', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@tabela_preco_bp.route('/tabela-preco/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})