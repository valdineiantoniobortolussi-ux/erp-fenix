from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.contabil_lancamento_padrao_service import ContabilLancamentoPadraoService

contabil_lancamento_padrao_bp = Blueprint('contabil-lancamento-padrao', __name__)
service = ContabilLancamentoPadraoService()

@contabil_lancamento_padrao_bp.route('/contabil-lancamento-padrao', methods=['GET'])
@contabil_lancamento_padrao_bp.route('/contabil-lancamento-padrao/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@contabil_lancamento_padrao_bp.route('/contabil-lancamento-padrao/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@contabil_lancamento_padrao_bp.route('/contabil-lancamento-padrao', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@contabil_lancamento_padrao_bp.route('/contabil-lancamento-padrao', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@contabil_lancamento_padrao_bp.route('/contabil-lancamento-padrao/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})