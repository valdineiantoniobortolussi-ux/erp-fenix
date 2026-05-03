from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.irrf_service import IrrfService

irrf_bp = Blueprint('irrf', __name__)
service = IrrfService()

@irrf_bp.route('/irrf', methods=['GET'])
@irrf_bp.route('/irrf/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@irrf_bp.route('/irrf/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@irrf_bp.route('/irrf', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@irrf_bp.route('/irrf', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@irrf_bp.route('/irrf/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})