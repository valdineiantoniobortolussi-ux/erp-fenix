from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.nfe_transporte_volume_lacre_service import NfeTransporteVolumeLacreService

nfe_transporte_volume_lacre_bp = Blueprint('nfe-transporte-volume-lacre', __name__)
service = NfeTransporteVolumeLacreService()

@nfe_transporte_volume_lacre_bp.route('/nfe-transporte-volume-lacre', methods=['GET'])
@nfe_transporte_volume_lacre_bp.route('/nfe-transporte-volume-lacre/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@nfe_transporte_volume_lacre_bp.route('/nfe-transporte-volume-lacre/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@nfe_transporte_volume_lacre_bp.route('/nfe-transporte-volume-lacre', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@nfe_transporte_volume_lacre_bp.route('/nfe-transporte-volume-lacre', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@nfe_transporte_volume_lacre_bp.route('/nfe-transporte-volume-lacre/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})