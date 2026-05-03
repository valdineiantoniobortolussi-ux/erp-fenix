from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.fin_lancamento_receber_service import FinLancamentoReceberService

fin_lancamento_receber_bp = Blueprint('fin-lancamento-receber', __name__)
service = FinLancamentoReceberService()

@fin_lancamento_receber_bp.route('/fin-lancamento-receber', methods=['GET'])
@fin_lancamento_receber_bp.route('/fin-lancamento-receber/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@fin_lancamento_receber_bp.route('/fin-lancamento-receber/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@fin_lancamento_receber_bp.route('/fin-lancamento-receber', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@fin_lancamento_receber_bp.route('/fin-lancamento-receber', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@fin_lancamento_receber_bp.route('/fin-lancamento-receber/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})