from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.seguradora_service import SeguradoraService

seguradora_bp = Blueprint('seguradora', __name__)
service = SeguradoraService()

@seguradora_bp.route('/seguradora', methods=['GET'])
@seguradora_bp.route('/seguradora/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@seguradora_bp.route('/seguradora/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@seguradora_bp.route('/seguradora', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@seguradora_bp.route('/seguradora', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@seguradora_bp.route('/seguradora/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})