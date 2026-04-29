from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.ponto_banco_horas_service import PontoBancoHorasService

ponto_banco_horas_bp = Blueprint('ponto-banco-horas', __name__)
service = PontoBancoHorasService()

@ponto_banco_horas_bp.route('/ponto-banco-horas', methods=['GET'])
@ponto_banco_horas_bp.route('/ponto-banco-horas/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@ponto_banco_horas_bp.route('/ponto-banco-horas/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@ponto_banco_horas_bp.route('/ponto-banco-horas', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@ponto_banco_horas_bp.route('/ponto-banco-horas', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@ponto_banco_horas_bp.route('/ponto-banco-horas/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})