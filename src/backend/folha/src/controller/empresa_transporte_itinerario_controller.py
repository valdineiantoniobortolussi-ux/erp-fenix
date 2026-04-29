from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.empresa_transporte_itinerario_service import EmpresaTransporteItinerarioService

empresa_transporte_itinerario_bp = Blueprint('empresa-transporte-itinerario', __name__)
service = EmpresaTransporteItinerarioService()

@empresa_transporte_itinerario_bp.route('/empresa-transporte-itinerario', methods=['GET'])
@empresa_transporte_itinerario_bp.route('/empresa-transporte-itinerario/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@empresa_transporte_itinerario_bp.route('/empresa-transporte-itinerario/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@empresa_transporte_itinerario_bp.route('/empresa-transporte-itinerario', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@empresa_transporte_itinerario_bp.route('/empresa-transporte-itinerario', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@empresa_transporte_itinerario_bp.route('/empresa-transporte-itinerario/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})