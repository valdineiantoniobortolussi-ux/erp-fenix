from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.ponto_fechamento_jornada_service import PontoFechamentoJornadaService

ponto_fechamento_jornada_bp = Blueprint('ponto-fechamento-jornada', __name__)
service = PontoFechamentoJornadaService()

@ponto_fechamento_jornada_bp.route('/ponto-fechamento-jornada', methods=['GET'])
@ponto_fechamento_jornada_bp.route('/ponto-fechamento-jornada/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@ponto_fechamento_jornada_bp.route('/ponto-fechamento-jornada/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@ponto_fechamento_jornada_bp.route('/ponto-fechamento-jornada', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@ponto_fechamento_jornada_bp.route('/ponto-fechamento-jornada', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@ponto_fechamento_jornada_bp.route('/ponto-fechamento-jornada/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})