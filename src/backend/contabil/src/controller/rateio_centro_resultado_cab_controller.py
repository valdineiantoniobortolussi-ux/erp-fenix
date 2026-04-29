from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.rateio_centro_resultado_cab_service import RateioCentroResultadoCabService

rateio_centro_resultado_cab_bp = Blueprint('rateio-centro-resultado-cab', __name__)
service = RateioCentroResultadoCabService()

@rateio_centro_resultado_cab_bp.route('/rateio-centro-resultado-cab', methods=['GET'])
@rateio_centro_resultado_cab_bp.route('/rateio-centro-resultado-cab/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@rateio_centro_resultado_cab_bp.route('/rateio-centro-resultado-cab/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@rateio_centro_resultado_cab_bp.route('/rateio-centro-resultado-cab', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@rateio_centro_resultado_cab_bp.route('/rateio-centro-resultado-cab', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@rateio_centro_resultado_cab_bp.route('/rateio-centro-resultado-cab/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})