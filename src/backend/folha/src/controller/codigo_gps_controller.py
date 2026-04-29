from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.codigo_gps_service import CodigoGpsService

codigo_gps_bp = Blueprint('codigo-gps', __name__)
service = CodigoGpsService()

@codigo_gps_bp.route('/codigo-gps', methods=['GET'])
@codigo_gps_bp.route('/codigo-gps/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@codigo_gps_bp.route('/codigo-gps/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@codigo_gps_bp.route('/codigo-gps', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@codigo_gps_bp.route('/codigo-gps', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@codigo_gps_bp.route('/codigo-gps/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})