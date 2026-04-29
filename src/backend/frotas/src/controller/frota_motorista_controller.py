from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.frota_motorista_service import FrotaMotoristaService

frota_motorista_bp = Blueprint('frota-motorista', __name__)
service = FrotaMotoristaService()

@frota_motorista_bp.route('/frota-motorista', methods=['GET'])
@frota_motorista_bp.route('/frota-motorista/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@frota_motorista_bp.route('/frota-motorista/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@frota_motorista_bp.route('/frota-motorista', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@frota_motorista_bp.route('/frota-motorista', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@frota_motorista_bp.route('/frota-motorista/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})