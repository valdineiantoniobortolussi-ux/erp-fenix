from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.pais_service import PaisService

pais_bp = Blueprint('pais', __name__)
service = PaisService()

@pais_bp.route('/pais', methods=['GET'])
@pais_bp.route('/pais/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@pais_bp.route('/pais/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@pais_bp.route('/pais', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@pais_bp.route('/pais', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@pais_bp.route('/pais/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})