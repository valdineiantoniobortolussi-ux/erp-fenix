from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.patrim_bem_service import PatrimBemService

patrim_bem_bp = Blueprint('patrim-bem', __name__)
service = PatrimBemService()

@patrim_bem_bp.route('/patrim-bem', methods=['GET'])
@patrim_bem_bp.route('/patrim-bem/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@patrim_bem_bp.route('/patrim-bem/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@patrim_bem_bp.route('/patrim-bem', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@patrim_bem_bp.route('/patrim-bem', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@patrim_bem_bp.route('/patrim-bem/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})