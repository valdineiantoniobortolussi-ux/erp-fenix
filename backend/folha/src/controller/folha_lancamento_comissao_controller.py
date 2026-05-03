from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.folha_lancamento_comissao_service import FolhaLancamentoComissaoService

folha_lancamento_comissao_bp = Blueprint('folha-lancamento-comissao', __name__)
service = FolhaLancamentoComissaoService()

@folha_lancamento_comissao_bp.route('/folha-lancamento-comissao', methods=['GET'])
@folha_lancamento_comissao_bp.route('/folha-lancamento-comissao/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@folha_lancamento_comissao_bp.route('/folha-lancamento-comissao/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@folha_lancamento_comissao_bp.route('/folha-lancamento-comissao', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@folha_lancamento_comissao_bp.route('/folha-lancamento-comissao', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@folha_lancamento_comissao_bp.route('/folha-lancamento-comissao/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})