from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.cargo_service import CargoService

cargo_bp = Blueprint('cargo', __name__)
service = CargoService()

@cargo_bp.route('/cargo', methods=['GET'])
@cargo_bp.route('/cargo/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@cargo_bp.route('/cargo/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@cargo_bp.route('/cargo', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@cargo_bp.route('/cargo', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@cargo_bp.route('/cargo/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})