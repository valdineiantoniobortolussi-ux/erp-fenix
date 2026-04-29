from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.compra_requisicao_service import CompraRequisicaoService

compra_requisicao_bp = Blueprint('compra-requisicao', __name__)
service = CompraRequisicaoService()

@compra_requisicao_bp.route('/compra-requisicao', methods=['GET'])
@compra_requisicao_bp.route('/compra-requisicao/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@compra_requisicao_bp.route('/compra-requisicao/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@compra_requisicao_bp.route('/compra-requisicao', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@compra_requisicao_bp.route('/compra-requisicao', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@compra_requisicao_bp.route('/compra-requisicao/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})