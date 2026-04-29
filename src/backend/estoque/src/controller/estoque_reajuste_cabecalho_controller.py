from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.estoque_reajuste_cabecalho_service import EstoqueReajusteCabecalhoService

estoque_reajuste_cabecalho_bp = Blueprint('estoque-reajuste-cabecalho', __name__)
service = EstoqueReajusteCabecalhoService()

@estoque_reajuste_cabecalho_bp.route('/estoque-reajuste-cabecalho', methods=['GET'])
@estoque_reajuste_cabecalho_bp.route('/estoque-reajuste-cabecalho/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@estoque_reajuste_cabecalho_bp.route('/estoque-reajuste-cabecalho/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@estoque_reajuste_cabecalho_bp.route('/estoque-reajuste-cabecalho', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@estoque_reajuste_cabecalho_bp.route('/estoque-reajuste-cabecalho', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@estoque_reajuste_cabecalho_bp.route('/estoque-reajuste-cabecalho/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})