from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.ponto_horario_autorizado_service import PontoHorarioAutorizadoService

ponto_horario_autorizado_bp = Blueprint('ponto-horario-autorizado', __name__)
service = PontoHorarioAutorizadoService()

@ponto_horario_autorizado_bp.route('/ponto-horario-autorizado', methods=['GET'])
@ponto_horario_autorizado_bp.route('/ponto-horario-autorizado/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@ponto_horario_autorizado_bp.route('/ponto-horario-autorizado/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@ponto_horario_autorizado_bp.route('/ponto-horario-autorizado', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@ponto_horario_autorizado_bp.route('/ponto-horario-autorizado', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@ponto_horario_autorizado_bp.route('/ponto-horario-autorizado/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})