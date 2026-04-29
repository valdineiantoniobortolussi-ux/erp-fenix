from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.ponto_parametro_service import PontoParametroService

ponto_parametro_bp = Blueprint('ponto-parametro', __name__)
service = PontoParametroService()

@ponto_parametro_bp.route('/ponto-parametro', methods=['GET'])
@ponto_parametro_bp.route('/ponto-parametro/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@ponto_parametro_bp.route('/ponto-parametro/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@ponto_parametro_bp.route('/ponto-parametro', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@ponto_parametro_bp.route('/ponto-parametro', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@ponto_parametro_bp.route('/ponto-parametro/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})