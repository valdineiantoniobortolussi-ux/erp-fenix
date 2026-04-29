from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.nfe_duplicata_service import NfeDuplicataService

nfe_duplicata_bp = Blueprint('nfe-duplicata', __name__)
service = NfeDuplicataService()

@nfe_duplicata_bp.route('/nfe-duplicata', methods=['GET'])
@nfe_duplicata_bp.route('/nfe-duplicata/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@nfe_duplicata_bp.route('/nfe-duplicata/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@nfe_duplicata_bp.route('/nfe-duplicata', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@nfe_duplicata_bp.route('/nfe-duplicata', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@nfe_duplicata_bp.route('/nfe-duplicata/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})