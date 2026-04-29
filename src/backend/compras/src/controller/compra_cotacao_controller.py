from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.compra_cotacao_service import CompraCotacaoService

compra_cotacao_bp = Blueprint('compra-cotacao', __name__)
service = CompraCotacaoService()

@compra_cotacao_bp.route('/compra-cotacao', methods=['GET'])
@compra_cotacao_bp.route('/compra-cotacao/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@compra_cotacao_bp.route('/compra-cotacao/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@compra_cotacao_bp.route('/compra-cotacao', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@compra_cotacao_bp.route('/compra-cotacao', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@compra_cotacao_bp.route('/compra-cotacao/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})