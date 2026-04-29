from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.frota_veiculo_tipo_service import FrotaVeiculoTipoService

frota_veiculo_tipo_bp = Blueprint('frota-veiculo-tipo', __name__)
service = FrotaVeiculoTipoService()

@frota_veiculo_tipo_bp.route('/frota-veiculo-tipo', methods=['GET'])
@frota_veiculo_tipo_bp.route('/frota-veiculo-tipo/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@frota_veiculo_tipo_bp.route('/frota-veiculo-tipo/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@frota_veiculo_tipo_bp.route('/frota-veiculo-tipo', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@frota_veiculo_tipo_bp.route('/frota-veiculo-tipo', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@frota_veiculo_tipo_bp.route('/frota-veiculo-tipo/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})