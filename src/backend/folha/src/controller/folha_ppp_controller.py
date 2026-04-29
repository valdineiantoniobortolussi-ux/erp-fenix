from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.folha_ppp_service import FolhaPppService

folha_ppp_bp = Blueprint('folha-ppp', __name__)
service = FolhaPppService()

@folha_ppp_bp.route('/folha-ppp', methods=['GET'])
@folha_ppp_bp.route('/folha-ppp/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@folha_ppp_bp.route('/folha-ppp/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@folha_ppp_bp.route('/folha-ppp', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@folha_ppp_bp.route('/folha-ppp', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@folha_ppp_bp.route('/folha-ppp/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})