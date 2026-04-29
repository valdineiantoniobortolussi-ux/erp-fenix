from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.lanca_centro_resultado_service import LancaCentroResultadoService

lanca_centro_resultado_bp = Blueprint('lanca-centro-resultado', __name__)
service = LancaCentroResultadoService()

@lanca_centro_resultado_bp.route('/lanca-centro-resultado', methods=['GET'])
@lanca_centro_resultado_bp.route('/lanca-centro-resultado/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@lanca_centro_resultado_bp.route('/lanca-centro-resultado/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@lanca_centro_resultado_bp.route('/lanca-centro-resultado', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@lanca_centro_resultado_bp.route('/lanca-centro-resultado', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@lanca_centro_resultado_bp.route('/lanca-centro-resultado/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})