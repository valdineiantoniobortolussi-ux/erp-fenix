from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.tribut_icms_custom_cab_service import TributIcmsCustomCabService

tribut_icms_custom_cab_bp = Blueprint('tribut-icms-custom-cab', __name__)
service = TributIcmsCustomCabService()

@tribut_icms_custom_cab_bp.route('/tribut-icms-custom-cab', methods=['GET'])
@tribut_icms_custom_cab_bp.route('/tribut-icms-custom-cab/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@tribut_icms_custom_cab_bp.route('/tribut-icms-custom-cab/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@tribut_icms_custom_cab_bp.route('/tribut-icms-custom-cab', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@tribut_icms_custom_cab_bp.route('/tribut-icms-custom-cab', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@tribut_icms_custom_cab_bp.route('/tribut-icms-custom-cab/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})