from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.efd_contribuicoes_service import EfdContribuicoesService

efd_contribuicoes_bp = Blueprint('efd-contribuicoes', __name__)
service = EfdContribuicoesService()

@efd_contribuicoes_bp.route('/efd-contribuicoes', methods=['GET'])
@efd_contribuicoes_bp.route('/efd-contribuicoes/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@efd_contribuicoes_bp.route('/efd-contribuicoes/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@efd_contribuicoes_bp.route('/efd-contribuicoes', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@efd_contribuicoes_bp.route('/efd-contribuicoes', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@efd_contribuicoes_bp.route('/efd-contribuicoes/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})