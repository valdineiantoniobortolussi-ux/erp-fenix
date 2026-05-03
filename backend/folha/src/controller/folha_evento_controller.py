from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.folha_evento_service import FolhaEventoService

folha_evento_bp = Blueprint('folha-evento', __name__)
service = FolhaEventoService()

@folha_evento_bp.route('/folha-evento', methods=['GET'])
@folha_evento_bp.route('/folha-evento/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@folha_evento_bp.route('/folha-evento/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@folha_evento_bp.route('/folha-evento', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@folha_evento_bp.route('/folha-evento', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@folha_evento_bp.route('/folha-evento/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})