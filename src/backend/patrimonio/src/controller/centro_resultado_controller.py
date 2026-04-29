from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.centro_resultado_service import CentroResultadoService

centro_resultado_bp = Blueprint('centro-resultado', __name__)
service = CentroResultadoService()

@centro_resultado_bp.route('/centro-resultado', methods=['GET'])
@centro_resultado_bp.route('/centro-resultado/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@centro_resultado_bp.route('/centro-resultado/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@centro_resultado_bp.route('/centro-resultado', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@centro_resultado_bp.route('/centro-resultado', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@centro_resultado_bp.route('/centro-resultado/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})