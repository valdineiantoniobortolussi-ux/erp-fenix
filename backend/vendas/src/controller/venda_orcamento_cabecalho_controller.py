from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.venda_orcamento_cabecalho_service import VendaOrcamentoCabecalhoService

venda_orcamento_cabecalho_bp = Blueprint('venda-orcamento-cabecalho', __name__)
service = VendaOrcamentoCabecalhoService()

@venda_orcamento_cabecalho_bp.route('/venda-orcamento-cabecalho', methods=['GET'])
@venda_orcamento_cabecalho_bp.route('/venda-orcamento-cabecalho/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@venda_orcamento_cabecalho_bp.route('/venda-orcamento-cabecalho/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@venda_orcamento_cabecalho_bp.route('/venda-orcamento-cabecalho', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@venda_orcamento_cabecalho_bp.route('/venda-orcamento-cabecalho', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@venda_orcamento_cabecalho_bp.route('/venda-orcamento-cabecalho/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})