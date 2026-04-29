from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.requisicao_interna_cabecalho_service import RequisicaoInternaCabecalhoService

requisicao_interna_cabecalho_bp = Blueprint('requisicao-interna-cabecalho', __name__)
service = RequisicaoInternaCabecalhoService()

@requisicao_interna_cabecalho_bp.route('/requisicao-interna-cabecalho', methods=['GET'])
@requisicao_interna_cabecalho_bp.route('/requisicao-interna-cabecalho/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@requisicao_interna_cabecalho_bp.route('/requisicao-interna-cabecalho/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@requisicao_interna_cabecalho_bp.route('/requisicao-interna-cabecalho', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@requisicao_interna_cabecalho_bp.route('/requisicao-interna-cabecalho', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@requisicao_interna_cabecalho_bp.route('/requisicao-interna-cabecalho/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})