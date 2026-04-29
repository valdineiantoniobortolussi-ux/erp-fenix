from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.fin_configuracao_boleto_service import FinConfiguracaoBoletoService

fin_configuracao_boleto_bp = Blueprint('fin-configuracao-boleto', __name__)
service = FinConfiguracaoBoletoService()

@fin_configuracao_boleto_bp.route('/fin-configuracao-boleto', methods=['GET'])
@fin_configuracao_boleto_bp.route('/fin-configuracao-boleto/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@fin_configuracao_boleto_bp.route('/fin-configuracao-boleto/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@fin_configuracao_boleto_bp.route('/fin-configuracao-boleto', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@fin_configuracao_boleto_bp.route('/fin-configuracao-boleto', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@fin_configuracao_boleto_bp.route('/fin-configuracao-boleto/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})