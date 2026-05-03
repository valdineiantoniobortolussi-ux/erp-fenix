from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.tribut_configura_of_gt_service import TributConfiguraOfGtService

tribut_configura_of_gt_bp = Blueprint('tribut-configura-of-gt', __name__)
service = TributConfiguraOfGtService()

@tribut_configura_of_gt_bp.route('/tribut-configura-of-gt', methods=['GET'])
@tribut_configura_of_gt_bp.route('/tribut-configura-of-gt/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@tribut_configura_of_gt_bp.route('/tribut-configura-of-gt/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@tribut_configura_of_gt_bp.route('/tribut-configura-of-gt', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@tribut_configura_of_gt_bp.route('/tribut-configura-of-gt', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@tribut_configura_of_gt_bp.route('/tribut-configura-of-gt/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})