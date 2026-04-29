from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.efd_reinf_service import EfdReinfService

efd_reinf_bp = Blueprint('efd-reinf', __name__)
service = EfdReinfService()

@efd_reinf_bp.route('/efd-reinf', methods=['GET'])
@efd_reinf_bp.route('/efd-reinf/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@efd_reinf_bp.route('/efd-reinf/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@efd_reinf_bp.route('/efd-reinf', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@efd_reinf_bp.route('/efd-reinf', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@efd_reinf_bp.route('/efd-reinf/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})