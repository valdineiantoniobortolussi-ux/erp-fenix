from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.etiqueta_formato_papel_service import EtiquetaFormatoPapelService

etiqueta_formato_papel_bp = Blueprint('etiqueta-formato-papel', __name__)
service = EtiquetaFormatoPapelService()

@etiqueta_formato_papel_bp.route('/etiqueta-formato-papel', methods=['GET'])
@etiqueta_formato_papel_bp.route('/etiqueta-formato-papel/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@etiqueta_formato_papel_bp.route('/etiqueta-formato-papel/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@etiqueta_formato_papel_bp.route('/etiqueta-formato-papel', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@etiqueta_formato_papel_bp.route('/etiqueta-formato-papel', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@etiqueta_formato_papel_bp.route('/etiqueta-formato-papel/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})