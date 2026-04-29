from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.sindicato_service import SindicatoService

sindicato_bp = Blueprint('sindicato', __name__)
service = SindicatoService()

@sindicato_bp.route('/sindicato', methods=['GET'])
@sindicato_bp.route('/sindicato/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@sindicato_bp.route('/sindicato/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@sindicato_bp.route('/sindicato', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@sindicato_bp.route('/sindicato', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@sindicato_bp.route('/sindicato/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})