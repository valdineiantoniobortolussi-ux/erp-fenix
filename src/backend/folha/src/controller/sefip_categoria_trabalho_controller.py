from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.sefip_categoria_trabalho_service import SefipCategoriaTrabalhoService

sefip_categoria_trabalho_bp = Blueprint('sefip-categoria-trabalho', __name__)
service = SefipCategoriaTrabalhoService()

@sefip_categoria_trabalho_bp.route('/sefip-categoria-trabalho', methods=['GET'])
@sefip_categoria_trabalho_bp.route('/sefip-categoria-trabalho/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@sefip_categoria_trabalho_bp.route('/sefip-categoria-trabalho/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@sefip_categoria_trabalho_bp.route('/sefip-categoria-trabalho', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@sefip_categoria_trabalho_bp.route('/sefip-categoria-trabalho', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@sefip_categoria_trabalho_bp.route('/sefip-categoria-trabalho/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})