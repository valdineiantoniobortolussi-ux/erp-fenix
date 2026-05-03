from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.frota_combustivel_tipo_service import FrotaCombustivelTipoService

frota_combustivel_tipo_bp = Blueprint('frota-combustivel-tipo', __name__)
service = FrotaCombustivelTipoService()

@frota_combustivel_tipo_bp.route('/frota-combustivel-tipo', methods=['GET'])
@frota_combustivel_tipo_bp.route('/frota-combustivel-tipo/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@frota_combustivel_tipo_bp.route('/frota-combustivel-tipo/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@frota_combustivel_tipo_bp.route('/frota-combustivel-tipo', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@frota_combustivel_tipo_bp.route('/frota-combustivel-tipo', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@frota_combustivel_tipo_bp.route('/frota-combustivel-tipo/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})