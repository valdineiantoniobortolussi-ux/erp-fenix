from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.ponto_horario_service import PontoHorarioService

ponto_horario_bp = Blueprint('ponto-horario', __name__)
service = PontoHorarioService()

@ponto_horario_bp.route('/ponto-horario', methods=['GET'])
@ponto_horario_bp.route('/ponto-horario/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@ponto_horario_bp.route('/ponto-horario/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@ponto_horario_bp.route('/ponto-horario', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@ponto_horario_bp.route('/ponto-horario', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@ponto_horario_bp.route('/ponto-horario/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})