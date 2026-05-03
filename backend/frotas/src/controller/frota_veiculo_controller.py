from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.frota_veiculo_service import FrotaVeiculoService

frota_veiculo_bp = Blueprint('frota-veiculo', __name__)
service = FrotaVeiculoService()

@frota_veiculo_bp.route('/frota-veiculo', methods=['GET'])
@frota_veiculo_bp.route('/frota-veiculo/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@frota_veiculo_bp.route('/frota-veiculo/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@frota_veiculo_bp.route('/frota-veiculo', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@frota_veiculo_bp.route('/frota-veiculo', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@frota_veiculo_bp.route('/frota-veiculo/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})