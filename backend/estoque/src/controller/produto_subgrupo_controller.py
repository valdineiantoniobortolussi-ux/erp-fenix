from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.produto_subgrupo_service import ProdutoSubgrupoService

produto_subgrupo_bp = Blueprint('produto-subgrupo', __name__)
service = ProdutoSubgrupoService()

@produto_subgrupo_bp.route('/produto-subgrupo', methods=['GET'])
@produto_subgrupo_bp.route('/produto-subgrupo/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@produto_subgrupo_bp.route('/produto-subgrupo/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@produto_subgrupo_bp.route('/produto-subgrupo', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@produto_subgrupo_bp.route('/produto-subgrupo', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@produto_subgrupo_bp.route('/produto-subgrupo/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})