from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.banco_conta_caixa_service import BancoContaCaixaService

banco_conta_caixa_bp = Blueprint('banco-conta-caixa', __name__)
service = BancoContaCaixaService()

@banco_conta_caixa_bp.route('/banco-conta-caixa', methods=['GET'])
@banco_conta_caixa_bp.route('/banco-conta-caixa/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@banco_conta_caixa_bp.route('/banco-conta-caixa/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@banco_conta_caixa_bp.route('/banco-conta-caixa', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@banco_conta_caixa_bp.route('/banco-conta-caixa', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@banco_conta_caixa_bp.route('/banco-conta-caixa/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})