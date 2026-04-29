from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.gondola_rua_service import GondolaRuaService

gondola_rua_bp = Blueprint('gondola-rua', __name__)
service = GondolaRuaService()

@gondola_rua_bp.route('/gondola-rua', methods=['GET'])
@gondola_rua_bp.route('/gondola-rua/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@gondola_rua_bp.route('/gondola-rua/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@gondola_rua_bp.route('/gondola-rua', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@gondola_rua_bp.route('/gondola-rua', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@gondola_rua_bp.route('/gondola-rua/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})