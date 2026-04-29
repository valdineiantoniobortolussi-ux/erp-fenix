from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.banco_agencia_service import BancoAgenciaService

banco_agencia_bp = Blueprint('banco-agencia', __name__)
service = BancoAgenciaService()

@banco_agencia_bp.route('/banco-agencia', methods=['GET'])
@banco_agencia_bp.route('/banco-agencia/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@banco_agencia_bp.route('/banco-agencia/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@banco_agencia_bp.route('/banco-agencia', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@banco_agencia_bp.route('/banco-agencia', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@banco_agencia_bp.route('/banco-agencia/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})