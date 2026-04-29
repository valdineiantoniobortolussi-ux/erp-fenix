from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.registro_cartorio_service import RegistroCartorioService

registro_cartorio_bp = Blueprint('registro-cartorio', __name__)
service = RegistroCartorioService()

@registro_cartorio_bp.route('/registro-cartorio', methods=['GET'])
@registro_cartorio_bp.route('/registro-cartorio/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@registro_cartorio_bp.route('/registro-cartorio/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@registro_cartorio_bp.route('/registro-cartorio', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@registro_cartorio_bp.route('/registro-cartorio', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@registro_cartorio_bp.route('/registro-cartorio/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})