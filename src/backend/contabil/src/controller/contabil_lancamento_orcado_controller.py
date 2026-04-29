from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.contabil_lancamento_orcado_service import ContabilLancamentoOrcadoService

contabil_lancamento_orcado_bp = Blueprint('contabil-lancamento-orcado', __name__)
service = ContabilLancamentoOrcadoService()

@contabil_lancamento_orcado_bp.route('/contabil-lancamento-orcado', methods=['GET'])
@contabil_lancamento_orcado_bp.route('/contabil-lancamento-orcado/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@contabil_lancamento_orcado_bp.route('/contabil-lancamento-orcado/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@contabil_lancamento_orcado_bp.route('/contabil-lancamento-orcado', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@contabil_lancamento_orcado_bp.route('/contabil-lancamento-orcado', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@contabil_lancamento_orcado_bp.route('/contabil-lancamento-orcado/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})