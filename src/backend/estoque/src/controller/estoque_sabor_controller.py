from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.estoque_sabor_service import EstoqueSaborService

estoque_sabor_bp = Blueprint('estoque-sabor', __name__)
service = EstoqueSaborService()

@estoque_sabor_bp.route('/estoque-sabor', methods=['GET'])
@estoque_sabor_bp.route('/estoque-sabor/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@estoque_sabor_bp.route('/estoque-sabor/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@estoque_sabor_bp.route('/estoque-sabor', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@estoque_sabor_bp.route('/estoque-sabor', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@estoque_sabor_bp.route('/estoque-sabor/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})