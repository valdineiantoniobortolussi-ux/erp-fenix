from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.compra_tipo_pedido_service import CompraTipoPedidoService

compra_tipo_pedido_bp = Blueprint('compra-tipo-pedido', __name__)
service = CompraTipoPedidoService()

@compra_tipo_pedido_bp.route('/compra-tipo-pedido', methods=['GET'])
@compra_tipo_pedido_bp.route('/compra-tipo-pedido/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@compra_tipo_pedido_bp.route('/compra-tipo-pedido/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@compra_tipo_pedido_bp.route('/compra-tipo-pedido', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@compra_tipo_pedido_bp.route('/compra-tipo-pedido', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@compra_tipo_pedido_bp.route('/compra-tipo-pedido/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})