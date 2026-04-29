from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.municipio_service import MunicipioService

municipio_bp = Blueprint('municipio', __name__)
service = MunicipioService()

@municipio_bp.route('/municipio', methods=['GET'])
@municipio_bp.route('/municipio/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@municipio_bp.route('/municipio/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@municipio_bp.route('/municipio', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@municipio_bp.route('/municipio', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@municipio_bp.route('/municipio/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})