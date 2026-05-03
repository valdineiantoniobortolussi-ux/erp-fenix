from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.tribut_operacao_fiscal_service import TributOperacaoFiscalService

tribut_operacao_fiscal_bp = Blueprint('tribut-operacao-fiscal', __name__)
service = TributOperacaoFiscalService()

@tribut_operacao_fiscal_bp.route('/tribut-operacao-fiscal', methods=['GET'])
@tribut_operacao_fiscal_bp.route('/tribut-operacao-fiscal/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@tribut_operacao_fiscal_bp.route('/tribut-operacao-fiscal/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@tribut_operacao_fiscal_bp.route('/tribut-operacao-fiscal', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@tribut_operacao_fiscal_bp.route('/tribut-operacao-fiscal', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@tribut_operacao_fiscal_bp.route('/tribut-operacao-fiscal/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})