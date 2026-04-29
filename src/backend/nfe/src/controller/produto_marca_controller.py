from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.produto_marca_service import ProdutoMarcaService

produto_marca_bp = Blueprint('produto-marca', __name__)
service = ProdutoMarcaService()

@produto_marca_bp.route('/produto-marca', methods=['GET'])
@produto_marca_bp.route('/produto-marca/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@produto_marca_bp.route('/produto-marca/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@produto_marca_bp.route('/produto-marca', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@produto_marca_bp.route('/produto-marca', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@produto_marca_bp.route('/produto-marca/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})