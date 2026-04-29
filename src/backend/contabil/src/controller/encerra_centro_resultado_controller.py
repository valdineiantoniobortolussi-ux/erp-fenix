from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.encerra_centro_resultado_service import EncerraCentroResultadoService

encerra_centro_resultado_bp = Blueprint('encerra-centro-resultado', __name__)
service = EncerraCentroResultadoService()

@encerra_centro_resultado_bp.route('/encerra-centro-resultado', methods=['GET'])
@encerra_centro_resultado_bp.route('/encerra-centro-resultado/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@encerra_centro_resultado_bp.route('/encerra-centro-resultado/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@encerra_centro_resultado_bp.route('/encerra-centro-resultado', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@encerra_centro_resultado_bp.route('/encerra-centro-resultado', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@encerra_centro_resultado_bp.route('/encerra-centro-resultado/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})