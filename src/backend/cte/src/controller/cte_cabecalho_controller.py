from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.cte_cabecalho_service import CteCabecalhoService

cte_cabecalho_bp = Blueprint('cte-cabecalho', __name__)
service = CteCabecalhoService()

@cte_cabecalho_bp.route('/cte-cabecalho', methods=['GET'])
@cte_cabecalho_bp.route('/cte-cabecalho/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@cte_cabecalho_bp.route('/cte-cabecalho/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@cte_cabecalho_bp.route('/cte-cabecalho', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@cte_cabecalho_bp.route('/cte-cabecalho', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@cte_cabecalho_bp.route('/cte-cabecalho/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})