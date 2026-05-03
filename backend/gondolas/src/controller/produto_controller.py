from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.produto_service import ProdutoService

produto_bp = Blueprint('produto', __name__)
service = ProdutoService()

@produto_bp.route('/produto', methods=['GET'])
@produto_bp.route('/produto/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@produto_bp.route('/produto/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@produto_bp.route('/produto', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@produto_bp.route('/produto', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@produto_bp.route('/produto/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})