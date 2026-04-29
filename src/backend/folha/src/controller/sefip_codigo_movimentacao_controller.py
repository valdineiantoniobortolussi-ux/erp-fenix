from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.sefip_codigo_movimentacao_service import SefipCodigoMovimentacaoService

sefip_codigo_movimentacao_bp = Blueprint('sefip-codigo-movimentacao', __name__)
service = SefipCodigoMovimentacaoService()

@sefip_codigo_movimentacao_bp.route('/sefip-codigo-movimentacao', methods=['GET'])
@sefip_codigo_movimentacao_bp.route('/sefip-codigo-movimentacao/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@sefip_codigo_movimentacao_bp.route('/sefip-codigo-movimentacao/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@sefip_codigo_movimentacao_bp.route('/sefip-codigo-movimentacao', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@sefip_codigo_movimentacao_bp.route('/sefip-codigo-movimentacao', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@sefip_codigo_movimentacao_bp.route('/sefip-codigo-movimentacao/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})