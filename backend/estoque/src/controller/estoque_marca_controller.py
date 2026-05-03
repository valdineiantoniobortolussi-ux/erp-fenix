from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.estoque_marca_service import EstoqueMarcaService

estoque_marca_bp = Blueprint('estoque-marca', __name__)
service = EstoqueMarcaService()

@estoque_marca_bp.route('/estoque-marca', methods=['GET'])
@estoque_marca_bp.route('/estoque-marca/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@estoque_marca_bp.route('/estoque-marca/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@estoque_marca_bp.route('/estoque-marca', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@estoque_marca_bp.route('/estoque-marca', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@estoque_marca_bp.route('/estoque-marca/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})