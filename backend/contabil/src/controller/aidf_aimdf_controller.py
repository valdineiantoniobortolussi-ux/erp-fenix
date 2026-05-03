from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.aidf_aimdf_service import AidfAimdfService

aidf_aimdf_bp = Blueprint('aidf-aimdf', __name__)
service = AidfAimdfService()

@aidf_aimdf_bp.route('/aidf-aimdf', methods=['GET'])
@aidf_aimdf_bp.route('/aidf-aimdf/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@aidf_aimdf_bp.route('/aidf-aimdf/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@aidf_aimdf_bp.route('/aidf-aimdf', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@aidf_aimdf_bp.route('/aidf-aimdf', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@aidf_aimdf_bp.route('/aidf-aimdf/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})