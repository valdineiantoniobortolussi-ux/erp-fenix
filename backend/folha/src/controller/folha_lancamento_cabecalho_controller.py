from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.folha_lancamento_cabecalho_service import FolhaLancamentoCabecalhoService

folha_lancamento_cabecalho_bp = Blueprint('folha-lancamento-cabecalho', __name__)
service = FolhaLancamentoCabecalhoService()

@folha_lancamento_cabecalho_bp.route('/folha-lancamento-cabecalho', methods=['GET'])
@folha_lancamento_cabecalho_bp.route('/folha-lancamento-cabecalho/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@folha_lancamento_cabecalho_bp.route('/folha-lancamento-cabecalho/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@folha_lancamento_cabecalho_bp.route('/folha-lancamento-cabecalho', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@folha_lancamento_cabecalho_bp.route('/folha-lancamento-cabecalho', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@folha_lancamento_cabecalho_bp.route('/folha-lancamento-cabecalho/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})