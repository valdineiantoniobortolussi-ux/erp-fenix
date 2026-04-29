from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.sped_contabil_service import SpedContabilService

sped_contabil_bp = Blueprint('sped-contabil', __name__)
service = SpedContabilService()

@sped_contabil_bp.route('/sped-contabil', methods=['GET'])
@sped_contabil_bp.route('/sped-contabil/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@sped_contabil_bp.route('/sped-contabil/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@sped_contabil_bp.route('/sped-contabil', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@sped_contabil_bp.route('/sped-contabil', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@sped_contabil_bp.route('/sped-contabil/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})