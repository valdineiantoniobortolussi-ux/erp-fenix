from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.etiqueta_layout_service import EtiquetaLayoutService

etiqueta_layout_bp = Blueprint('etiqueta-layout', __name__)
service = EtiquetaLayoutService()

@etiqueta_layout_bp.route('/etiqueta-layout', methods=['GET'])
@etiqueta_layout_bp.route('/etiqueta-layout/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@etiqueta_layout_bp.route('/etiqueta-layout/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@etiqueta_layout_bp.route('/etiqueta-layout', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@etiqueta_layout_bp.route('/etiqueta-layout', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@etiqueta_layout_bp.route('/etiqueta-layout/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})